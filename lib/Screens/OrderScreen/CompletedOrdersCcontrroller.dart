import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Apis/Apis.dart';
import '../../Models/LoginModel.dart';
import '../../Models/OngoingModel.dart';
import '../../support/CustomProgressDialog.dart';
import '../../support/SharePreferencesManager.dart';

class CompletedOrdersContrroller extends GetxController{

  List<OngoingModel> onGoingList=[];
  LoginModel? loginModel;

  BuildContext? context= Get.context;
  @override
  void onReady() {
    // TODO: implement onInit
    super.onReady();
    SharePreferencesManager.instance.getlogindetails().then((value) {
      loginModel = value;
      // update();
      getOngoingOrders(loginModel!.customerId!,loginModel!.accessToken! );
    });
  }



  getOngoingOrders(String? customerId,String accessToken) {
    ProgressDialogsManager().isShowProgressDialog(context!);
    Map map = {
      "customerId": customerId,
      "accessToken": accessToken
    };
    print(map);
    Apis().callApi(map, Apis.getCustcompletedorders, context!).then((value) {
      if (value != null && jsonDecode(value)["status"]) {
        ProgressDialogsManager().isDismissProgressDialog(context!);
        print(value);
        onGoingList.clear();
        print(jsonDecode(value)["orders"]);
        List data=jsonDecode(value)["orders"];
        data.forEach((element) {
          onGoingList.add(OngoingModel.fromJson(element));
        });
        update();
      }
      ProgressDialogsManager().isDismissProgressDialog(context!);
    });
  }
}