import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:swift_air_customer/Apis/Apis.dart';
import 'package:swift_air_customer/Screens/LoginScreen/LoginScreen.dart';
import 'package:swift_air_customer/support/AlertDialogManager.dartAlertDialogManager.dart';
import 'package:swift_air_customer/support/CustomProgressDialog.dart';
import '../../Models/getState.dart';

class SignUpScreenController extends GetxController {
  BuildContext? context = Get.context;
  TextEditingController firstNameEdt = TextEditingController();
  TextEditingController lastNameEdt = TextEditingController();
  TextEditingController mobileNumberEdt = TextEditingController();
  TextEditingController passwordEdt = TextEditingController();
  TextEditingController emailEdt = TextEditingController();
  TextEditingController companyEdt = TextEditingController();
  TextEditingController address1Edt = TextEditingController();
  TextEditingController address2Edt = TextEditingController();
  TextEditingController pincodeEdt = TextEditingController();
  FocusNode focusFirstNameEdt = FocusNode();
  FocusNode focusLastNameEdt = FocusNode();
  FocusNode focusMobileNumberEdt = FocusNode();
  FocusNode focusPasswordNameEdt = FocusNode();
  FocusNode focusEmailEdt = FocusNode();
  FocusNode focusCompanyEdt = FocusNode();
  FocusNode focusAddress1Edt = FocusNode();
  FocusNode focusAddress2Edt = FocusNode();
  FocusNode focusPincodeEdt = FocusNode();
  String errorFirstNameEdt  ="";
  String errorLastNameEdt   ="";
  String errorMobileNumberEdt="";
  String errorPasswordEdt   ="";
  String errorEmailEdt      ="";
  String errorCompanyEdt    ="";
  String errorAddress1Edt   ="";
  String errorAddress2Edt   ="";
  String errorPincodeEdt    ="";

  bool password=true;
  List<GetState> getState = [];
  List<GetState> getCityList = [];
  GetState? getStateValue;
  GetState? getCityValue;
  @override
  void onInit() {
    getPermission();
    getCountry();
  }
  getPermission() async {
    if (await Permission.location.isDenied) {
      await Permission.location.request();
    }
  }
  getCountry() {
    Map map = {"countrycode": "IND"};
    Apis().callApi(map, Apis.getCountry, context!).then((value) {
      if (value != null) {
        print(value);
        print(jsonDecode(value)["statedetails"]);
        jsonDecode(value)["statedetails"].forEach((v) {
          getState.add(GetState.fromJson(v));
        });
        getStateValue = getState[0];

        getCity(getState[0].statecode!);
      }
    });
  }

  getCity(String value) {
    Map map = {"statecode": value};
    Apis().callApi(map, Apis.getCity, context!).then((value) {
      if (value != null) {
        print(value);
        getCityList.clear();
        print(jsonDecode(value)["citydetails"]);
        jsonDecode(value)["citydetails"].forEach((v) {
          getCityList.add(GetState(v["citycode"], v["cityname"]));
        });
        getCityValue = getCityList[0];

        update();
      }
    });
  }

  bool focusCheck=false;

  bool validation() {
    focusCheck=true;
    errorFirstNameEdt = "";
    errorLastNameEdt = "";
    errorMobileNumberEdt = "";
    errorPasswordEdt = "";
    errorEmailEdt = "";
    errorCompanyEdt = "";
    errorAddress1Edt = "";
    errorAddress2Edt = "";
    errorPincodeEdt = "";

    if (firstNameEdt.text.isEmpty) {
      errorFirstNameEdt = "Please enter first name.";
      if(focusCheck){
        focusCheck=false;
          focusFirstNameEdt.requestFocus();
      }
      update();
    }  if (lastNameEdt.text.isEmpty) {
      errorLastNameEdt = "Please enter last name.";
       if(focusCheck){
         focusCheck=false;
         focusLastNameEdt.requestFocus();
       }
      update();
    }  if (mobileNumberEdt.text.isEmpty) {
      errorMobileNumberEdt = "Please enter 10 digit No.";
      if(focusCheck){
        focusCheck=false;
        focusMobileNumberEdt.requestFocus();
      }
       update();
    }  if (passwordEdt.text.isEmpty) {
      errorPasswordEdt = "Please enter Password.";
      if(focusCheck){
        focusCheck=false;
        focusPasswordNameEdt.requestFocus();
      }
       update();
    }  if (!EmailValidator.validate(emailEdt.text)) {
      errorEmailEdt = "Please enter valid email.";
      if(focusCheck){
        focusCheck=false;
        focusEmailEdt.requestFocus();
      }
       update();
    }  if (companyEdt.text.isEmpty) {
      errorCompanyEdt = "Please enter company name.";
      if(focusCheck){
        focusCheck=false;
        focusCompanyEdt.requestFocus();
      }
       update();
    }  if (address1Edt.text.isEmpty) {
      errorAddress1Edt = "Please enter address.";
      if(focusCheck){
        focusCheck=false;
        focusAddress1Edt.requestFocus();
      }
       update();
    }  if (address2Edt.text.isEmpty) {
      errorAddress2Edt = "Please enter address.";
      if(focusCheck){
        focusCheck=false;
        focusAddress2Edt.requestFocus();
      }
       update();
    }  if (pincodeEdt.text.isEmpty) {
      errorPincodeEdt = "Please enter pincode.";
      if(focusCheck){
        focusCheck=false;
        focusPincodeEdt.requestFocus();
      }
       update();
    }

    return focusCheck;
  }


  signUpUser(BuildContext context){
    try{
      ProgressDialogsManager().isShowProgressDialog(context);
      Map map={
        "name":"${firstNameEdt.text} ${lastNameEdt.text}",
        "phone":mobileNumberEdt.text,
        "password":passwordEdt.text,
        "email":emailEdt.text,
        "company":companyEdt.text,
        "house_no":"${address1Edt.text}",
        "street":"${address2Edt.text}",
        "city":getCityValue!.statename,
        "state":getStateValue!.statename,
        "postcode":pincodeEdt.text,
        "deviceid":"ddfdsf",
        "fcm_token":"dsfdsfdsf",
        "app_ver":""
      };
      Apis().callApi(map, Apis.signUp, context).then((value) {
        print(jsonDecode(value)["status"]);
        if(value !=null && jsonDecode(value)["status"]){
          print(jsonDecode(value)["message"]);
          AlertDialogManager().IsAlertDialogMessage(context, "Success", jsonDecode(value)["message"], (){
            Get.offAll(LoginScreen());
            Get.delete<SignUpScreenController>();
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
}
