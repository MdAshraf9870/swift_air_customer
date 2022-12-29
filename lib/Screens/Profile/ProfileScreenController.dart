import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:swift_air_customer/Models/LoginModel.dart';
import 'package:swift_air_customer/Screens/Authantication/AuthanticationPaga.dart';
import 'package:swift_air_customer/support/CustomProgressDialog.dart';
import 'package:swift_air_customer/support/SharePreferencesManager.dart';

import '../../Apis/Apis.dart';
import '../../Models/ProfileModel.dart';
import '../../Models/getState.dart';

class ProfileScreenController extends GetxController {
  LoginModel? loginModel;
  BuildContext? context = Get.context;
  ProfileModel? profileList;

  List<GetState> getState = [];
  List<GetState> getCityList = [];
  GetState? getStateValue;
  GetState? getCityValue;
  TextEditingController NameEdt = TextEditingController();
  TextEditingController mobileNumberEdt = TextEditingController();
  TextEditingController passwordEdt = TextEditingController();
  TextEditingController emailEdt = TextEditingController();
  TextEditingController companyEdt = TextEditingController();
  TextEditingController address1Edt = TextEditingController();
  TextEditingController address2Edt = TextEditingController();
  TextEditingController pincodeEdt = TextEditingController();

  FocusNode focusNameEdt = FocusNode();
  FocusNode focusMobileNumberEdt = FocusNode();
  FocusNode focusPasswordNameEdt = FocusNode();
  FocusNode focusEmailEdt = FocusNode();
  FocusNode focusCompanyEdt = FocusNode();
  FocusNode focusAddress1Edt = FocusNode();
  FocusNode focusAddress2Edt = FocusNode();
  FocusNode focusPincodeEdt = FocusNode();

  String errorNameEdt = "";
  String errorMobileNumberEdt = "";
  String errorPasswordEdt = "";
  String errorEmailEdt = "";
  String errorCompanyEdt = "";
  String errorAddress1Edt = "";
  String errorAddress2Edt = "";
  String errorPincodeEdt = "";

  bool focusCheck = false;
  bool validation() {
    focusCheck = true;
    errorNameEdt = "";
    errorMobileNumberEdt = "";
    errorPasswordEdt = "";
    errorEmailEdt = "";
    errorCompanyEdt = "";
    errorAddress1Edt = "";
    errorAddress2Edt = "";
    errorPincodeEdt = "";

    if (NameEdt.text.isEmpty) {
      errorNameEdt = "Please enter last name.";
      if (focusCheck) {
        focusCheck = false;
        focusNameEdt.requestFocus();
      }
      update();
    }
    if (mobileNumberEdt.text.isEmpty) {
      errorMobileNumberEdt = "Please enter 10 digit No.";
      if (focusCheck) {
        focusCheck = false;
        focusMobileNumberEdt.requestFocus();
      }
      update();
    }
    if (passwordEdt.text.isEmpty) {
      errorPasswordEdt = "Please enter Password.";
      if (focusCheck) {
        focusCheck = false;
        focusPasswordNameEdt.requestFocus();
      }
      update();
    }
    if (emailEdt.text.isEmpty) {
      errorEmailEdt = "Please enter email.";
      if (focusCheck) {
        focusCheck = false;
        focusEmailEdt.requestFocus();
      }
      update();
    }
    if (companyEdt.text.isEmpty) {
      errorCompanyEdt = "Please enter company name.";
      if (focusCheck) {
        focusCheck = false;
        focusCompanyEdt.requestFocus();
      }
      update();
    }
    if (address1Edt.text.isEmpty) {
      errorAddress1Edt = "Please enter address.";
      if (focusCheck) {
        focusCheck = false;
        focusAddress1Edt.requestFocus();
      }
      update();
    }
    if (address1Edt.text.isEmpty) {
      errorAddress1Edt = "Please enter address1.";
      if (focusCheck) {
        focusCheck = false;
        focusAddress1Edt.requestFocus();
      }
      update();
    }
    if (address2Edt.text.isEmpty) {
      errorAddress2Edt = "Please enter address2.";
      if (focusCheck) {
        focusCheck = false;
        focusAddress2Edt.requestFocus();
      }
      update();
    }
    if (pincodeEdt.text.isEmpty) {
      errorPincodeEdt = "Please enter pincode.";
      if (focusCheck) {
        focusCheck = false;
        focusPincodeEdt.requestFocus();
      }
      update();
    }

    return focusCheck;
  }

  @override
  void onReady() {
    // TODO: implement onInit
    super.onReady();
    getCountry();
    SharePreferencesManager.instance.getlogindetails().then((value) {
      loginModel = value;
      // update();
      getProfile(loginModel!.customerId!,loginModel!.accessToken! );
    });
  }

  getProfile(String? customerId,String accessToken) {
    Map map = {
      "customerId": customerId,
      "accessToken": accessToken
    };
    print(map);
    Apis().callApi(map, Apis.getCustomerProfile, context!).then((value) {
      if (value != null && jsonDecode(value)["status"]) {
        print(value);
        print(jsonDecode(value)["details"]);
        profileList = ProfileModel.fromJson(jsonDecode(value)["details"]);
        update();
      }
    });
  }

  getCountry() {
    Map map = {"countrycode": "IND"};
    Apis().callApi(map, Apis.getCountry, context!).then((value) {
      if (value != null) {
        print(value);
        getState.clear();
        print(jsonDecode(value)["statedetails"]);
        jsonDecode(value)["statedetails"].forEach((v) {
          getState.add(GetState.fromJson(v));
        });
        getStateValue = getState[0];

        getCity(getState[0].statecode!);
      }
    });
  }

  getLogout(BuildContext context) {
    Map map = {
      "customerId": loginModel!.customerId,
      "accessToken":  loginModel!.accessToken
    };
    print(map);
    Apis().callApi(map, Apis.getCustomerLogout, context).then((value) {
      if (value != null) {
        print(value);
        SharePreferencesManager.instance.logout(context);
        Get.offAll(const AuthenticationPage());
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
        int position= profileList!=null ?getCityList.lastIndexWhere((element) => element.statename == profileList!.city): -1;
        getCityValue = position!=-1? getCityList[position]:getCityList[0];
       // getFillProfileDetails(profileList);
        update();
      }
    });
  }

  getFillProfileDetails(ProfileModel? profileList) {
    NameEdt.text = profileList!.name!;
    mobileNumberEdt.text = profileList.phone!;
    passwordEdt.text = profileList.password!;
    emailEdt.text = profileList.email!;
    companyEdt.text = profileList.company!;
    //_____Address info----//
    address1Edt.text = profileList.houseNo!;
    address2Edt.text = profileList.street!;
    pincodeEdt.text = profileList.postcode!;
    getStateValue = getState[getState.lastIndexWhere((element) => element.statename == profileList.state)];
    getCity(getStateValue!.statecode!);
    update();
  }

  // "name":"",
  // "email":"",
  // "company":"",
  // "password":"",
  // "house_no":"",
  // "street":"",
  // "city":"",
  // "state":"",
  // "postcode":""
  getProfileUpdate(BuildContext context) {
    ProgressDialogsManager().isShowProgressDialog(context);
    Map map = {
      "customerId": loginModel!.customerId!,
      "accessToken": loginModel!.accessToken,
      "name": NameEdt.text,
      "email": emailEdt.text,
      "company":companyEdt.text ,
      "password": passwordEdt.text,
      "house_no": address1Edt.text,
      "street": address2Edt.text,
      "city": getCityValue!.statename,
      "state": getStateValue!.statename,
      "postcode": pincodeEdt.text
    };
    print(map);
    Apis().callApi(map, Apis.getCustomerUpdateProfile, context).then((value) {
      if (value != null) {
        ProgressDialogsManager().isDismissProgressDialog(context);
        print(value);
        print(jsonDecode(value)["details"]);
        getProfile(loginModel!.customerId,loginModel!.accessToken!);
        update();
      }
    });
  }
}
