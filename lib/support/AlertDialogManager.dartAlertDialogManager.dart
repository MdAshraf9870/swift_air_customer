
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../AppConst/AppConst.dart';


class AlertDialogManager{

  void IsAlertDialogMessage(BuildContext context, String title,String msg,Function() onTap){
    showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text(title),
              content: Text(msg),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    backgroundColor: Colors.black,
                  ),
                  child: Text("Ok"),
                )
              ],
            ));
  }
  void IsAlertLogoutDialogMessage(BuildContext context, String title,String msg,Function()? onTap){
    showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text(title),
              content: Text(msg),
              actions: <Widget>[
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: onTap,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          backgroundColor: Colors.red,
                        ),
                        child: Text("Ok"),
                      ),
                      SizedBox(width: 15,),
                      ElevatedButton(
                        onPressed: ()=>Get.back(),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          backgroundColor: AppConst.buttonColors,
                        ),
                        child: const Text("Cancel"),
                      )
                    ],),
                )
              ],
            ));
  }


  void IsErrorAlertDialogMassage(BuildContext context, String title,String msg){
    showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text(title),
              content: Text(msg),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                      Navigator.pop(context, false);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    backgroundColor: Colors.black,
                  ),
                  child: Text("Ok"),
                )
              ],
            ));
}


  static showSnackBarToOpenFile(BuildContext context,String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: AppBarTheme().backgroundColor,
      duration: const Duration(milliseconds: 4000),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(msg,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
          ElevatedButton(onPressed: ()=> openAppSettings(), child: Text("Open",style:TextStyle(color: Colors.white,fontWeight: FontWeight.w600)),
            style: ElevatedButton.styleFrom(
                backgroundColor: AppConst.buttonColors
            ),
          )
        ],
      ),
      //   action: SnackBarAction(
      //   label: 'Open File',
      //   onPressed: () {
      //     OpenFile.open(path);
      //   },
      // ),
    ));
  }
}