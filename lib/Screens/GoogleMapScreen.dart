// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swift_air_customer/Apis/Apis.dart';
import 'package:swift_air_customer/AppConst/AppConst.dart';
import 'package:swift_air_customer/Models/BookingAddressModel.dart';
import 'package:swift_air_customer/Models/GoogleAddressModel.dart';
import 'package:swift_air_customer/Models/LoginModel.dart';
import 'package:swift_air_customer/support/SharePreferencesManager.dart';
import 'package:http/http.dart' as http;
import '../support/CustomProgressDialog.dart';
import 'BookingOrder/BookingOrder.dart';
import 'LocationManager.dart';
import 'ThankYouPage.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';

class GoogleMapScreen extends StatefulWidget {
  String type;

  @override
  State<GoogleMapScreen> createState() => MapSampleState();

  GoogleMapScreen(this.type, {Key? key}) : super(key: key);
}

class MapSampleState extends State<GoogleMapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(28.7164338, 77.2369857),
    zoom: 4.5,
  );
  TextEditingController nameEdt = TextEditingController();
  TextEditingController numberEdt = TextEditingController();
  bool isCurrentLocationRecived = false;
  bool permissionOn = false;
  BookingAddressModel bookingAddressModel =BookingAddressModel();
  LocationManager locationManager = Get.put(
    LocationManager(),
  );
  final destinationAddressController = TextEditingController();
  Placemark? placeMark;
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  bool boxVisibility = false;
  Set<Marker> markers = Set();
  String destinationAddress = '';
  String _destinationAddress = "";
  double destinationLatitude = 0.0;
  double destinationLongitude = 0.0;
  String _currentAddress = "";
  LoginModel? loginModel;
  // var kGoogleApiKey = 'AIzaSyA0Rx4E-BYlFldkYosPDom81hEcMVaa2fc';
  // var kGoogleApiKey = 'AIzaSyAcaYXGeP8OK8olF8Zy-9kX1v7rmgbxqAs';
  final Mode _mode = Mode.fullscreen;
  String? address,pickupLocation,deliveryLocation;
  int type=3;
  @override
  void initState() {
    super.initState();
    //locationManager.getLocation();


    getCurrentLocation();
    SharePreferencesManager.instance.getlogindetails().then((value) {
      setState(() {
        loginModel = value;
        print(value.phone);
        nameEdt.text = loginModel!.name!;
        numberEdt.text = loginModel!.phone!;
        address=loginModel!.address!;
        bookingAddressModel.fromAdress=address;
      });
    });
  }
  // https://maps.googleapis.com/maps/api/place/details/json?fields=name%d%2Cformatted_phone_number&place_id=ChIJN1t_tDeuEmsRUsoyG83frY4&key=AIzaSyA0Rx4E-BYlFldkYosPDom81hEcMVaa2fc
  // // https://maps.googleapis.com/maps/api/place/details/json?fields=des%2Crating%2Cformatted_phone_number&place_id=ChIJN1t_tDeuEmsRUsoyG83frY4&key=/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 100),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 80.0),
                    child: GoogleMap(
                      mapType: MapType.normal,
                      myLocationEnabled: isCurrentLocationRecived,
                      indoorViewEnabled: true,
                      myLocationButtonEnabled: isCurrentLocationRecived,
                      compassEnabled: false,
                      initialCameraPosition: _kGooglePlex,
                      markers: Set<Marker>.from(markers),
                      onTap: _handleTap,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    ),
                  ),
                  (isCurrentLocationRecived)
                      ? const SizedBox(
                          height: 0,)
                      : Shimmer.fromColors(
                          baseColor: Colors.grey.withOpacity(0.9),
                          highlightColor: Colors.white,
                          enabled: !isCurrentLocationRecived,
                          child: Container(
                            width: Get.width,
                            height: Get.height,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Container(
                  width: Get.width * 0.82,
                  height: 100,
                  padding: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      border: Border.all(width: 0.5),
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          _handlePressButton(searchTitle:"  Pickup Location",0 );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            // Icon(Icons.location_searching),
                            Icon(
                              Icons.my_location,
                              color: AppConst.buttonColors,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Expanded(
                              child: Text(
                                pickupLocation ?? address.toString(),
                                style: TextStyle(
                                    color: AppConst.buttonColors,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.more_vert,
                            color: Colors.grey,
                          ),
                          Expanded(
                              child: Divider(
                            thickness: 1,
                            height: 1,
                            color: Colors.grey,
                          ))
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          _handlePressButton(searchTitle: "  Enter Destination",1);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children:  [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 6,
                            ),

                            Expanded(
                              child: Text(
                                deliveryLocation ?? "Choose Destination",
                                style: TextStyle(
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )),

              /*SizedBox(
                width: Get.width*0.8,
                child: textfield(destinationAddressController,
                  "Search Location",
                  callback: (String value) {
                    setState(() {
                      _destinationAddress = value;
                    });
                  },
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        destinationAddressController.text.toString().isNotEmpty
                            ? InkWell(
                                onTap: () {
                                  destinationAddressController.clear();
                                },
                                child: Container(
                                  decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                                  height: 15,
                                  width: 15,
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                              )
                            : const Text(""),
                        const SizedBox(width: 5),
                        InkWell(
                          onTap: () {
                            getNewLocation();
                          },
                          child: const SizedBox(
                            height: 40,
                            width: 40,
                            child: Icon(Icons.search),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),*/
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: Get.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey, blurRadius: 10, spreadRadius: 1)
                    ]),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                    mainAxisSize: MainAxisSize.max,
                      children: [
                        const Icon(Icons.share_location_rounded),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Text(
                            'Pickup Location'.toString().toUpperCase(),
                            style:  TextStyle(fontWeight: FontWeight.w500,color: AppConst.buttonColors),
                          ),
                        ),
                        if(pickupLocation!=null)
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              bookingAddressModel.fromAdress=address;
                              bookingAddressModel.fromLng="";
                              bookingAddressModel.fromLat="";

                              pickupLocation=null;
                            });

                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                            decoration: BoxDecoration(
                              color: AppConst.buttonColors,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Text(
                              'Default Address'.toString().toUpperCase(),
                              style:  TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            // placeMark!.subLocality.toString().toUpperCase(),
                            pickupLocation==null? address.toString().toUpperCase():pickupLocation.toString().toUpperCase(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    // (placeMark == null)
                    //     ? Shimmer.fromColors(
                    //         baseColor: Colors.black12,
                    //         highlightColor: Colors.white,
                    //         child: Container(
                    //           height: 20,
                    //           width: Get.width,
                    //           color: Colors.black12,
                    //         ),
                    //       )
                    //     : Text(
                    //         _currentAddress.isEmpty
                    //             ? '${placeMark!.street.toString()},${placeMark!.name.toString()},${placeMark!.subLocality.toString()},'
                    //                 '${placeMark!.locality.toString()},${placeMark!.administrativeArea.toString()},'
                    //                 '${placeMark!.postalCode.toString()},${placeMark!.country.toString()}'
                    //             : _currentAddress,
                    //         style:
                    //             const TextStyle(fontWeight: FontWeight.normal),
                    //       ),
                    const SizedBox(
                      height: 8,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 45,
                          child: TextFormField(
                            controller: nameEdt,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(4),
                                fillColor: Colors.grey.shade200,
                                filled: true,
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15))),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          height: 45,
                          child: TextFormField(
                            controller: numberEdt,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(4),
                                fillColor: Colors.grey.shade200,
                                filled: true,
                                prefixIcon: Icon(Icons.call),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15))),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: Get.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppConst.buttonColors,
                            shape: RoundedRectangleBorder(
                                // side: BorderSide(
                                //
                                // ),
                                borderRadius: BorderRadius.circular(15))),
                        onPressed: () {
                          bookingAddressModel.fromName=nameEdt.text;
                          bookingAddressModel.fromMobile=numberEdt.text;


                          // SharePreferencesManager.instance.getlogindetails().then((value) {
                          //   setState(() {
                          //     // loginModel=value;
                          //     // print(value.phone);
                          //     // nameEdt.text=loginModel!.name!;
                          //     // numberEdt.text=loginModel!.phone!;
                          //
                          //
                          //
                          //   });
                          //   });
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 2,
  );
  getCurrentLocation() async {
    ProgressDialogsManager().isShowProgressDialog(context);
    StreamSubscription<Position>? positionStream;
    final GoogleMapController controller = await _controller.future;
    locationManager.determinePosition().then((value) {
      positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position? position) {
        print(position!.longitude.toString()+"djbjdsbf");
        if (position != null) {
            setState(() {
              ProgressDialogsManager().isDismissProgressDialog(context);
              isCurrentLocationRecived = true;
              controller.animateCamera(
                CameraUpdate.newLatLngZoom(LatLng(position.latitude, position.longitude), 14.0),
              );
            });
            _getPlace(position.latitude, position.longitude,type: type);

        }
        ProgressDialogsManager().isDismissProgressDialog(context);
        positionStream!.cancel();


      });
    }, onError: (e) {
      ProgressDialogsManager().isDismissProgressDialog(context);
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text("Error  :"+e.toString()),
      ));
    });
    print(locationManager.latitude.value);
    /*Future.delayed(
      const Duration(seconds: 5),
    ).then((value) async {
      CameraPosition kLake = CameraPosition(
          bearing: 192.8334901395799,
          target: LatLng(
              (locationManager.latitude.value != 0.0)
                  ? locationManager.latitude.value
                  : 0.0,
              (locationManager.latitude.value != 0.0)
                  ? locationManager.longitude.value
                  : 0.0),
          tilt: 59.440717697143555,
          zoom: 23.151926040649414);


      if ((locationManager.latitude.value != 0.0)) {
        setState(() {
          isCurrentLocationRecived = true;
          controller.animateCamera(
            // CameraUpdate.newCameraPosition(kLake),
            CameraUpdate.newLatLngZoom(LatLng(locationManager.latitude.value, locationManager.longitude.value), 14.0),
          );
        });
        _getPlace(locationManager.latitude.value, locationManager.longitude.value);
      }
    });*/
  }
  // https://maps.googleapis.com/maps/api/geocode/json?latlng=28.7164338,77.2369857&key=AIzaSyA0Rx4E-BYlFldkYosPDom81hEcMVaa2fc
    GoogleAddressModel googleAddressModel =GoogleAddressModel();
  void _getPlace(double? lat, double? long,{String? g,int type=3}) async {
  try{
    final url="${Apis.getaddress}$lat,$long&key=${Apis.kGoogleApiKey}";
    print(url);
    var response= await http.get(Uri.parse(url));
    print(response.body);
    if(response.statusCode==200){
      googleAddressModel=GoogleAddressModel.fromJson(jsonDecode(response.body));
      print(googleAddressModel.results![0].formattedAddress);
      setState(() {
        _currentAddress=googleAddressModel.results![0].formattedAddress!;
        if(type==0){
          this.type=type;
          bookingAddressModel.fromLat=lat.toString();
          bookingAddressModel.fromLng=long.toString();
          bookingAddressModel.fromAdress=_currentAddress;
          pickupLocation=_currentAddress;
        }else if(type==1){
          this.type=4;
          bookingAddressModel.toLat=lat.toString();
          bookingAddressModel.toLng=long.toString();
          bookingAddressModel.toAdress=_currentAddress;
          deliveryLocation=_currentAddress;
          bookingAddressModel.fromName=nameEdt.text;
          bookingAddressModel.fromMobile=numberEdt.text;
          Get.to(BookingOrder(bookingAddressModel));
        }
        destinationAddressController.text = _currentAddress;
        destinationAddress = _currentAddress;
      });
    }

  }catch(e){
    print(e);
  }

    
    // List<Placemark> placeMarks = await placemarkFromCoordinates(lat!, long!,localeIdentifier: g ??"");
    // setState(() {
    //   placeMark = placeMarks[0];
    //   _currentAddress ="${placeMark!.subLocality}, " "${placeMark!.name}, ${placeMark!.locality}, ${placeMark!.postalCode}, ${placeMark!.country}";
    //   if(type==0){
    //     bookingAddressModel.fromLat=lat.toString();
    //     bookingAddressModel.fromLng=long.toString();
    //     bookingAddressModel.fromAdress=_currentAddress;
    //     pickupLocation=_currentAddress;
    //   }else if(type==1){
    //     bookingAddressModel.toLat=lat.toString();
    //     bookingAddressModel.toLng=long.toString();
    //     bookingAddressModel.toAdress=_currentAddress;
    //     deliveryLocation=_currentAddress;
    //   }
    //   destinationAddressController.text = _currentAddress;
    //   destinationAddress = _currentAddress;
    // });
    // print(
    //   placeMark.toString(),
    // );
  }

  // Future<bool> getNewLocation() async {
  //   List<Location> destinationPlacemark = await locationFromAddress(_destinationAddress);
  //   destinationLatitude = destinationPlacemark[0].latitude;
  //   destinationLongitude = destinationPlacemark[0].longitude;
  //
  //   String destinationCoordinatesString = '($destinationLatitude, $destinationLongitude)';
  //
  //   Marker destinationMarker = Marker(
  //     markerId: MarkerId(destinationCoordinatesString),
  //     position: LatLng(destinationLatitude, destinationLongitude),
  //     infoWindow: InfoWindow(
  //       title: 'Destination $destinationCoordinatesString',
  //       snippet: _destinationAddress,
  //     ),
  //     icon: BitmapDescriptor.defaultMarker,
  //   );
  //   markers.clear();
  //   markers.add(destinationMarker);
  //   GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(
  //     CameraUpdate.newCameraPosition(
  //       CameraPosition(target: LatLng(destinationLatitude, destinationLongitude), zoom: 13.8),
  //     ),
  //   );
  //
  //   return false;
  // }

  _handleTap(LatLng point) {
    setState(() {
      markers.clear();
      markers.add(
        Marker(
          markerId: MarkerId(
            point.toString(),
          ),
          position: point,
          infoWindow: InfoWindow(
            title: point.latitude.toString(),
            snippet: _destinationAddress,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
      getTapAddress(point);
    });
  }

  getTapAddress(LatLng point) async {
    try{
      final url="${Apis.getaddress}${point.latitude},${point.longitude}&key=${Apis.kGoogleApiKey}";
      print(url);
      var response= await http.get(Uri.parse(url));
      print(response.body);
      if(response.statusCode==200){
        googleAddressModel=GoogleAddressModel.fromJson(jsonDecode(response.body));
        print(googleAddressModel.results![0].formattedAddress);
        setState(() {
          _currentAddress=googleAddressModel.results![0].formattedAddress!;
          deliveryLocation=_currentAddress;
          bookingAddressModel.toLat=point.latitude.toString();
          bookingAddressModel.toLng=point.longitude.toString();
          bookingAddressModel.toAdress=_currentAddress;
          destinationAddressController.text = _currentAddress;
        });
      }

    }catch(e){
      print(e);
    }




    //
    // try {
    //   List<Placemark> p = await placemarkFromCoordinates(point.latitude, point.longitude);
    //   placeMark = p[0];
    //   print(placeMark);
    //   setState(() {
    //     _currentAddress =
    //         "${placeMark!.subLocality}, ${placeMark!.name}, ${placeMark!.locality}, ${placeMark!.postalCode}, ${placeMark!.country}";
    //     deliveryLocation=_currentAddress;
    //
    //     destinationAddress = _currentAddress;
    //   });
    // } catch (e) {
    //   print("Error Address : " + e.toString());
    // }
  }

  Widget textfield(TextEditingController textEditingController, String hint,
      {Widget? icon, Function(String)? callback}) {
    return SizedBox(
      height: 45,
      child: TextFormField(
        onChanged: (v) {
          callback!(v);
        },
        controller: textEditingController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 8),
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          suffixIcon: icon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 1, color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 1, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Future<void> _handlePressButton(int type,{String? searchTitle}) async {
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: Apis.kGoogleApiKey,
        onError: onError,

        mode: _mode,
        language: 'en',
        strictbounds: false,
        types: [""],

        decoration: InputDecoration(
            suffixIcon: type==0?IconButton(onPressed: () {   getCurrentLocation();
            this.type=type;
            Get.back();
            },icon: const Icon(Icons.my_location,color: Colors.white,),):null,
            hintText: searchTitle ?? 'Search',
            hintStyle: TextStyle(color: Colors.black),

            // focusedBorder: OutlineInputBorder(
            //     borderRadius: BorderRadius.circular(20),
            //     borderSide: BorderSide(color: Colors.white))
        ),
        components: [
          Component(Component.country, "in"),
          Component(Component.country, "in")
        ]);




    displayPrediction(p!, homeScaffoldKey.currentState,type);


  }

  void onError(PlacesAutocompleteResponse response) {
    print(response.errorMessage);

    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   elevation: 0,
    //   behavior: SnackBarBehavior.floating,
    //   backgroundColor: Colors.transparent,
    //   content: AwesomeSnackbarContent(
    //     title: 'Message',
    //     message: response.errorMessage!,
    //     contentType: ContentType.failure,
    //   ),
    // ));

    // homeScaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(response.errorMessage!)));
  }

  Future<void> displayPrediction(Prediction p, ScaffoldState? currentState,int type) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: Apis.kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders());

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;
    print(lat.toString()+"dkmcdmcklwdmk");
    markers.clear();
    markers.add(Marker(
        markerId: const MarkerId("0"),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: detail.result.name)));
    print(lat);
    setState(() {});
    final GoogleMapController controller = await _controller.future;

      setState(() {
        isCurrentLocationRecived = true;
        controller.animateCamera(
          CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0),
        );
      });
    _getPlace(lat,lng,g: p.placeId!,type: type);

    //  _kGooglePlex.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
  }
}
