import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:swift_air_customer/AppConst/AppConst.dart';
import 'package:swift_air_customer/Screens/Authantication/AuthanticationPaga.dart';
import 'package:swift_air_customer/Screens/GoogleMapScreen.dart';
import 'package:swift_air_customer/Screens/LoginScreen/LoginScreen.dart';
import 'package:swift_air_customer/Screens/OTPVerification/OTPVerification.dart';
import 'package:swift_air_customer/Screens/SignUpScreen/SignUpScreen.dart';

import '../OrderScreen/OrderScreenTab.dart';
import '../Profile/ProfileScreen.dart';




class Dashbaord extends StatefulWidget  {
  int page = 0;


  Dashbaord({this.page=0});

  @override
  State<Dashbaord> createState() => _DashbaordScreenState();
}

class _DashbaordScreenState extends State<Dashbaord> {

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  List<Widget> pages = [
    GoogleMapScreen("type", key: PageStorageKey('Page1'),), OrderScreenTab(), ProfileScreen(),
    // PickedUp(),
    // UnPickup(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
         backgroundColor: AppConst.buttonColors,
          // automaticallyImplyLeading: false,
        ),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: widget.page,
          height: 60.0,
          items: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.home,color: Colors.white),
                    Text("Home",style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 4),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.access_alarm,color: Colors.white,),
                    Text("order",style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.account_circle_rounded,color: Colors.white,),
                    Text("Profile",style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),
            ),
          ],
          color: AppConst.buttonColors,
          buttonBackgroundColor:  AppConst.buttonColors,
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              widget.page = index;
             // pickupController.getPending(context, _page);
            });
          },
          letIndexChange: (index) => true,
        ),
        body: SafeArea(child:
       // pages[widget.page]
        IndexedStack(
          index:  widget.page,
          children:pages,
        ),

        // widget.page==0?IndexedStack(
        //   index:  widget.page,
        //   children:[ GoogleMapScreen("type", key: PageStorageKey('Page1'),)],
        // ):pages[widget.page]

        // IndexedStack(
        //   index:  widget.page,
        //   children:pages,
        // ),
    ));
  }
}

// "orderId": "IND12226734",
// "booking_date": "2022-12-09 15:15:47",
// "delivery_date": "",
// "sender_name": "Text",
// "sender_phone": "1234567890",
// "from_location": "Senderr",
// "to_location": "Recievier",
// "dropoff_name": "testR",
// "dropoff_phone": "1234567890",
// "dropoff_company_name": "",
// "priority": "a",
// "priority_colour": "#e69138",
// "qty": "1",
// "doc_type": "DOX",
// "packet_type": "GENERAL",
// "packet_classify": "GENERAL",
// "status": "Pending",
// "status_code": "0",
// "special_instructions": "a",
// "created_at": "2022-12-09 15:15:47",
// "from_lat": "a",
// "from_long": "a",
// "to_lat": "a",
// "to_long": "a",
// "driver_name": "",
// "driver_phone": "",
// "driver_ecode": ""
