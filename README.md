# MapSample

Please get new key api from google map api and open AppDeleaget.h change <br/>

define  GOOGLE_API_KEY @"AIzaSyBG5Gc-wMw_rEMgL7HUGDEmnUL6QNfzY90"

0. Download source code

1. open terminal and type:
   $ cd /Users/NS/Downloads/MapSample-NewBrank
   
   $ pod install
   
   if cocoapod not available, you should install it: $ sudo gem install cocoapods
2. open file : MapsSample.xcworkspace 
3. Build source


----
Với chức năng drag điểm, thì long touch (chạm vào điểm đó khoảng 1-2 giây) vào điểm đó và di chuyển đến điểm cần

----
ref:<br/>
https://developers.google.com/maps/<br/>
https://cocoapods.org 

Thank you.
------
Vấn đề về Router (Google Direction api) <br/><br/>
IOS Client............................My Server.........................Google Direction API<br/>
|-------------- GetDirection------->|.........................................|<br/>
|....................................................|----------getDirection --->|<br/>
|....................................................|<----- array coordinates--|<br/>
|<------- [(lat,long),....]-------------|<br/>
|<br/>
|--------<br/>
|..........|<br/>
|......(DRAW LINE to MAP)<br/>
|..........|<br/>
|<-------<br/>
DONE
