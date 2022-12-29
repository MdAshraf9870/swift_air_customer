import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:swift_air_customer/Models/BookingAddressModel.dart';

import '../../Apis/Apis.dart';
import '../../Models/LoginModel.dart';
import 'package:http/http.dart'as http;
import '../../Models/getState.dart';
import '../../Models/polyline_response.dart';
import '../../support/AlertDialogManager.dartAlertDialogManager.dart';
import '../../support/CustomProgressDialog.dart';
import '../../support/SharePreferencesManager.dart';


import '../LocationManager.dart';
import '../ThankYouPage.dart';

class BookingOrderController extends GetxController {
String date="Date",time="time";
  BuildContext context;
  LoginModel? loginModel;
  bool addDetails=false;
  bool schedule=false;
  int bookingPage=0;
  TextEditingController senderNameEdt = TextEditingController();
  TextEditingController lastNameEdt = TextEditingController();
  TextEditingController senderMobileNumberEdt = TextEditingController();
  TextEditingController quantityEdt = TextEditingController();
  TextEditingController valueEdt = TextEditingController();
  TextEditingController heightEdt = TextEditingController();
  TextEditingController widthEdt = TextEditingController();
  TextEditingController lengthEdt = TextEditingController();
  TextEditingController weightEdt = TextEditingController();
  TextEditingController specialInstructions = TextEditingController();

  TextEditingController receiverNameEdt = TextEditingController();
  TextEditingController receiverMobileNoEdt = TextEditingController();
  TextEditingController receiverAddressEdt = TextEditingController();

  TextEditingController passwordEdt = TextEditingController();
  TextEditingController emailEdt = TextEditingController();
  TextEditingController companyEdt = TextEditingController();
  TextEditingController pickUpAddressEdt = TextEditingController();
  TextEditingController address2Edt = TextEditingController();
  TextEditingController pincodeEdt = TextEditingController();

  FocusNode focusSenderNameEdt = FocusNode();
  FocusNode focusLastNameEdt = FocusNode();
  FocusNode focusSenderMobileNumberEdt = FocusNode();
  FocusNode focusQuantityrEdt = FocusNode();
  FocusNode focusValuerEdt = FocusNode();
  FocusNode focusHeightrEdt = FocusNode();
  FocusNode focusWidthEdt = FocusNode();
  FocusNode focusLengthEdt = FocusNode();
  FocusNode focusWeightEdt = FocusNode();
  FocusNode focusReceiverNameEdt = FocusNode();
  FocusNode focusReceiverMobileNoEdt = FocusNode();
  FocusNode focusReceiverAddressEdt = FocusNode();

  FocusNode focusPasswordNameEdt = FocusNode();
  FocusNode focusEmailEdt = FocusNode();
  FocusNode focusCompanyEdt = FocusNode();
  FocusNode focusPickUpAddressEdt = FocusNode();
  FocusNode focusAddress2Edt = FocusNode();
  FocusNode focusPincodeEdt = FocusNode();

  String errorSenderNameEdt = "";
  String errorLastNameEdt = "";
  String errorSenderMobileNumberEdt = "";
  String errorQuantityEdt = "";
  String errorValueEdt = "";
  String errorHeighteEdt = "";
  String errorWidthEdt = "";
  String errorLengthEdt = "";
  String errorWeightEdt = "";
  String errorReceiverNameEdt = "";
  String errorReceiverMobileNoEdt = "";
  String errorReceiverAddressEdt = "";

  String errorPasswordEdt = "";
  String errorEmailEdt = "";
  String errorCompanyEdt = "";
  String errorPickUpAddressEdt = "";
  String errorAddress2Edt = "";
  String errorPincodeEdt = "";
List<String> docTypeList=["Document","Non-Document"];
String docTypeValue="Document";
List<String> packetTypeList=["General","ATM Card","BNR","CD","Cheque Book","First Biller","Hold Delivery","PDF-Duplicate",
  "Platinum","Priority Delivery","Repeat BNR","Solitaire","Statement","VIP","VVIP"];
String packetTypeValue="General";
  List<String> packetClassifyList=["GENERAL","BULK","CARD/KIT","LCB/Bills","Super Premium","Urgent"];
  String packetClassifyValue="GENERAL";
  List<GetState> getState = [];
  List<GetState> getCityList = [];
  GetState? getStateValue;
  GetState? getCityValue;
  BookingAddressModel? bookingAddressModel;
  Set<Marker> markers = Set();
  BookingOrderController(this. bookingAddressModel,this.context);
  final Completer<GoogleMapController> controller = Completer();
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  LocationManager locationManager = Get.put(
    LocationManager(),
  );
   CameraPosition? kGooglePlex ;
   bool isCurrentLocationRecived=false;
  PolylineResponse polylineResponse = PolylineResponse();
  Set<Polyline> polylinePoints = {};
  @override
void onInit() {

    getCurrentLocation();

      senderNameEdt.text=bookingAddressModel!.fromName!;
      senderMobileNumberEdt.text=bookingAddressModel!.fromMobile!;
      pickUpAddressEdt.text=bookingAddressModel!.fromAdress ?? "";

      receiverAddressEdt.text=bookingAddressModel!.toAdress ?? "";
    getCountry();
    SharePreferencesManager.instance.getlogindetails().then((value) {
      loginModel = value;

      if(bookingAddressModel!.fromAdress==loginModel!.address){
        getAddressToLatLng();
      }else{
        var point=LatLng(double.parse(bookingAddressModel!.toLat.toString()), double.parse(bookingAddressModel!.toLng.toString()));
        markers.add(
          Marker(
            markerId: MarkerId(
              point.toString(),
            ),
            position: point,
            infoWindow: InfoWindow(
              title: bookingAddressModel!.toAdress!,
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ),);
        var point2=LatLng(double.parse(bookingAddressModel!.fromLat!), double.parse(bookingAddressModel!.fromLng!));
        markers.add(Marker(
          markerId: MarkerId(
            point2.toString(),
          ),
          position: point2,
          infoWindow: InfoWindow(
            title: bookingAddressModel!.toAdress!,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),);
        update();
      }

      // update()
    });
  }

  getCountry() {
    Map map = {"countrycode": "IND"};
    Apis().callApi(map, Apis.getCountry, context).then((value) {
      if (value != null) {
        print(value);
        print(jsonDecode(value)["statedetails"]);
        jsonDecode(value)["statedetails"].forEach((v) {
          getState.add(GetState.fromJson(v));
        });
        getStateValue = getState[0];

        getCity(getState[0].statecode!);
      }
    });
  }

  getCity(String value) {
    Map map = {"statecode": value};
    Apis().callApi(map, Apis.getCity, context).then((value) {
      if (value != null) {
        print(value);
        getCityList.clear();
        print(jsonDecode(value)["citydetails"]);
        jsonDecode(value)["citydetails"].forEach((v) {
          getCityList.add(GetState(v["citycode"], v["cityname"]));
        });
        getCityValue = getCityList[0];

        update();
      }
    });
  }

  bool focusCheck = false;
  bool validation() {
    focusCheck = true;
    errorSenderNameEdt = "";
    errorLastNameEdt = "";
    errorSenderMobileNumberEdt = "";
    errorPasswordEdt = "";
    errorEmailEdt = "";
    errorCompanyEdt = "";
    errorPickUpAddressEdt = "";
    errorAddress2Edt = "";
    errorPincodeEdt = "";

    if (receiverNameEdt.text.isEmpty) {
      errorReceiverNameEdt = "Please enter receiver name.";
      if (focusCheck) {
        focusCheck = false;
        focusReceiverNameEdt.requestFocus();
      }
      update();
    }
    if (receiverMobileNoEdt.text.isEmpty) {
      errorReceiverMobileNoEdt = "Please enter receiver mobile no.";
      if (focusCheck) {
        focusCheck = false;
        focusReceiverMobileNoEdt.requestFocus();
      }
      update();
    }

    return focusCheck;
  }

  getBookOrder(BuildContext context) {
    try {
      ProgressDialogsManager().isShowProgressDialog(context);
      Map map = {
          "customerId": loginModel!.customerId,
          "accessToken": loginModel!.accessToken,
          "booking_date": "a",

          "sender_name": senderNameEdt.text,
          "sender_phone": senderMobileNumberEdt.text,
          "from_location": pickUpAddressEdt.text,
          "pickup_lat": bookingAddressModel!.fromLat ?? "",
          "pickup_long": bookingAddressModel!.fromLng ?? "",

          "to_name": receiverNameEdt.text,
          "to_phone": receiverMobileNoEdt.text,
          "to_location": receiverAddressEdt.text,
          "to_lat": bookingAddressModel!.toLat ?? "",
          "to_long": bookingAddressModel!.toLng ?? "",

          "qty": quantityEdt.text,
          "value": valueEdt.text,

          "height": heightEdt.text,
          "width": widthEdt.text,
          "length": lengthEdt.text,
          "weight": weightEdt.text,


          "doc_type":docTypeValue,
          "packet_type": packetTypeValue,
          "packet_classify": packetClassifyValue,

          "priority": "",
            "special_instructions": specialInstructions,
          "vehicle_type": "",
          "priority_colour": ""
        };
      Apis().callApi(map, Apis.getCustcreateOrder, context).then((value) {
        print(jsonDecode(value));
        if (value != null && jsonDecode(value)["status"]) {
          print(jsonDecode(value)["message"]);
         Get.to(ThankYouPage(orderId: jsonDecode(value)["orderId"],));
          // AlertDialogManager().IsAlertDialogMessage(
          //     context, "Success", jsonDecode(value)["message"], () {
          //  // Get.offAll(LoginScreen());
          // });
        } else if (value != null && !jsonDecode(value)["status"]) {
          AlertDialogManager().IsAlertDialogMessage(
              context, "Error", jsonDecode(value)["message"], () {
            print(value);
            Get.back();
          });
        }
        ProgressDialogsManager().isDismissProgressDialog(context);
      });
    } catch (e) {
      ProgressDialogsManager().isDismissProgressDialog(context);
      print(e.toString());
    }
  }
  LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 2,
  );
  getCurrentLocation() async {
    kGooglePlex= CameraPosition(
      target: LatLng(double.parse(bookingAddressModel!.toLat.toString()), double.parse(bookingAddressModel!.toLng.toString())),
      zoom: 100,
    );
      GoogleMapController controller = await this.controller.future;
      ProgressDialogsManager().isDismissProgressDialog(context);
      isCurrentLocationRecived = true;
      controller.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(double.parse(bookingAddressModel!.toLat.toString()), double.parse(bookingAddressModel!.toLng.toString())),12.2),
      );

    // var point2=LatLng(double.parse(loginModel!.fromLat.toString()), double.parse(loginModel!.fromLong.toString()));
    // var point2=LatLng(28.6919986, 77.174678);
    // print(loginModel!.fromLat.toString());
    // markers.add(
    //   Marker(
    //     markerId: MarkerId(
    //       point2.toString(),
    //     ),
    //     position: point2,
    //     infoWindow: InfoWindow(
    //       title: bookingAddressModel!.toAdress!,
    //     ),
    //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    //   ),
    //
    // );
      update();
      // _getPlace(position.latitude, position.longitude,type: type);


  }

  getAddressToLatLng() async{
    String tempLat,tempLng;
    try{

      print(loginModel!.address);
      var d = await http.get(Uri.parse("https://www.google.com/maps/search/?api=1&query=${loginModel!.postcode}"));

      tempLat=d.body.toString().split("https://maps.google.com/maps/api/staticmap?center=")[1].toString().split("%2C")[0];
      tempLng=d.body.toString().split("https://maps.google.com/maps/api/staticmap?center=")[1].toString().split("%2C")[1].split("&amp")[0];

      print(tempLat);
      print(tempLng);
      var point=LatLng(double.parse(bookingAddressModel!.toLat.toString()), double.parse(bookingAddressModel!.toLng.toString()));
      markers.add(
        Marker(
          markerId: MarkerId(
            point.toString(),
          ),
          position: point,
          infoWindow: InfoWindow(
            title: bookingAddressModel!.toAdress!,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),);
      var point2=LatLng(double.parse(tempLat), double.parse(tempLng));
      markers.add(Marker(
        markerId: MarkerId(
          point2.toString(),
        ),
        position: point2,
        infoWindow: InfoWindow(
          title: bookingAddressModel!.toAdress!,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),);
      update();
    }catch(e){
      var point=LatLng(double.parse(bookingAddressModel!.toLat.toString()), double.parse(bookingAddressModel!.toLng.toString()));
      markers.add(
        Marker(
          markerId: MarkerId(
            point.toString(),
          ),
          position: point,
          infoWindow: InfoWindow(
            title: bookingAddressModel!.toAdress!,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),);
      update();
    }

    // print(d.body.toString().split("https://maps.google.com/maps/api/staticmap?center=")[1].toString().split("%2C")[0]);
    // print(d.body.toString().split("https://maps.google.com/maps/api/staticmap?center=")[1].toString().split("%2C")[1].split("&amp")[0]);

  }
  void drawPolyline(tempLat,tempLng) async {
    var response = await http.post(Uri.parse("https://maps.googleapis.com/maps/api/directions/json?key="
        +Apis.kGoogleApiKey+
        "&units=metric&origin=" +
        tempLat +
        "," +
        tempLng +
        "&destination=" +
        bookingAddressModel!.toLat! +
        "," +
        bookingAddressModel!.toLng! +
        "&mode=driving"));

    print(response.body);

    polylineResponse = PolylineResponse.fromJson(jsonDecode(response.body));
    //
    // totalDistance = polylineResponse.routes![0].legs![0].distance!.text!;
    // totalTime = polylineResponse.routes![0].legs![0].duration!.text!;

    for (int i = 0; i < polylineResponse.routes![0].legs![0].steps!.length; i++) {
      polylinePoints.add(Polyline(polylineId:
      PolylineId(polylineResponse.routes![0].legs![0].steps![i].polyline!.points!), points: [
        LatLng(
            polylineResponse.routes![0].legs![0].steps![i].startLocation!.lat!, polylineResponse.routes![0].legs![0].steps![i].startLocation!.lng!),
        LatLng(polylineResponse.
        routes![0].legs![0].steps![i].endLocation!.lat!, polylineResponse.routes![0].legs![0].steps![i].endLocation!.lng!),
      ],width: 3,color: Colors.blue,
          endCap: Cap.roundCap,
          startCap: Cap.roundCap,
          jointType: JointType.round
      ));
    }
    update();
    // PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
    //   apiKey,
    //   PointLatLng(startLocation.latitude, startLocation.longitude),
    //   PointLatLng(endLocation.latitude, endLocation.longitude),
    //   travelMode: TravelMode.driving,
    // );


  }
}
