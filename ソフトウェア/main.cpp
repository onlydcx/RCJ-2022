#include "Arduino.h"
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#include <MPU6050_6Axis_MotionApps20.h>
#include <CytronMotorDriver.h>

#define LeftPin 33
#define RightPin 27

#define OpenMV Serial7


#define SCREEN_WIDTH 128
#define SCREEN_HEIGHT 64

#define SIZE_OF_ARRAY(array) (sizeof(array) / sizeof(array[0]))

#define OLED_RESET 4
#define SCREEN_ADDRESS 0x3C

#define w display.width()
#define h display.height()

#define LeftPush isPush(30)
#define CenterPush isPush(33)
#define OnOffPush isPush(31)
#define RightPush isPush(27)
#define AnyPush (LeftPush || CenterPush || OnOffPush || RightPush)

#define isOnFront (isOnLine(1,0) || isOnLine(1,1)) // 前 (中,外)
#define isOnRight (isOnLine(0,0) || isOnLine(0,1)) // 右 (外,中)
#define isOnBack (isOnLine(2,0) || isOnLine(2,1)) // 後 (外,中)
#define isOnLeft (isOnLine(3,0) || isOnLine(3,1)) // 左 (外,中)

#define isOutFront isOnLine(1,1)
#define isOutRight isOnLine(0,0)
#define isOutBack isOnLine(2,0)
#define isOutLeft isOnLine(3,0)

#define isInFront isOnLine(1,0)
#define isInRight isOnLine(0,1)
#define isInBack isOnLine(2,1)
#define isInLeft isOnLine(3,1)

#define isOnOut (isOnLine(1,1) || isOnLine(0,0) || isOnLine(2,0) || isOnLine(3,0))
#define isOnIn (isOnLine(1,0) || isOnLine(0,1) || isOnLine(2,1) || isOnLine(3,1))

#define isOnAny (isOnOut || isOnIn)

CytronMD motor1(PWM_DIR, 5, 4);
CytronMD motor2(PWM_DIR, 3, 2);
CytronMD motor3(PWM_DIR, 9, 8);
CytronMD motor4(PWM_DIR, 7, 6);

Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET);

MPU6050 mpu;
static uint8_t mpuIntStatus;
static bool dmpReady = false;
static uint16_t packetSize;
int16_t Gyro_Now = 0, Gyro = 0, Gyro_Offset = 0;
uint16_t fifoCount;
uint8_t fifoBuffer[64];
Quaternion q;
VectorFloat gravity;
float ypr[3];
int Gyro_X, Gyro_Y, Gyro_Z, Accel_Z;

int speed = 150;
bool isFirstSetSpeed = true;

int ave_motor_power[4][10] = {0};
int ave_mpPlus = 0;

int prevIR, dirPlus, cnt;
int dirIR = 0;

int getCam() {
   int re = 0;
   if (OpenMV.available()) {
      int a = OpenMV.read();
      if (a >= 0 && a <= 70) {
         re = a;
      }
      else {
         re = 0;
      }
   }
   return re;
}

int getDx(String txt) {
   int char_len = txt.length();
   return (display.width() / 2) - ((char_len / 2) * 11);
}

int GyroGet(void) {
   mpuIntStatus = false;
   mpuIntStatus = mpu.getIntStatus();
   fifoCount = mpu.getFIFOCount();

   if ((mpuIntStatus & 0x10) || fifoCount == 1024) {
      mpu.resetFIFO();
   }
   else if (mpuIntStatus & 0x02) {
      while (fifoCount < packetSize) {
         fifoCount = mpu.getFIFOCount();
      }
      mpu.getFIFOBytes(fifoBuffer, packetSize);
      fifoCount -= packetSize;
      mpu.dmpGetQuaternion(&q, fifoBuffer);
      mpu.dmpGetGravity(&gravity, &q);
      mpu.dmpGetYawPitchRoll(ypr, &q, &gravity);
      Gyro_Now = degrees(ypr[0]) + 180;
      Gyro = Gyro_Now + Gyro_Offset - 180;
      if (Gyro < 0) {
         Gyro += 360;
      }
      if (Gyro > 359) {
         Gyro -= 360;
      }
   }
   return Gyro;
}

void Gryo_init() {
   mpu.initialize();
   if (mpu.testConnection() != true) {
      Serial.println("MPU disconection");
   }
   if (mpu.dmpInitialize() != 0) {
      Serial.println("MPU break");
   }
   mpu.setXGyroOffset(Gyro_X);
   mpu.setYGyroOffset(Gyro_Y);
   mpu.setZGyroOffset(Gyro_Z);
   mpu.setZAccelOffset(Accel_Z);
   mpu.setDMPEnabled(true);
   mpuIntStatus = mpu.getIntStatus();
   dmpReady = true;
   packetSize = mpu.dmpGetFIFOPacketSize();
}

void selectGyro(int number) {
   switch (number) {
      case 0:
         Gyro_X = -93, Gyro_Y = 77, Gyro_Z = 10, Accel_Z = 1561;
         break;
      case 1:
         Gyro_X = 114, Gyro_Y = 61, Gyro_Z = 95, Accel_Z = 1719;
         break;
      case 2:
         Gyro_X = -118, Gyro_Y = 22, Gyro_Z = -61, Accel_Z = 797;
         break;
      case 3:
         Gyro_X = -364, Gyro_Y = -29, Gyro_Z = 9, Accel_Z = 1846;
         break;
      case 4:
         Gyro_X = 50, Gyro_Y = 22, Gyro_Z = 12, Accel_Z = 1347;
         break;
      default:
         Serial.println("error in selectGyro()");
         Gyro_X = 0, Gyro_Y = 0, Gyro_Z = 0, Accel_Z = 0;
         break;
   }
}

int getVah(int f) {
   byte val = 0;
   Wire.beginTransmission(0x0E);
   Wire.write(f);
   Wire.endTransmission();
   // Wire.endTransmission(false); // falseの方が良いらしい...?
   Wire.requestFrom(0x0E, 1);
   while (Wire.available()) {
      val = Wire.read();
   }
   return (int)val;
}

int IRval(int i) {
   int a = getVah(0x04);
   int b = getVah(0x05);
   int c = getVah(0x06);
   int d = getVah(0x07);
   int re_angle;
   int re_strength;

   if (d < 10) {
      re_angle = a;
      re_strength = b;
   }
   else {
      re_angle = c;
      re_strength = d;
   }

   if(i != 1) {
      return re_strength;
   }
   else {
      return re_angle*5;
   }
}

bool isPush(int num) {
   if (digitalRead(num)) {
      while (digitalRead(num)) {
         if (!digitalRead(num)) {
            break;
         }
      }
      return 1;
   }
   else {
      return 0;
   }
}

void display_init() {
   if (!display.begin(SSD1306_SWITCHCAPVCC, SCREEN_ADDRESS)) {
      Serial.println(F("SSD1306 allocation failed"));
      // for (;;) ;
   }
}

void printKick() {
   String txt = "Kick Test";
   int char_len = txt.length();
   int drawX = (display.width() / 2) - ((char_len / 2) * 13);
   display.clearDisplay();
   display.setTextSize(2);
   display.setTextColor(SSD1306_WHITE);
   display.setCursor(drawX, 20);
   display.println(txt);
   display.display();
}

void printIR() {
   int cx = w / 4, cy = h / 2, r = 18;
   float deg = IRval(1), Rad;
   display.clearDisplay();
   Rad = (deg - 90) / (180 / PI);
   display.drawCircle(cx, cy, w / 12, SSD1306_WHITE);
   display.drawCircle(cx, cy, w / 5, SSD1306_WHITE);
   display.fillCircle(cx + r * cos(Rad), cy + r * sin(Rad), 3, 1);
   display.drawLine(cx, 0, cx, h, SSD1306_WHITE);
   display.drawLine(0, cy, cx * 2, cy, SSD1306_WHITE);
   display.setTextSize(2);
   display.setTextColor(SSD1306_WHITE);
   display.setCursor(w / 2 + 10, 10);
   display.println("Ball");
   display.setTextSize(2);
   display.setTextColor(SSD1306_WHITE);
   display.setCursor(w / 2 + 10, h / 2 + 5);
   display.println((int)deg);
   display.display();
}

int analogPins[4][2] = {
   {0, 1}, {2, 3}, {6, 7}, {8, 9}
};

int thresholds[4][2] = {
   {1023, 1023},
   {1023, 1023},
   {1023, 1023},
   {1023, 1023}
};

int LineMin[4][2] = {1023};
int LineMax[4][2] = {0};

void LineThUpdate() {
   String txt = "Update";
   display.clearDisplay();
   display.setTextSize(2);
   display.setTextColor(SSD1306_WHITE);
   display.setCursor(getDx(txt), 30);
   display.println(txt);
   display.display();
   if(OnOffPush) {
      txt = "Updating";
      display.clearDisplay();
      display.setTextSize(2);
      display.setTextColor(SSD1306_WHITE);
      display.setCursor(getDx(txt), 30);
      display.println(txt);
      display.display();
      while(!OnOffPush) {
         for(int i = 0; i < 4; i++) {
            for(int j = 0; j < 2; j++) {
               int val = analogRead(analogPins[i][j]);
               if(val < LineMin[i][j]) {
                  LineMin[i][j] = val;
               }
               if(val > LineMax[i][j]) {
                  LineMax[i][j] = val;
               }
            }
         }
      }
      for(int i = 0; i < 4; i++) {
         for(int j = 0; j < 2; j++) {
            int border = 2;
            int add = -50;
            int diff = abs(LineMax[i][j] - LineMin[i][j]);
            int threshold = LineMax[i][j] - (diff / border);
            thresholds[i][j] = threshold + add;
         }
      }
      txt = "done";
      display.clearDisplay();
      display.setTextSize(2);
      display.setTextColor(SSD1306_WHITE);
      display.setCursor(getDx(txt), 30);
      display.println(txt);
      display.display();
      delay(500);
   }
}

int getLine(int i, int j) {
   return analogRead(analogPins[i][j]);
}

bool isOnLine(int i, int j) {
   return (analogRead(analogPins[i][j]) > thresholds[i][j])? true: false;
}

void printLine() {
   int cx = w/4, cy = h/2;
   display.clearDisplay();
   int paddingC = 10, paddingI = 3;
   int r = w / 5;
   display.drawCircle(cx, cy, r, SSD1306_WHITE);
   display.drawLine(cx, paddingC, cx, cy - paddingI, SSD1306_WHITE);
   display.drawLine(cx, cy + paddingI, cx, h - paddingC, SSD1306_WHITE);
   display.drawLine(paddingC, cy, cx - paddingI, cy, SSD1306_WHITE);
   display.drawLine(cx + paddingI, cy, cx * 2 - paddingC, cy, SSD1306_WHITE);
   String isOnTXT = "";
   if(isOnFront) {
      display.fillRect(cx-2, 10, 5, r-5, SSD1306_WHITE);
      isOnTXT += "F";
   }
   if(isOnRight) {
      display.fillRect(cx+3, cy-2, r-5, 5, SSD1306_WHITE);
      isOnTXT += "R";
   }
   if(isOnBack) {
      display.fillRect(cx-2, cy+3, 5, r-5, SSD1306_WHITE);
      isOnTXT += "B";
   }
   if(isOnLeft) {
      display.fillRect(10, cy-2, r-5, 5, SSD1306_WHITE);
      isOnTXT += "L";
   }
   display.setTextColor(SSD1306_WHITE);
   display.setTextSize(2);
   display.setCursor(w/2 + 10, 10);
   display.println("Line");
   display.setTextSize(2);
   display.setTextColor(SSD1306_WHITE);
   display.setCursor(w / 2 + 10, h / 2 + 5);
   display.println(isOnTXT);
   display.display();
}

int speed_status = 0;
bool speed_isPushed = false;

String speed_mode[] = {"0", "10", "50", "100", "150", "170", "200", "220", "250"};
int speed_mode_len = SIZE_OF_ARRAY(speed_mode);

void changeSpeed() {
   if (LeftPush) {
      speed_isPushed = true;
      if ((speed_status <= speed_mode_len - 1) && (speed_status >= 1)) {
         speed_status--;
      }
   }
   if (RightPush) {
      speed_isPushed = true;
      if ((speed_status <= speed_mode_len - 2) && (speed_status >= 0)) {
         speed_status++;
      }
   }
   if (speed_isPushed) {
      display.clearDisplay();
      if (speed_status <= speed_mode_len - 2) {
         display.drawTriangle(90, 45, 90, 55, 100, 50, SSD1306_WHITE);
      }
      if (speed_status >= 1) {
         display.drawTriangle(34, 45, 34, 55, 24, 50, SSD1306_WHITE);
      }
      int char_len = speed_mode[speed_status].length();
      int drawX = (display.width() / 2) - ((char_len / 2) * 11);
      display.setTextSize(2);
      display.setTextColor(SSD1306_WHITE);
      display.setCursor(drawX, 7);
      display.println(speed_mode[speed_status]);
      display.drawLine(0, 32, 128, 32, SSD1306_WHITE);
      display.display();
      speed = atoi((speed_mode[speed_status]).c_str());
   }
}

void printIMU() {
   int cx = w / 4, cy = h / 2, r = 21;
   float deg = GyroGet(), Rad;
   display.clearDisplay();
   Rad = (deg - 90) / (180 / PI);
   display.drawCircle(cx, cy, w / 6, SSD1306_WHITE);
   display.fillCircle(cx + r * cos(Rad), cy + r * sin(Rad), 3, 1);
   display.drawLine(cx, 0, cx, h, SSD1306_WHITE);
   display.drawLine(0, cy, cx * 2, cy, SSD1306_WHITE);
   display.setTextSize(2);
   display.setTextColor(SSD1306_WHITE);
   display.setCursor(w / 2 + 10, 10);
   display.println("Gyro");
   display.setTextSize(2);
   display.setTextColor(SSD1306_WHITE);
   display.setCursor(w / 2 + 10, h / 2 + 5);
   display.println((int)deg);
   display.display();
}

void RST_Gy() {
   String txt = "RST Gyro";
   int char_len = txt.length();
   int drawX = (display.width() / 2) - ((char_len / 2) * 11);
   display.clearDisplay();
   display.setTextSize(2);
   display.setTextColor(SSD1306_WHITE);
   display.setCursor(drawX, 30);
   display.println(txt);
   display.display();
   if(OnOffPush) {
      String txt = "Reseting";
      int char_len = txt.length();
      int drawX = (display.width() / 2) - ((char_len / 2) * 11);
      display.clearDisplay();
      display.setTextSize(2);
      display.setTextColor(SSD1306_WHITE);
      display.setCursor(drawX, 30);
      display.println(txt);
      display.display();
      Gryo_init();
      delay(100);
   }
}

void motorStop() {
   motor1.setSpeed(0);
   motor2.setSpeed(0);
   motor3.setSpeed(0);
   motor4.setSpeed(0);
}

void motor(int angle) {

   double motor_power[4];
   double max_power; // ????

   motor_power[0] = cos((45 - angle) / 180.0 * PI);
   motor_power[1] = cos((135 - angle) / 180.0 * PI);
   motor_power[2] = cos((-45 - angle) / 180.0 * PI);
   motor_power[3] = cos((-135 - angle) / 180.0 * PI);

   for (int i = 0; i < 4; i++) {
      if (abs(motor_power[i]) > max_power) {
         max_power = abs(motor_power[i]);
      }
   }

   for (int i = 0; i < 4; i++) {
      motor_power[i] = speed * motor_power[i] / max_power;
      for (int j = 9; j > 0; j--) {
         ave_motor_power[i][j] = ave_motor_power[i][j - 1];
      }
      ave_motor_power[i][0] = motor_power[i];
      ave_mpPlus = 0;
      for (int k = 0; k < 10; k++) {
         ave_mpPlus = ave_mpPlus + ave_motor_power[i][k];
      }
      motor_power[i] = ave_mpPlus / 10;
   }
   motor1.setSpeed(-motor_power[1]);
   motor2.setSpeed(motor_power[0]);
   motor3.setSpeed(motor_power[2]);
   motor4.setSpeed(motor_power[3]);
}

void lightMotor(int angle) {
   double motor_power[4];
   double max_power; // ????

   motor_power[0] = cos((45 - angle) / 180.0 * PI);
   motor_power[1] = cos((135 - angle) / 180.0 * PI);
   motor_power[2] = cos((-45 - angle) / 180.0 * PI);
   motor_power[3] = cos((-135 - angle) / 180.0 * PI);

   for (int i = 0; i < 4; i++) {
      if (abs(motor_power[i]) > max_power) {
         max_power = abs(motor_power[i]);
      }
   }

   for (int i = 0; i < 4; i++) {
      motor_power[i] = speed * motor_power[i] / max_power;
   }

   motor1.setSpeed(-motor_power[1]);
   motor2.setSpeed(motor_power[0]);
   motor3.setSpeed(motor_power[2]);
   motor4.setSpeed(motor_power[3]);
}

void kick() {
   digitalWrite(10, HIGH);
   delay(100);
   digitalWrite(10, LOW);
   delay(100);
}

void followBall() {
   int diff = 10;
   int S = 50;
   int MAX = 150;
   int GY = GyroGet();
   if(GY >= diff && GY < 90) {
      motor1.setSpeed(S);
      motor2.setSpeed(S);
      motor3.setSpeed(-S);
      motor4.setSpeed(S);
   }
   else if(GY >= 90 && GY < 180) {
      motor1.setSpeed(MAX);
      motor2.setSpeed(MAX);
      motor3.setSpeed(-MAX);
      motor4.setSpeed(MAX);
   }
   else if(GY >= 180 && GY < 275) {
      motor1.setSpeed(-MAX);
      motor2.setSpeed(-MAX);
      motor3.setSpeed(MAX);
      motor4.setSpeed(-MAX);
   }
   else if(GY >= 275 && GY < 360 - diff) {
      motor1.setSpeed(-S);
      motor2.setSpeed(-S);
      motor3.setSpeed(S);
      motor4.setSpeed(-S);
   }
   else {
      int dlTime = 300;
      if(isOnFront) {
         motorStop();
         delay(100);
         lightMotor(180);
         delay(dlTime);
      }
      if(isOnRight) {
         motorStop();
         delay(100);
         lightMotor(270);
         delay(dlTime);
      }
      if(isOnBack) {
         motorStop();
         delay(100);
         lightMotor(0);
         delay(dlTime);
      }      
      if(isOnLeft) {
         motorStop();
         delay(100);
         lightMotor(90);
         delay(dlTime);
      }
      else {
         dirIR = IRval(1);
         if (abs(prevIR - dirIR) > 30) {
            cnt++;
            if (cnt == 5) {
               cnt = 0;
               prevIR = dirIR;
            }
            else {
               dirIR = prevIR;
            }
         }
         else {
            cnt = 0;
            prevIR = dirIR;
         }

         int IR = dirIR;
         if(IR == 0 || IR == 5 || IR == 355) {
            motor(0);
         }
         else if (IR <= 10 || IR >= 350){
            motor(IR);
         }
         else {
            if (IR <= 180){
               motor(IR + 50);
            }
            else {
               motor(IR - 50);
            }
         }
      }
   }
}

void followBall2() {
   int diff = 10;
   int S = 50;
   int MAX = 150;
   int GY = GyroGet();
   if(GY >= diff && GY < 90) {
      motor1.setSpeed(S);
      motor2.setSpeed(S);
      motor3.setSpeed(-S);
      motor4.setSpeed(S);
   }
   else if(GY >= 90 && GY < 180) {
      motor1.setSpeed(MAX);
      motor2.setSpeed(MAX);
      motor3.setSpeed(-MAX);
      motor4.setSpeed(MAX);
   }
   else if(GY >= 180 && GY < 275) {
      motor1.setSpeed(-MAX);
      motor2.setSpeed(-MAX);
      motor3.setSpeed(MAX);
      motor4.setSpeed(-MAX);
   }
   else if(GY >= 275 && GY < 360 - diff) {
      motor1.setSpeed(-S);
      motor2.setSpeed(-S);
      motor3.setSpeed(S);
      motor4.setSpeed(-S);
   }
   else {
      dirIR = IRval(1);
      if (abs(prevIR - dirIR) > 30) {
         cnt++;
         if (cnt == 5) {
            cnt = 0;
            prevIR = dirIR;
         }
         else {
            dirIR = prevIR;
         }
      }
      else {
         cnt = 0;
         prevIR = dirIR;
      }
      int IR = dirIR;

      if(isOnFront) {
         lightMotor(180);
         delay(300);
         // while(isOnFront) {
         //    lightMotor(180);
         // }
         int time = millis();
         while(((millis() - time) < 3000) && (IR <= 90 || IR >= 270)) {
            motorStop();
            dirIR = IRval(1);
            if (abs(prevIR - dirIR) > 30) {
               cnt++;
               if (cnt == 5) {
                  cnt = 0;
                  prevIR = dirIR;
               }
               else {
                  dirIR = prevIR;
               }
            }
            else {
               cnt = 0;
               prevIR = dirIR;
            }
            if(dirIR >= 90 && dirIR <= 270) {
               break;
            }
         }
      }

      if (IR <= 30 || IR >= 330){
         motor(IR);
      }
      else {
         if (IR <= 180){
            motor(IR + 50);
         }
         else {
            motor(IR - 50);
         }
      }


      //    dirIR = IRval(1);
      //    if (abs(prevIR - dirIR) > 30) {
      //       cnt++;
      //       if (cnt == 5) {
      //          cnt = 0;
      //          prevIR = dirIR;
      //       }
      //       else {
      //          dirIR = prevIR;
      //       }
      //    }
      //    else {
      //       cnt = 0;
      //       prevIR = dirIR;
      //    }

      //    int IR = dirIR;
      // // int IR = IRval(1);
      // int toMove = -90;
      // if (IR <= 30 || IR >= 330){
      //    toMove = IR;
      // }
      // else {
      //    if (IR <= 180){
      //       toMove = IR + 50;
      //    }
      //    else {
      //       toMove = IR - 50;
      //    }
      // }
      // double rad = toMove * PI / 180.0;
      // double y = cos(rad), x = sin(rad);
      // if(isOutFront && (y > 0.0)) {
      //    y = 0.0;
      // }
      // if(isOutRight && (x > 0.0)) {
      //    x = 0.0;
      // }
      // if(isOutBack && (y < 0.0)) {
      //    y = 0.0;
      // }
      // if(isOutLeft && (x < 0.0)) {
      //    x = 0.0;
      // }
      // char debug[64];
      // sprintf(debug,"x = %lf y = %lf",x,y);
      // // Serial.println(debug);
      // double result = atan2(x,y);
      // result = result * (180 / PI);
      // if(result < 0) {
      //    result += 360;
      // }
      // // Serial.println(result);
      // if(isOnIn) {
      //    motorStop();
      // }
      // else {
      //    motor(round(result));
      // }
   }
}

String mode[] = {"Main", "Ball", "Gyro", "Kick", "Speed", "RST Gyro","LineCheck","LineThUp"};
int mode_len = SIZE_OF_ARRAY(mode);

void setup() {
   pinMode(27, INPUT);
   pinMode(33, INPUT);
   pinMode(34, INPUT);
   pinMode(35, INPUT);
   pinMode(10, OUTPUT);
   Serial.begin(9600);
   Wire.begin();
   display_init();
   selectGyro(3);
   Gryo_init();
   int len = 8;
   int drawX = (display.width() / 2) - ((len / 2) * 12);
   display.clearDisplay();
   display.setTextSize(2);
   display.setTextColor(SSD1306_WHITE);
   display.setCursor(drawX, 10);
   display.println("Main.cpp");
   display.display();
}

int status = 0;
bool isPushed = false;

void loop() {
   if (LeftPush) {
      isPushed = true;
      if ((status <= mode_len - 1) && (status >= 1)) {
         status--;
      }
   }
   if (RightPush) {
      isPushed = true;
      if ((status <= mode_len - 2) && (status >= 0)) {
         status++;
      }
   }
   if (CenterPush) {
      switch (status) {
         case 0:
            display.clearDisplay();
            display.display();
            while(!CenterPush) {
               followBall2();
            }
            motorStop();
            break;
         case 1:
            while (!CenterPush) {
               printIR();
            }
            break;
         case 2:
            while (!CenterPush) {
               printIMU();
            }
            break;
         case 3:
            while (!CenterPush) {
               printKick();
               if (digitalRead(31)) {
                  kick();
               }
            }
            break;
         case 4:
            if (isFirstSetSpeed) {
               int char_len = ((String)speed).length();
               int drawX = (display.width() / 2) - ((char_len / 2) * 11);
               display.clearDisplay();
               display.setTextSize(2);
               display.setTextColor(SSD1306_WHITE);
               display.setCursor(drawX, 7);
               display.println(speed);
               display.drawLine(0, 32, 128, 32, SSD1306_WHITE);
               if (atoi((speed_mode[0]).c_str()) < speed) {
                  display.drawTriangle(90, 45, 90, 55, 100, 50, SSD1306_WHITE);
               }
               if (atoi((speed_mode[speed_mode_len - 1]).c_str()) > speed) {
                  display.drawTriangle(34, 45, 34, 55, 24, 50, SSD1306_WHITE);
               }
               for (int i = 0; i < speed_mode_len; i++) {
                  if (atoi((speed_mode[i]).c_str()) == speed) {
                     speed_status = i + 1;
                     break;
                  }
                  if (atoi((speed_mode[i]).c_str()) > speed) {
                     speed_status = i;
                     break;
                  }
               }
               speed = atoi((speed_mode[speed_status]).c_str());
               display.display();
               isFirstSetSpeed = !isFirstSetSpeed;
            }
            while (!CenterPush) {
               changeSpeed();
            }
            break;
         case 5:
            while (!CenterPush) {
               RST_Gy();
            }
            break;
         case 6:
            while (!CenterPush) {
               printLine();
            }
            break;
         case 7:
            while (!CenterPush) {
               LineThUpdate();
            }
            break;
         default:
            break;
      }
   }
   if (isPushed) {
      int char_len = mode[status].length();
      int drawX = (display.width() / 2) - ((char_len / 2) * 12);
      display.clearDisplay();
      display.setTextSize(2);
      display.setTextColor(SSD1306_WHITE);
      display.setCursor(drawX, 7);
      display.println(mode[status]);
      display.drawLine(0, 32, 128, 32, SSD1306_WHITE);
      if (status <= mode_len - 2) {
         display.drawTriangle(90, 45, 90, 55, 100, 50, SSD1306_WHITE);
      }
      if (status >= 1) {
         display.drawTriangle(34, 45, 34, 55, 24, 50, SSD1306_WHITE);
      }
      display.display();
   }
}
