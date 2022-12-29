import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationManager extends GetxController {
  // static double Latitude=0.0;
  //
  // LocationManager(){
  //   getLocation();
  // }

  LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 2,
  );

  Future<bool> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
    return true;
  }

  RxString currentPosition = ''.obs;

  //Rx<Position>? currposition;
  RxDouble latitude = 0.0.obs, longitude = 0.0.obs;

 Future<Position?> getLocation() async {
    // _onLoading();
    StreamSubscription<Position>? positionStream;
    determinePosition().then((value) {
      positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position? position) {
        if (position != null) {
          currentPosition.value = '${position.latitude.toString()},${position.longitude.toString()}';
          //   currposition!.value=position;
          latitude.value = position.latitude;
          longitude.value = position.longitude;
        }

        currentPosition.refresh();
        latitude.refresh();
        longitude.refresh();
        positionStream!.cancel();


      });
    }, onError: (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text(e),
      ));
    });
  }
}
