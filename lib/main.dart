
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'Screens/Authantication/AuthanticationPaga.dart';
import 'Screens/Dashboard/Dashboard.dart';
import 'Screens/GoogleMapScreen.dart';
import 'Screens/Profile/ProfileScreen.dart';
import 'Screens/SplashScreen.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      // home: const AuthenticationPage(),
      home: const SplashScreen(),
        builder: EasyLoading.init(),
      // home:  ProfileScreen()
      //   home:  Dashbaord()
    );
  }
}
