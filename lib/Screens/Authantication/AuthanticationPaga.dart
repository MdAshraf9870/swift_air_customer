import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:swift_air_customer/Screens/LoginScreen/LoginScreen.dart';
import 'package:swift_air_customer/Screens/SignUpScreen/SignUpScreen.dart';

import '../../AppConst/AppConst.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {

  @override
  void initState() {
    super.initState();                  
    getPermission();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/images/Ssplash.png",height: 180,width: 300,),
              SizedBox(height: 10,),
              Image.asset("assets/images/usericon.png",height: 120,),
              const Text("Customer",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15)),
              SizedBox(height: 20,),
              Align(
                  alignment: Alignment.centerLeft,
                  child: const Text("Account",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),)),
              SizedBox(height: 1,),
              Align(
                  alignment: Alignment.centerLeft,child: const Text("Login create account quickly to manage orders.",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15))),
              SizedBox(height: 20,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConst.buttonColors
                ),
                onPressed: ()=>Get.to(LoginScreen()), child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 85.0,vertical: 12),
                  child: Text("Login",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15)),
                ),),
              SizedBox(height: 20,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  backgroundColor: AppConst.buttonColors
              ),onPressed: ()=>Get.to(SignUpScreen()),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80.0,vertical: 12),
                    child: const Text("Sign Up",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15)),
                  )),
              const SizedBox(height: 10,),
              const Text("Version 1.0.0"),

            ],
          ),
        ),
      ),
    );
  }

  getPermission() async {
    if(await Permission.location.isDenied){
      await Permission.location.request();

    }
  }
}
