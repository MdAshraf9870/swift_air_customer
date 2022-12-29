import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:swift_air_customer/AppConst/AppConst.dart';

import 'Dashboard/Dashboard.dart';

class ThankYouPage extends StatefulWidget {

  String? orderId;
   ThankYouPage({Key? key,this.orderId}) : super(key: key);

  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

class _ThankYouPageState extends State<ThankYouPage> {
  bool start = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        start = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: Get.height,
        child: Stack(
          children: [
            // if(start)
            Positioned(
              top: Get.height * 0.2,
              left: Get.width * 0.1,
              right: Get.width * 0.1,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: Get.height * 0.34,
                    width: Get.width * 0.8,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 1,
                              color: Colors.grey,
                              blurRadius: 6,
                              offset: Offset(1, 3))
                        ]),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Booking Successful",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                color: Colors.green.shade700),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Thank you for your booking\nyour order has registered with ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            "Order id : ${widget.orderId}",
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          ),
                          SizedBox(
                            height: 15,
                          ),

                        ],
                      ),
                    ),
                  ),

                    Positioned(
                        top: -Get.width * 0.14,
                        left: Get.width * 0.273,

                        //  width: Get.width*0.8,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: Lottie.asset(
                              "assets/images/success.json",
                              repeat: false,
                              fit: BoxFit.fitHeight,
                              height: 120,
                              width: 120,
                            ))),
                ],
              ),
            ),
            if (start)
            Align(
                alignment: Alignment.bottomCenter,
                child: Lottie.asset("assets/images/successBackground.json",
                    repeat: false)),
            if (start)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: Get.width,
                  margin:const EdgeInsets.only(left: 15,right: 15,bottom: 10),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                        ),
                          backgroundColor: AppConst.buttonColors),
                      onPressed: () => Get.offAll(Dashbaord(page: 1,)),
                      child: const Text("Track Oder")),
                ),
              )
          ],
        ),
      ),
    );
  }
}
