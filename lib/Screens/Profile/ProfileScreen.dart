import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:swift_air_customer/AppConst/AppConst.dart';

import '../../Models/getState.dart';
import '../../support/AlertDialogManager.dartAlertDialogManager.dart';
import '../../widget/AppTextFormField.dart';
import 'ProfileScreenController.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreenController profileScreenController =
      Get.put(ProfileScreenController());
  double textFormFieldSize = 55;
  double textFormFieldBorderRedius = 13;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: profileScreenController,
        builder: (profileScreenController) => Scaffold(
              body: profileScreenController.profileList != null
                  ? Container(
                      height: Get.height,
                      child: Stack(
                        children: [
                          Container(
                            width: Get.width,
                            height: 250,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/profileScreen.png"),
                                    fit: BoxFit.fill)),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "My Profile",
                                        style: TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          accountBottomSheet(context);
                                        },
                                        child: Icon(
                                          Icons.edit,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 125,
                                      width: 125,
                                      decoration: BoxDecoration(
                                          // color: Colors.green,
                                          //  shape: BoxShape.circle
                                          // image: DecorationImage(image: AssetImage("assets/images/profileScreen.png")
                                          //     ,fit: BoxFit.fill
                                          //
                                          // )
                                          ),
                                      child: Stack(
                                        children: [
                                          Container(
                                              height: 120,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 2),
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/images/userpick.png"),
                                                    fit: BoxFit.fill,
                                                  ))),
                                          Align(
                                              alignment: Alignment.bottomRight,
                                              child: IconButton(
                                                  onPressed: () =>
                                                      print("dkjfbnkjs"),
                                                  icon: Icon(
                                                    Icons.camera,
                                                    size: 35,
                                                    color: Colors.white,
                                                  )))
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: Get.height * 0.25,
                            left: Get.width * 0.07,
                            right: Get.width * 0.07,
                            //  bottom: 0,
                            child: Container(
                              height: Get.height * 0.55,
                              child: ListView(
                                physics: BouncingScrollPhysics(),
                                children: [
                                  Container(
                                    width: Get.width * 0.9,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 5.0,
                                          ),
                                        ]),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.person,
                                              size: 35,
                                              color: AppConst.buttonColorsDark,
                                            ),
                                            Text(
                                              " Personal Information",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                        detailRow(
                                            "name",
                                            profileScreenController
                                                .profileList!.name!),
                                        detailRow(
                                            "Mobile",
                                            profileScreenController
                                                .profileList!.phone!,
                                            varifide: true),
                                        detailRow(
                                            "Email", profileScreenController.profileList!.email!),
                                        detailRow("Company", profileScreenController.profileList!.company!),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: Get.width * 0.9,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 5.0,
                                          ),
                                        ]),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 35,
                                              color: AppConst.buttonColorsDark,
                                            ),
                                            Text(
                                              " Address Information",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                        detailRow(
                                            "Address",
                                            profileScreenController
                                                .profileList!.houseNo!),
                                        detailRow(
                                            "City",
                                            profileScreenController
                                                .profileList!.city!),
                                        detailRow(
                                            "State",
                                            profileScreenController
                                                .profileList!.state!),
                                        detailRow(
                                            "Pincode",
                                            profileScreenController
                                                .profileList!.postcode!),
                                        detailRow(
                                            "Country",
                                            profileScreenController
                                                .profileList!.country!),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: ()=>AlertDialogManager().IsAlertLogoutDialogMessage(context, "Logout", "Are you sure want to Logout?", () => profileScreenController.getLogout(context)),
                                    child: Container(
                                      width: Get.width * 0.9,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 5.0,
                                            ),
                                          ]),
                                      child: Center(
                                        child: Text(
                                          "Logout",
                                          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Center(child: CircularProgressIndicator()),
            ));
  }

  Widget detailRow(String title, String name, {bool varifide = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 1,
          ),
          if (varifide)
            Row(
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                ),
                Icon(
                  Icons.verified,
                  size: 24,
                  color: Colors.green,
                ),
                Text(
                  " varified",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.green),
                ),
              ],
            ),
          if (!varifide)
            Text(
              name,
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
            ),
        ],
      ),
    );
  }


  // name,email,company,password,
  // house_no,street,city,state,postcode,deviceid
  accountBottomSheet(BuildContext buildContext) async {
    profileScreenController.getFillProfileDetails(profileScreenController.profileList);
    return showModalBottomSheet(
      isScrollControlled: true,
      context: buildContext,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      builder: (context) {
        return GetBuilder(
            init: profileScreenController,
            builder: (profileScreenController)=> Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              height: Get.height / 1.2,
              child: Column(
                children: [
                  Container(
                    height: 5,
                    width: 150,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey),

                  ),
                  Expanded(
                    child: Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                        child: ListView(
                          physics:const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Profile Update",
                                  style: TextStyle(
                                      fontSize: 19, fontWeight: FontWeight.w700),
                                )),
                            /*Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Create account quickly to manage orders",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            )*/
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
                                          profileScreenController.NameEdt,
                                          borderWidth: 1.5,
                                          borderRadius: textFormFieldBorderRedius,
                                          label: "Name",
                                          size: textFormFieldSize,
                                          focusNode: profileScreenController
                                              .focusNameEdt,
                                          errorMsg: profileScreenController.errorNameEdt,
                                          onChange: (v){
                                            if(v.toString().isNotEmpty){
                                              profileScreenController.errorNameEdt="";
                                              profileScreenController.update();
                                            }
                                          }
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: TextBoxs.AppTextFormField(
                                          profileScreenController.mobileNumberEdt,
                                          borderWidth: 1.5,
                                          borderRadius: textFormFieldBorderRedius,
                                          label: "Mobile Number",
                                          size: textFormFieldSize,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(10),
                                            FilteringTextInputFormatter.digitsOnly
                                          ],
                                          focusNode: profileScreenController
                                              .focusMobileNumberEdt,
                                          errorMsg: profileScreenController.errorMobileNumberEdt,
                                          onChange: (v){
                                            if(v.toString().length==10){
                                              profileScreenController.errorMobileNumberEdt="";
                                              profileScreenController.update();
                                            }
                                          }
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: TextBoxs.AppTextFormField(
                                          profileScreenController.passwordEdt,
                                          borderWidth: 1.8,
                                          borderRadius: textFormFieldBorderRedius,
                                          label: "Password",
                                          size: textFormFieldSize,
                                          focusNode: profileScreenController
                                              .focusPasswordNameEdt,
                                          errorMsg: profileScreenController.errorPasswordEdt,
                                          onChange: (v){
                                            if(v.toString().isNotEmpty){
                                              profileScreenController.errorPasswordEdt="";
                                              profileScreenController.update();
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
                                          profileScreenController.emailEdt,
                                          borderWidth: 1.5,
                                          borderRadius: textFormFieldBorderRedius,
                                          label: "Email",
                                          size: textFormFieldSize,
                                          focusNode:
                                          profileScreenController.focusEmailEdt,
                                          errorMsg: profileScreenController.errorEmailEdt,
                                          onChange: (v){
                                            if(v.toString().isNotEmpty){
                                              profileScreenController.errorEmailEdt="";
                                              profileScreenController.update();
                                            }
                                          }
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: TextBoxs.AppTextFormField(
                                          profileScreenController.companyEdt,
                                          borderWidth: 1.8,
                                          borderRadius: textFormFieldBorderRedius,
                                          label: "Company",
                                          size: textFormFieldSize,
                                          focusNode: profileScreenController
                                              .focusCompanyEdt,
                                          errorMsg: profileScreenController.errorCompanyEdt,
                                          onChange: (v){
                                            if(v.toString().isNotEmpty){
                                              profileScreenController.errorCompanyEdt="";
                                              profileScreenController.update();
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
                                  profileScreenController.address1Edt,
                                  borderWidth: 1.5,
                                  borderRadius: textFormFieldBorderRedius,
                                  label: "Address Line1",
                                  size: textFormFieldSize,
                                  focusNode: profileScreenController.focusAddress1Edt,
                                  errorMsg: profileScreenController.errorAddress1Edt,
                                  onChange: (v){
                                    if(v.toString().isNotEmpty){
                                      profileScreenController.errorAddress1Edt="";
                                      profileScreenController.update();
                                    }
                                  }
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: TextBoxs.AppTextFormField(
                                  profileScreenController.address2Edt,
                                  borderWidth: 1.5,
                                  borderRadius: textFormFieldBorderRedius,
                                  label: "Address Line2",
                                  size: textFormFieldSize,
                                  focusNode: profileScreenController.focusAddress2Edt,
                                  errorMsg: profileScreenController.errorAddress2Edt,
                                  onChange: (v){
                                    if(v.toString().isNotEmpty){
                                      profileScreenController.errorAddress2Edt="";
                                      profileScreenController.update();
                                    }
                                  }
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: TextBoxs.AppTextFormField(
                                          profileScreenController.pincodeEdt,
                                          borderWidth: 1.5,
                                          borderRadius: textFormFieldBorderRedius,
                                          label: "Pincode",
                                          size: textFormFieldSize,
                                          focusNode: profileScreenController
                                              .focusPincodeEdt,
                                          errorMsg: profileScreenController.errorPincodeEdt,
                                          onChange: (v){
                                            if(v.toString().isNotEmpty){
                                              profileScreenController.errorPincodeEdt="";
                                              profileScreenController.update();
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
                                            value: profileScreenController.getStateValue,
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
                                              profileScreenController.getStateValue =
                                                  value;
                                              profileScreenController.update();
                                              profileScreenController
                                                  .getCity(value!.statecode!);
                                            },
                                            items: profileScreenController.getState
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
                                            value: profileScreenController.getCityValue,
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
                                              profileScreenController.getCityValue = value;
                                              profileScreenController.update();
                                            },
                                            items: profileScreenController.getCityList
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
                                    if(profileScreenController.validation()){
                                      profileScreenController. getProfileUpdate(context);
                                    }
                                    //  print(loginScreenController.loginEdtController.text);
                                  },
                                  child: const Text("Update",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15))),
                            ),
                          ],
                        )),
                  )



                ],
              ),
            ));
      },
    );
  }
}
