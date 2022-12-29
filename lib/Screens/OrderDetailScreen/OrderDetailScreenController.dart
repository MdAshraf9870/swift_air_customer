import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swift_air_customer/Models/OrderDeatilsModel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Apis/Apis.dart';
import '../../AppConst/AppConst.dart';
import '../../Models/LoginModel.dart';
import '../../support/CustomProgressDialog.dart';
import '../../support/LunchUrl.dart';
import '../../support/SharePreferencesManager.dart';

class OrderDetailScreenController extends GetxController{




  OrderDetailsModel? orderDetailsModel;
  LoginModel? loginModel;
  String orderId;
  BuildContext? context= Get.context;

  String deliveredTo="",
  altNo="",
  deliverySignature="",
  deliveryProof1="",
  deliveryProof2="";

  OrderDetailScreenController(this.orderId);
  @override
  void onReady() {
    // TODO: implement onInit
    super.onReady();
    SharePreferencesManager.instance.getlogindetails().then((value) {
      loginModel = value;
      // update();
      getOrdersDetails(loginModel!.customerId!,loginModel!.accessToken! );
    });
  }



  getOrdersDetails(String? customerId,String accessToken) {
    ProgressDialogsManager().isShowProgressDialog(context!);
    Map map = {
      "customerId": customerId,
      "accessToken": accessToken,
      "orderId":orderId
    };
    print(map);
    Apis().callApi(map, Apis.getCustorderdetails, context!).then((value) {
      if (value != null && jsonDecode(value)["status"]) {
        print(value);
        print(jsonDecode(value)["details"]);
          orderDetailsModel=OrderDetailsModel.fromJson(jsonDecode(value)["details"]);
        update();
      }
      ProgressDialogsManager().isDismissProgressDialog(context!);
    });
  }
  getPODDetails() {
    ProgressDialogsManager().isShowProgressDialog(context!);
    Map map = {
      "customerId": loginModel!.customerId,
      "accessToken": loginModel!.accessToken,
      "orderId":orderId
    };
    print(map);
    Apis().callApi(map, Apis.getCustgetpoddetails, context!).then((value) {
      if (value != null && jsonDecode(value)["status"]) {
        print(value);
        print(jsonDecode(value)["details"]);
            deliveredTo=jsonDecode(value)["details"]["delivered_to"];
            altNo=jsonDecode(value)["details"]["alt_no"];
            deliverySignature=jsonDecode(value)["details"]["delivery_signature"];
            deliveryProof1=jsonDecode(value)["details"]["delivery_proof1"];
            deliveryProof2=jsonDecode(value)["details"]["delivery_proof2"];

        update();
      }
      ProgressDialogsManager().isDismissProgressDialog(context!);
    });
  }
List details=[];
  getProblemDetails() {
    ProgressDialogsManager().isShowProgressDialog(context!);
    Map map = {
      "customerId": loginModel!.customerId,
      "accessToken": loginModel!.accessToken,
      "orderId":orderId
    };
    print(map);
    Apis().callApi(map, Apis.getOrderProblemDetails, context!).then((value) {
      if (value != null && jsonDecode(value)["status"]) {
        print(value);
        details=jsonDecode(value)["details"];
        update();
      }
      ProgressDialogsManager().isDismissProgressDialog(context!);
    });
  }

  void getContactDriver(BuildContext context, String title,String msg,Function()? onTap){
    showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
              ),
              title: Center(child: Text(title,style: TextStyle(color: AppConst.buttonColors),)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: Get.width*0.6,
                    child: ElevatedButton(

                      onPressed: ()=>LunchUrl().makePhoneCall(orderDetailsModel!.driverPhone!),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(

                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       // mainAxisSize: MainAxisSize.min,
                        children: const [

                          Text("Contact via call",style: TextStyle(
                            color: Colors.black,
                            fontSize: 18
                          ),),
                        //  SizedBox(width: 20,),
                          Icon(Icons.call,color: Colors.green,),

                        ],),
                    ),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    width: Get.width*0.6,
                    child: ElevatedButton(

                      onPressed: ()=>_launchWhatsapp(),
                      style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(

                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child:  Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       // mainAxisSize: MainAxisSize.min,
                        children: [

                        const Text("Contact via whatsapp",style: TextStyle(
                            color: Colors.black,
                            fontSize: 18
                        ),),

                        Image.asset("assets/images/whatsapp.png",height: 25,),
                      ],),
                    ),
                  ),


                ],
              ),
              actions: <Widget>[
                Center(
                  child: SizedBox(
                    width: Get.width*0.4,
                    child: ElevatedButton(
                      onPressed: ()=>Get.back(),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: AppConst.buttonColors,
                      ),
                      child: const Text("Cancel"),
                    ),
                  ),
                )
              ],
            ));
  }
  _launchWhatsapp() async {
    try{
      var whatsapp = orderDetailsModel!.driverPhone;
      var whatsappAndroid =Uri.parse("whatsapp://send?phone=+91$whatsapp&text=hello");
      String whatsappURLIos = "https://wa.me/+91$whatsapp?text=${Uri.parse("hello")}";
      print(whatsappAndroid);
      if(Platform.isAndroid){
        await launchUrl(whatsappAndroid);
      }else if(Platform.isIOS){
        await launchUrl(Uri.parse(whatsappURLIos));
      }
    }catch(e){print(e);
      ScaffoldMessenger.of(context!).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp is not installed on the device"),
        ),
      );
    }
  }
}