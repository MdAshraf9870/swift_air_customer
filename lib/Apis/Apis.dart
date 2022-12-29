import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:swift_air_customer/Screens/Authantication/AuthanticationPaga.dart';
import 'package:swift_air_customer/support/AlertDialogManager.dartAlertDialogManager.dart';
import 'package:swift_air_customer/support/SharePreferencesManager.dart';
class Apis {
  static const String BasrUrl = "https://routplaner.com/api/";

  static Uri signUp = Uri.parse("${BasrUrl}customersignup");
  static Uri login = Uri.parse("${BasrUrl}customermobilelogin");
  static Uri getCountry = Uri.parse("${BasrUrl}getstatesofacountry");
  static Uri getCustomerProfile = Uri.parse("${BasrUrl}getcustomerprofile");
  static Uri getCustomerLogout = Uri.parse("${BasrUrl}customerlogout");
  static Uri getCustomerUpdateProfile = Uri.parse("${BasrUrl}customerupdateprofile");
  static Uri getCustcreateOrder = Uri.parse("${BasrUrl}custcreateorder");
  static Uri getCity = Uri.parse("${BasrUrl}getcitiesofastate");
  static Uri getCustongoingorders = Uri.parse("${BasrUrl}custongoingorders");
  static Uri getCustcompletedorders = Uri.parse("${BasrUrl}custcompletedorders");
  static Uri getCustorderdetails = Uri.parse("${BasrUrl}custorderdetails");
  static Uri getCustgetpoddetails = Uri.parse("${BasrUrl}custgetpoddetails");
  static Uri getOrderProblemDetails = Uri.parse("${BasrUrl}getorderproblemdetails");
  static var kGoogleApiKey = 'AIzaSyAcaYXGeP8OK8olF8Zy-9kX1v7rmgbxqAs';


  static Uri getaddress = Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?latlng=");






  var data;
  Future<dynamic> callApi(Map map,Uri url,BuildContext context) async {
    try{
      var response= await http.post(url,body: map);
          if(response.statusCode==200){
            print(response.body);
            if(jsonDecode(response.body)["message"]=="Customer has logged in from another device"){
              SharePreferencesManager.instance.logout(context);
              Get.offAll(AuthenticationPage());
            }
            return response.body;

          }else{
            AlertDialogManager().IsErrorAlertDialogMassage(context, "Error", "No Data Found");
          }
    }catch(e){
      print(e);
      AlertDialogManager().IsErrorAlertDialogMassage(context, "Error", e.toString());
      return data;
    }
  }
}
