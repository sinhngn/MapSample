# MapSample

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
ref:
https://developers.google.com/maps/
https://cocoapods.org 

Thank you.
------
Vấn đề về Router (GOOGlE Direction)
IOS Client                       My Server               Google Direction API
 -------------- GetDirection------->|                            |
                                    |-----------getDirection --->|
                                    |<------- array coordinates--|
|<------- [(lat,long),....]---------|
|--------
|       |
|  (DRAW LINE to MAP)
|       |
|<-------
DONE
