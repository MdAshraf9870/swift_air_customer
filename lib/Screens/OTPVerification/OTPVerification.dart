import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:swift_air_customer/Screens/LoginScreen/LoginScreen.dart';
import 'package:swift_air_customer/Screens/LoginScreen/LoginScreenController.dart';

import '../../AppConst/AppConst.dart';
import 'OTPVerificationController.dart';

class OTPVerification extends StatelessWidget {
  String number;
  LoginScreenController? otpVerificationController;
  OTPVerification(this.number, this.otpVerificationController);

  // OTPVerificationController otpVerificationController =
  //     Get.put(OTPVerificationController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: otpVerificationController,
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
                            Image.asset("assets/images/Ssplash.png",height: 180,width: 300,),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                    Image.asset(
                                      "assets/images/contryflaf.png",
                                      height: 15,
                                    ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(number,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  TextButton(
                                      onPressed: () => Get.to(LoginScreen()),
                                      child: const Text("CHANGE",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15)))
                                ],
                              ),
                            ),

                            Align(
                                alignment: Alignment.center,
                                child: const Text(
                                    "One Time Password(OTP) has been send to the number.",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 15))),
                            SizedBox(
                              height: 20,
                            ),

                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 50),
                              child: PinFieldAutoFill(
                                // focusNode: focusNode,
                                // autoFocus: otpFocus,
                                autoFocus: true,
                                currentCode: otpVerificationController!.otp,
                                controller:
                                    otpVerificationController!.otpNumberEdit,
                                cursor: Cursor(
                                  width: 1,
                                  height: 20,
                                  color: AppConst.buttonColors,
                                  radius: Radius.circular(1),
                                  enabled: true,
                                ),
                                decoration: BoxLooseDecoration(
                                  strokeWidth: 1,
                                  strokeColorBuilder:
                                      FixedColorBuilder(AppConst.buttonColors),
                                ),
                                codeLength: 4,
                                onCodeChanged: (String? code) {
                                  // log('message1==>>>  $code');
                                  otpVerificationController!.otp =
                                      code.toString();
                                  print(otpVerificationController!.otp);
                                  otpVerificationController!.update();
                                  if (code!.length == 4) {
                                    otpVerificationController!.focusNode
                                        .nextFocus();
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: Get.width*0.8,
                              height: 50,
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          side: BorderSide(
                                              color: AppConst.buttonColors,
                                              width: 1.8))),
                                  onPressed: () =>otpVerificationController!.otpVerification(),
                                  child: Text("Verify",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,color: AppConst.buttonColors,
                                          fontSize: 15))),
                            ),
                            TextButton(
                                onPressed: () => otpVerificationController!.login(context),
                                child: const Text("Resend OTP",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15))),
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
