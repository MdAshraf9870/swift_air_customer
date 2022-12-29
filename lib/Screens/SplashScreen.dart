import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:swift_air_customer/Screens/Dashboard/Dashboard.dart';
import 'package:swift_air_customer/support/SharePreferencesManager.dart';

import 'Authantication/AuthanticationPaga.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 3)).then((value) async {
      if(await Permission.location.isDenied){
        await Permission.location.request();
      }
      try{
        SharePreferencesManager.instance.getlogindetails().then((value) {
          print(value.status);
          if(value.status!=null && value.status!){
            Get.offAll(Dashbaord());
          }else{
            Get.offAll(AuthenticationPage());
          }
        });
      }catch(e){
        Get.offAll(AuthenticationPage());
        print(e);

      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/Ssplash.png")
      )
    ),
    );
  }
}
