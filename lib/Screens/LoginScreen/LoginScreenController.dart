import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:swift_air_customer/Screens/Dashboard/Dashboard.dart';
import 'package:swift_air_customer/Screens/OTPVerification/OTPVerification.dart';
import 'package:swift_air_customer/support/AlertDialogManager.dartAlertDialogManager.dart';
import 'package:swift_air_customer/support/SharePreferencesManager.dart';

import '../../Apis/Apis.dart';
import '../../support/CustomProgressDialog.dart';

class LoginScreenController extends GetxController{
TextEditingController loginEdtController =TextEditingController();
FocusNode focusMobileNumberEdt = FocusNode();
String errorMobileMsg="";
FocusNode focusNode = FocusNode();
String otp = '';
final TextEditingController otpNumberEdit = TextEditingController();


bool validetion(){
  if (loginEdtController.text.isEmpty) {
    errorMobileMsg = "Please enter 10 digit No.";
      focusMobileNumberEdt.requestFocus();
    update();
    return false;
  }
  return true;
}


@override
  void onInit() {
getPermission();
  }
getPermission() async {
  if (await Permission.location.isDenied) {
    await Permission.location.request();
  }
}
  login(BuildContext context, {LoginScreenController? loginScreenController}){
  try{
    ProgressDialogsManager().isShowProgressDialog(context);
    Map map={
      "phone":loginEdtController.text,
      "deviceid":"ddfdsf",
      "fcm_token":"dsfdsfdsf",
      "app_ver":""

      // "customerId":"204",
      // "accessToken":"0191caa6788f80ccb551c15c2138310d",
      // "from_location":"true",
      // "to_location":"false"
    };
    Apis().callApi(map, Apis.login ,context).then((value) {
      print(jsonDecode(value)["status"]);
      if(value !=null && jsonDecode(value)["status"]){
        print(jsonDecode(value)["message"]);
       SharePreferencesManager.instance.setLoginData(value.toString());
        AlertDialogManager().IsAlertDialogMessage(context, "Success", jsonDecode(value)["message"], (){

          SharePreferencesManager.instance.getlogindetails().then((value){
            print(value.name);
            print(value.address);
          });
          if(loginScreenController!=null){
            Get.offAll(OTPVerification(loginEdtController.text,loginScreenController));
          }

       //   Get.delete<LoginScreenController>();
        });

      }else if(value !=null && !jsonDecode(value)["status"]){
        AlertDialogManager().IsAlertDialogMessage(context, "Error", jsonDecode(value)["message"], (){
          print(value);
          Get.back();
        });
      }
      ProgressDialogsManager().isDismissProgressDialog(context);

    });
  }catch(e){
    ProgressDialogsManager().isDismissProgressDialog(context);
    print(e.toString());

  }

}

otpVerification(){
  if(otp=="0000"){
    Get.delete<LoginScreenController>();
    Get.offAll(Dashbaord());
  }
}

}