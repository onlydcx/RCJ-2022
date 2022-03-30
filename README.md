# このプロジェクトについて
ロボカップジュニア2022に出場する機体の全データです。要はオープンソースです。

需要があるかは分かりませんが、公開すること自体が大事だと思うので公開します

# 3Dデータ
3Dデータ フォルダに入ってます。

Autodesk Fusion360で作成しました、f3zファイルなのでFusionでしか開けないと思います。

# ソフトウェア
PlatfomIOで開発しています。

必要なplatformio.iniとmain.cppだけ載せておきます。

質問とかあったらTwitterでDMしてください

# 基板データ
基板データ フォルダに入ってます。
- CamBoard メイン基板のデータです。OpenMV,Teensyなどが乗ります
- FrontLine 前のLINEセンサーのデータです。ボール補足エリアがあるので前だけラインセンサの形が違います。
- Kicker キッカー用のMOSFETが乗った回路です。コンデンサは別付けです。
- PowerUnit リポから5V,3.3Vを生成してメイン基板に送る回路です。ヒューズも乗ります。
- SideLine 横と後ろのラインセンサーのデータです
- UI-unit UI基盤のデータです。0.96inchのOLEDが乗ります