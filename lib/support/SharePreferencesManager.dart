// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/LoginModel.dart';

class SharePreferencesManager {
  SharePreferencesManager._privateConstructor();

  static final SharePreferencesManager instance =
      SharePreferencesManager._privateConstructor();

  setLoginData(String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString("loginmodel", value);
  }

  Future<LoginModel> getlogindetails() async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // print(prefs.getString("loginmodel"));
      var result = Map<String, dynamic>.from(json.decode(prefs.getString("loginmodel") ?? ""));
      return LoginModel.fromJson(result);
    }catch(e){
      return LoginModel();
    }

  }

  logout(BuildContext context) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.clear();
  }
}
