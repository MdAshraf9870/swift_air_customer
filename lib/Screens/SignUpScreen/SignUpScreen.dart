import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:swift_air_customer/Screens/SignUpScreen/SignUpScreenController.dart';
import 'package:swift_air_customer/widget/AppTextFormField.dart';

import '../../AppConst/AppConst.dart';
import '../../Models/getState.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreenController signUpScreenController =
      Get.put(SignUpScreenController());

  double textFormFieldSize = 55;
  double textFormFieldBorderRedius = 13;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=>Get.delete<SignUpScreenController>(),
      child: GetBuilder(
          init: signUpScreenController,
          builder: (signUpScreenController) => Scaffold(
                  body: SafeArea(
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Customer Sign Up",
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.w700),
                            )),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Create account quickly to manage orders",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            padding:
                                EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                            decoration: BoxDecoration(
                                color: Color(0xfff7ec8eb),
                                borderRadius: BorderRadius.circular(8)),
                            child: const Text(
                              "---Personal info---",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextBoxs.AppTextFormField(
                                      signUpScreenController.firstNameEdt,
                                      borderWidth: 1.5,
                                      borderRadius: textFormFieldBorderRedius,
                                      label: "First Name",
                                      size: textFormFieldSize,
                                      focusNode: signUpScreenController
                                          .focusFirstNameEdt,
                                  errorMsg: signUpScreenController.errorFirstNameEdt,
                                    onChange: (v){
                                       if(v.toString().isNotEmpty){
                                         signUpScreenController.errorFirstNameEdt="";
                                         signUpScreenController.update();
                                       }
                                    }
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: TextBoxs.AppTextFormField(
                                      signUpScreenController.lastNameEdt,
                                      borderWidth: 1.8,
                                      borderRadius: textFormFieldBorderRedius,
                                      label: "Last Name",
                                      size: textFormFieldSize,
                                      focusNode: signUpScreenController
                                          .focusLastNameEdt,
                                      errorMsg: signUpScreenController.errorLastNameEdt,
                                      onChange: (v){
                                        if(v.toString().isNotEmpty){
                                          signUpScreenController.errorLastNameEdt="";
                                          signUpScreenController.update();
                                        }
                                      }
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextBoxs.AppTextFormField(
                                      signUpScreenController.mobileNumberEdt,
                                      borderWidth: 1.5,
                                      borderRadius: textFormFieldBorderRedius,
                                      label: "Mobile Number",
                                      size: textFormFieldSize,
                                      keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(10),
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                      focusNode: signUpScreenController
                                          .focusMobileNumberEdt,
                                      errorMsg: signUpScreenController.errorMobileNumberEdt,
                                      onChange: (v){
                                        if(v.toString().length==10){
                                          signUpScreenController.errorMobileNumberEdt="";
                                          signUpScreenController.update();
                                        }
                                      }
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: TextBoxs.AppTextFormField(
                                      signUpScreenController.passwordEdt,
                                      borderWidth: 1.8,
                                      borderRadius: textFormFieldBorderRedius,
                                      label: "Password",
                                      size: textFormFieldSize,
                                      obscureText:  signUpScreenController.password,
                                      suffixIcon: GestureDetector(
                                          onTap: (){
                                            print("knjjn");
                                            signUpScreenController.password = signUpScreenController.password?false:true;
                                            signUpScreenController.update();
                                          },
                                          child: signUpScreenController.password?Icon(Icons.visibility_off):Icon(Icons.visibility)),
                                      focusNode: signUpScreenController
                                          .focusPasswordNameEdt,
                                      errorMsg: signUpScreenController.errorPasswordEdt,
                                      onChange: (v){
                                        if(v.toString().isNotEmpty){
                                          signUpScreenController.errorPasswordEdt="";
                                          signUpScreenController.update();
                                        }
                                      }
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextBoxs.AppTextFormField(
                                      signUpScreenController.emailEdt,
                                      borderWidth: 1.5,
                                      borderRadius: textFormFieldBorderRedius,
                                      label: "Email",
                                      size: textFormFieldSize,
                                      focusNode:
                                          signUpScreenController.focusEmailEdt,
                                      errorMsg: signUpScreenController.errorEmailEdt,
                                      onChange: (v){
                                        if(v.toString().isNotEmpty){
                                          signUpScreenController.errorEmailEdt="";
                                          signUpScreenController.update();
                                        }
                                      }
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: TextBoxs.AppTextFormField(
                                      signUpScreenController.companyEdt,
                                      borderWidth: 1.8,
                                      borderRadius: textFormFieldBorderRedius,
                                      label: "Company",
                                      size: textFormFieldSize,
                                      focusNode: signUpScreenController
                                          .focusCompanyEdt,
                                      errorMsg: signUpScreenController.errorCompanyEdt,
                                      onChange: (v){
                                        if(v.toString().isNotEmpty){
                                          signUpScreenController.errorCompanyEdt="";
                                          signUpScreenController.update();
                                        }
                                      }
                                  )),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(top: 30),
                            padding:
                                EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                            decoration: BoxDecoration(
                                color: Color(0xfff7ec8eb),
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              "---Address info---",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: TextBoxs.AppTextFormField(
                              signUpScreenController.address1Edt,
                              borderWidth: 1.5,
                              borderRadius: textFormFieldBorderRedius,
                              label: "Address Line1",
                              size: textFormFieldSize,
                              focusNode: signUpScreenController.focusAddress1Edt,
                              errorMsg: signUpScreenController.errorAddress1Edt,
                              onChange: (v){
                                if(v.toString().isNotEmpty){
                                  signUpScreenController.errorAddress1Edt="";
                                  signUpScreenController.update();
                                }
                              }
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: TextBoxs.AppTextFormField(
                              signUpScreenController.address2Edt,
                              borderWidth: 1.8,
                              borderRadius: textFormFieldBorderRedius,
                              label: "Address line2",
                              size: textFormFieldSize,
                              focusNode: signUpScreenController.focusAddress2Edt,
                              errorMsg: signUpScreenController.errorAddress2Edt,
                              onChange: (v){
                                if(v.toString().isNotEmpty){
                                  signUpScreenController.errorAddress2Edt="";
                                  signUpScreenController.update();
                                }
                              }
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextBoxs.AppTextFormField(
                                      signUpScreenController.pincodeEdt,
                                      borderWidth: 1.5,
                                      borderRadius: textFormFieldBorderRedius,
                                      label: "Pincode",
                                      size: textFormFieldSize,
                                      focusNode: signUpScreenController
                                          .focusPincodeEdt,
                                      errorMsg: signUpScreenController.errorPincodeEdt,
                                      onChange: (v){
                                        if(v.toString().isNotEmpty){
                                          signUpScreenController.errorPincodeEdt="";
                                          signUpScreenController.update();
                                        }
                                      }
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 6),
                                height: textFormFieldSize,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        textFormFieldBorderRedius),
                                    border: Border.all(
                                      color: Color(0xfff6d7ab5),
                                      width: 1.8,
                                    )),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("INDIA",
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400))),
                              )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 6),
                                height: textFormFieldSize,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        textFormFieldBorderRedius),
                                    border: Border.all(
                                      color: Color(0xfff6d7ab5),
                                      width: 1.8,
                                    )),
                                child: Center(
                                  child: DropdownButton<GetState>(
                                    value: signUpScreenController.getStateValue,
                                    //icon: const Icon(Icons.arrow_downward),
                                    elevation: 16,
                                    underline: Container(
                                      height: 0,
                                      color: Colors.white,
                                    ),
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    dropdownColor: Colors.grey.shade100,
                                    isExpanded: true,
                                    onChanged: (GetState? value) {
                                      // This is called when the user selects an item.
                                      signUpScreenController.getStateValue =
                                          value;
                                      signUpScreenController.update();
                                      signUpScreenController
                                          .getCity(value!.statecode!);
                                    },
                                    items: signUpScreenController.getState
                                        .map<DropdownMenuItem<GetState>>(
                                            (GetState? value) {
                                      return DropdownMenuItem<GetState>(
                                        value: value,
                                        child: Text(value!.statename!),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              )),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 6),
                                height: textFormFieldSize,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        textFormFieldBorderRedius),
                                    border: Border.all(
                                      color: Color(0xfff6d7ab5),
                                      width: 1.8,
                                    )),
                                child: Center(
                                  child: DropdownButton<GetState>(
                                    value: signUpScreenController.getCityValue,
                                    //icon: const Icon(Icons.arrow_downward),
                                    elevation: 16,
                                    underline: Container(
                                      height: 0,
                                      color: Colors.white,
                                    ),
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    dropdownColor: Colors.grey.shade100,
                                    isExpanded: true,
                                    onChanged: (GetState? value) {
                                      // This is called when the user selects an item.
                                      signUpScreenController.getCityValue = value;
                                      signUpScreenController.update();
                                    },
                                    items: signUpScreenController.getCityList
                                        .map<DropdownMenuItem<GetState>>(
                                            (GetState? value) {
                                      return DropdownMenuItem<GetState>(
                                        value: value,
                                        child: Text(value!.statename!),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              )),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text(
                                  "Contact us",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "For any queries or help",
                                  style: TextStyle(
                                      fontSize: 15, fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppConst.buttonColors,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15))),
                                onPressed: () {},
                                child: Text("Call Us",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15))),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Mail us at mailto:info@swiftairexpress.co.in",
                          style: TextStyle(
                              color: AppConst.buttonColors,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: Get.width * 0.7,
                          height: 43,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppConst.buttonColors),
                              onPressed: () {
                                if(signUpScreenController.validation()){
                                  signUpScreenController.signUpUser(context);
                                }
                                //  print(loginScreenController.loginEdtController.text);
                              },
                              child: const Text("Sign Up",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15))),
                        ),
                      ],
                    )),
              ))),
    );
  }
}
