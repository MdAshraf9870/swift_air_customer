import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../AppConst/AppConst.dart';
import '../../widget/AppTextFormField.dart';
import '../OTPVerification/OTPVerification.dart';
import 'LoginScreenController.dart';

class LoginScreen extends StatelessWidget {
  LoginScreenController loginScreenController =
      Get.put(LoginScreenController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: loginScreenController,
        builder: (loginScreenController) => Scaffold(
            body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SingleChildScrollView(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // mainAxisSize: MainAxisSize.max,
                  child: IntrinsicHeight(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.92,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/images/Ssplash.png",
                              height: 180,
                              width: 300,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Image.asset(
                              "assets/images/usericon.png",
                              height: 120,
                            ),
                            const Text("Customer",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15)),
                            SizedBox(
                              height: 20,
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 19),
                                )),
                            SizedBox(
                              height: 1,
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                    "Login account quickly to manage orders.",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15))),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                                width: Get.width * 0.8,
                                child: TextBoxs.AppTextFormField(
                              loginScreenController.loginEdtController,
                              borderWidth: 1.5,

                              keyboardType: TextInputType.number,
                              prefixIcon: Container(
                                margin: EdgeInsets.symmetric(horizontal: 3),
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                color: Colors.grey.shade200,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      "assets/images/contryflaf.png",
                                      height: 15,
                                    ),Text("  +91  ",style: TextStyle(fontSize: 16),)
                                  ],
                                ),
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                                  errorMsg: loginScreenController.errorMobileMsg,
                                  focusNode: loginScreenController.focusMobileNumberEdt,
                                    label: "Enter Mobile No.*",
                                    onChange: (v){
                                      if(v.toString().length==10){
                                        loginScreenController.errorMobileMsg="";
                                        loginScreenController.update();
                                      }
                                    }
                            )),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: Get.width * 0.7,
                              height: 43,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppConst.buttonColors),
                                  onPressed: () {
                                    if(loginScreenController.validetion()){
                                      loginScreenController.login(context,loginScreenController: loginScreenController);
                                     // Get.to(OTPVerification("9650979301"));
                                    }
                                   // Get.to(OTPVerification("9650979301"));
                                  },
                                  child: Text("Login",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            const Text("Version 1.0.0"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ))));
  }
}
