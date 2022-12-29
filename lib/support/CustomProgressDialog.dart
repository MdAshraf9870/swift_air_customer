import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ProgressDialogsManager extends StatelessWidget{
  const ProgressDialogsManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return const Scaffold();
  }

  void isShowProgressDialog(BuildContext context){
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.light
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.blue
      ..backgroundColor = Colors.white
      ..indicatorColor = Colors.blue
      ..textColor = Colors.black
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
      EasyLoading.show(status: 'loading...');
  }

  void isDismissProgressDialog(BuildContext context){
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.light
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.blue
      ..backgroundColor = Colors.white
      ..indicatorColor = Colors.blue
      ..textColor = Colors.black
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
    EasyLoading.dismiss();
  }

}