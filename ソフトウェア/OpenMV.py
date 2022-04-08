import sensor, image, time, pyb, ustruct, ulab
from ulab import numpy as np

thresholds = [
  #(0, 100, 6, 127, -128, 127) # 青
  (0, 100, -128, 127, 47, 127) # 黄
]

usb = pyb.USB_VCP()

red_led = pyb.LED(1)
green_led = pyb.LED(2)
blue_led = pyb.LED(3)

blue_led.on()

Range = (0,140,320,120)

sensor.reset()
sensor.set_pixformat(sensor.RGB565)
sensor.set_framesize(sensor.QVGA)
#sensor.set_saturation(3)
sensor.set_contrast(3)
sensor.set_brightness(1)
sensor.set_vflip(True)
sensor.set_hmirror(True)
sensor.skip_frames(30)
sensor.set_auto_gain(False)
sensor.set_auto_whitebal(False)

white = (255,255,255)
black = (0,0,0)
red = (255,0,0)
maxrect = 0

isFindGoal = False
objNUM = 0

x_data = 0
y_data = 0
uart = pyb.UART(3, 19200,timeout_char=1000)
clock = time.clock()

def LEDerr():
    for i in range(5):
        red_led.on()
        blue_led.on()
        pyb.delay(100)
        red_led.off()
        blue_led.off()
        pyb.delay(100)
    pyb.delay(200)

blue_led.toggle()

while(True):
    try:
        clock.tick()
        rectarray = []
        img = sensor.snapshot()

        for blob in img.find_blobs(thresholds, pixel_threshold = 100, area_threshold = 100, merge = True, margin = 5):
            rectarray.append(list(blob.rect()))

        try:
            maxrect = max(rectarray,key=lambda x: x[2]*x[3])
            x_data = maxrect[0]+(maxrect[2]/2)
            y_data = maxrect[1]+(maxrect[3]/2)

        except ValueError as err:
            #print(err)

        try:
            if len(img.find_blobs(thresholds, pixel_threshold = 100, area_threshold = 100, merge = True, margin = 5)) == 0:
                x = 100
                isFindGoal = False

            else:
                x = int((x_data / 320) * 70.8)
                y = int(((y_data - 240) / -240) * 55.6)
                isFindGoal = True

            if usb.isconnected():
                if(isFindGoal):
                    img.draw_string(10, 10, "X : %d Y : %d" % (x, y), white, scale = 2, mono_space = False)
                    img.draw_rectangle(maxrect,white)
                    img.draw_cross(int(x_data),int(y_data),black)
                    green_led.on()
                    red_led.off()
                else:
                    img.draw_string(10, 10,"Object not found", scale = 2, mono_space = False)
                    red_led.on()
                    green_led.off()

            uart.write(ustruct.pack('B',x))

        except OSError as err:
            pass

    except RuntimeError as err:
        LEDerr()
        if usb.isconnected():
            print(err)
