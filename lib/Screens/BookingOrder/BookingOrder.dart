import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swift_air_customer/Models/BookingAddressModel.dart';
import 'package:swift_air_customer/Screens/BookingOrder/BookingOrderController.dart';

import '../../AppConst/AppConst.dart';
import '../../Models/getState.dart';
import '../../widget/AppTextFormField.dart';

class BookingOrder extends StatefulWidget {
  BookingAddressModel? bookingAddressModel;
  BookingOrder(this.bookingAddressModel);

  @override
  State<BookingOrder> createState() => _BookingOrderState();
}

class _BookingOrderState extends State<BookingOrder> {
  late BookingOrderController bookingOrderController;

  double textFormFieldSize = 55;

  double textFormFieldBorderRedius = 13;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookingOrderController =
        Get.put(BookingOrderController(widget.bookingAddressModel, context));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Get.delete<BookingOrderController>(),
      child: GetBuilder(
          init: bookingOrderController,
          builder: (bookingOrderController) => Scaffold(
              key: bookingOrderController.homeScaffoldKey,
              body: SafeArea(
                  child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 80.0),
                          child: GoogleMap(
                            polylines: bookingOrderController.polylinePoints,
                            mapType: MapType.normal,
                            // myLocationEnabled: isCurrentLocationRecived,
                            indoorViewEnabled: true,
                            //  myLocationButtonEnabled: isCurrentLocationRecived,
                            compassEnabled: false,
                            initialCameraPosition:
                                bookingOrderController.kGooglePlex!,
                            markers: Set<Marker>.from(
                                bookingOrderController.markers),

                            onMapCreated: (GoogleMapController controller) {
                              bookingOrderController.controller
                                  .complete(controller);
                            },
                          ),
                        ),
                        (bookingOrderController.isCurrentLocationRecived)
                            ? const SizedBox(
                                height: 0,
                              )
                            : Shimmer.fromColors(
                                baseColor: Colors.grey.withOpacity(0.9),
                                highlightColor: Colors.white,
                                enabled: !bookingOrderController
                                    .isCurrentLocationRecived,
                                child: Container(
                                  width: Get.width,
                                  height: Get.height,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                              )
                      ],
                    ),
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
                                color: Colors.grey,
                                blurRadius: 10,
                                spreadRadius: 1)
                          ]),
                      padding: const EdgeInsets.all(20),
                      child:true?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        const Text(
                         "Review Location",
                          style: TextStyle(
                              fontSize: 17,
                              // overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10,),
                        Row(
                         // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 6,
                            ),
                            Icon(
                              Icons.my_location,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    bookingOrderController.bookingAddressModel!.fromAdress!,
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Row(children: [
                                    Icon(Icons.person,color: AppConst.buttonColors,),
                                    Text(   bookingOrderController.bookingAddressModel!.fromName!,style: TextStyle(color:  AppConst.buttonColors,),)
                                  ],)
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.more_vert,
                              color: Colors.black87,
                              size: 35,
                            ),
                            Expanded(
                                child: Divider(
                                  thickness: 0.5,
                                  height: 0.2,
                                  color: Colors.black,
                                ))
                          ],
                        ),
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 6,
                            ),
                            Icon(
                              Icons.my_location,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    bookingOrderController.bookingAddressModel!.toAdress!,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Row(children: [
                                    Icon(Icons.person,color: AppConst.buttonColors,),
                                    Text( bookingOrderController.receiverNameEdt.text,style: TextStyle(color:  AppConst.buttonColors,),)
                                  ],)
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        SizedBox(
                          width: Get.width,
                          height: 43,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                  backgroundColor: AppConst.buttonColors),
                              onPressed: () {
                                bookingOrderController.getAddressToLatLng();
                                // if (bookingOrderController.validation()) {
                                //   bookingOrderController
                                //       .getBookOrder(context);
                                // }
                                //  print(loginScreenController.loginEdtController.text);
                              },
                              child: const Text("Choose Priority",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15))),
                        ),
                      ],):
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Driver will call this contact at delivery location",
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Please add receiver contact",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red)),
                              TextButton(
                                  onPressed: () {
                                    bookingOrderController.addDetails=bookingOrderController.addDetails?false:true;
                                    bookingOrderController.update();
                                  }, child: Text( bookingOrderController.addDetails?"Cansel":"Add"))
                            ],
                          ),

                          Visibility(
                            visible: bookingOrderController.addDetails,
                            child: Column(children: [
                              SizedBox(
                                height: 45,
                                child: TextFormField(
                                  controller:
                                  bookingOrderController.receiverNameEdt,
                                  textInputAction: TextInputAction.next,
                                  focusNode: bookingOrderController.focusReceiverNameEdt,

                                  onChanged: (v) {
                                    if (v.toString().isNotEmpty) {
                                      bookingOrderController.errorReceiverNameEdt = "";
                                      bookingOrderController.update();
                                    }
                                  },



                                  //contentPadding: EdgeInsets.symmetric(horizontal: 4),

                                  decoration: InputDecoration(
                                    label:
                                    bookingOrderController.errorReceiverNameEdt.isEmpty?
                                    Row(
                                      children: [
                                        Text("Name"),
                                        Text(" *",
                                          style: TextStyle(color: Colors.red),
                                        )
                                      ],
                                    ):
                                    Text(bookingOrderController.errorReceiverNameEdt),
                                    labelStyle:  TextStyle(fontSize: 16, color: bookingOrderController.errorReceiverNameEdt.isEmpty?  Color(0xfff6d7ab5):Colors.red),

                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:bookingOrderController.errorReceiverNameEdt.isEmpty? Color(0xfff6d7ab5):Colors.red,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color:bookingOrderController.errorReceiverNameEdt.isEmpty?  Color(0xfff6d7ab5):Colors.red,
                                            width: 1
                                        )
                                    ),
                                    contentPadding: EdgeInsets.all(4),
                                    fillColor: Colors.grey.shade200,
                                    filled: true,
                                    prefixIcon: Icon(Icons.person),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 45,
                                child: TextFormField(
                                  controller:
                                  bookingOrderController.receiverMobileNoEdt,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  focusNode: bookingOrderController.focusReceiverMobileNoEdt,

                                  onChanged: (v) {
                                    if (v.toString().isNotEmpty) {
                                      bookingOrderController.errorReceiverMobileNoEdt = "";
                                      bookingOrderController.update();
                                    }
                                  },
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(10),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    label:
                                    bookingOrderController.errorReceiverMobileNoEdt.isEmpty?
                                    Row(
                                      children: [
                                        Text("Mobile Number"),
                                        Text(" *",
                                          style: TextStyle(color: Colors.red),
                                        )
                                      ],
                                    ):
                                    Text(bookingOrderController.errorReceiverMobileNoEdt),
                                    labelStyle:  TextStyle(fontSize: 16, color: bookingOrderController.errorReceiverMobileNoEdt.isEmpty?  Color(0xfff6d7ab5):Colors.red),

                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:bookingOrderController.errorReceiverMobileNoEdt.isEmpty? Color(0xfff6d7ab5):Colors.red,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color:bookingOrderController.errorReceiverMobileNoEdt.isEmpty?  Color(0xfff6d7ab5):Colors.red,
                                            width: 1
                                        )
                                    ),
                                    contentPadding: EdgeInsets.all(4),
                                    fillColor: Colors.grey.shade200,
                                    filled: true,
                                    prefixIcon: Icon(Icons.call),),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 45,
                                child: TextFormField(
                                  controller:
                                  bookingOrderController.specialInstructions,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(10),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                      label: Text("Instructions"),
                                      contentPadding: EdgeInsets.all(4),
                                      fillColor: Colors.grey.shade200,
                                      filled: true,
                                      prefixIcon: Icon(Icons.note_add_rounded),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15))),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: Get.width,
                                height: 43,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                        backgroundColor: AppConst.buttonColors),
                                    onPressed: () {
                                      bookingOrderController.getAddressToLatLng();
                                      // if (bookingOrderController.validation()) {
                                      //   bookingOrderController
                                      //       .getBookOrder(context);
                                      // }
                                      //  print(loginScreenController.loginEdtController.text);
                                    },
                                    child: const Text("Next",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15))),
                              ),
                            ],),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )))),
    );
  }
}

// Padding(
// padding: const EdgeInsets.symmetric(
// horizontal: 8.0, vertical: 15),
// child: ListView(
// shrinkWrap: true,
// children: [
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Row(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// GestureDetector(
// onTap: () {
// Get.back();
// Get.delete<BookingOrderController>();
// },child: const Icon(Icons.arrow_back_sharp)),
// Text(
// "      Order Booking",
// style: TextStyle(
// fontSize: 19,
// fontWeight: FontWeight.w700),
// ),
// ],
// ),
// ),
// Divider(
// thickness: 1,
// height: 0.5,
// color: Colors.black,
// ),
// Align(
// alignment: Alignment.centerLeft,
// child: Container(
// margin: EdgeInsets.only(top: 10),
// padding: EdgeInsets.symmetric(
// vertical: 8, horizontal: 10),
// decoration: BoxDecoration(
// color: Color(0xfff7ec8eb),
// borderRadius: BorderRadius.circular(8)),
// child: const Text(
// "---Sender Detail---",
// style: TextStyle(
// fontSize: 16, fontWeight: FontWeight.w600),
// ),
// ),
// ),
// Padding(
// padding: const EdgeInsets.only(top: 8.0),
// child: Row(
// children: [
// Expanded(
// child: TextBoxs.AppTextFormField(
// bookingOrderController.senderNameEdt,
// borderWidth: 1.5,
// borderRadius: textFormFieldBorderRedius,
// label: "Sender Name*",
// size: textFormFieldSize,
// focusNode: bookingOrderController
//     .focusSenderNameEdt,
// errorMsg: bookingOrderController
//     .errorSenderNameEdt, onChange: (v) {
// if (v.toString().isNotEmpty) {
// bookingOrderController.errorSenderNameEdt =
// "";
// bookingOrderController.update();
// }
// })),
// const SizedBox(
// width: 10,
// ),
// Expanded(
// child: TextBoxs.AppTextFormField(
// bookingOrderController
//     .senderMobileNumberEdt,
// borderWidth: 1.5,
// borderRadius: textFormFieldBorderRedius,
// label: "Sender Mobile No.*",
// size: textFormFieldSize,
// keyboardType: TextInputType.number,
// inputFormatters: [
// LengthLimitingTextInputFormatter(10),
// FilteringTextInputFormatter.digitsOnly
// ],
// focusNode: bookingOrderController
//     .focusSenderMobileNumberEdt,
// errorMsg: bookingOrderController
//     .errorSenderMobileNumberEdt,
// onChange: (v) {
// if (v.toString().length == 10) {
// bookingOrderController
//     .errorSenderMobileNumberEdt = "";
// bookingOrderController.update();
// }
// })),
// ],
// ),
// ),
// Padding(
// padding: const EdgeInsets.only(top: 8.0),
// child: Row(
// children: [
// Expanded(
// child: Container(
// padding: EdgeInsets.symmetric(horizontal: 6),
// height: textFormFieldSize,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(
// textFormFieldBorderRedius),
// border: Border.all(
// color: Color(0xfff6d7ab5),
// width: 1.8,
// )),
// child:  Align(
// alignment: Alignment.centerLeft,
// child: Text(DateFormat('dd-MMM-yyyy').format(DateTime.now()),
// textAlign: TextAlign.left,
// style: TextStyle(
// color: Colors.black,
// fontSize: 16,
// fontWeight: FontWeight.w400))),
// )),
// const SizedBox(
// width: 10,
// ),
// Expanded(
// child: Stack(
// clipBehavior: Clip.none,
// children: [
// Container(
// padding:
// EdgeInsets.symmetric(horizontal: 6),
// height: textFormFieldSize,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(
// textFormFieldBorderRedius),
// border: Border.all(
// color: Color(0xfff6d7ab5),
// width: 1.8,
// )),
// child: Center(
// child: DropdownButton<String>(
// value:
// bookingOrderController.docTypeValue,
// //icon: const Icon(Icons.arrow_downward),
// elevation: 16,
// underline: Container(
// height: 0,
// color: Colors.white,
// ),
// style: const TextStyle(
// color: Colors.black, fontSize: 16),
// dropdownColor: Colors.grey.shade100,
// isExpanded: true,
// onChanged: (String? value) {
// // This is called when the user selects an item.
// bookingOrderController.docTypeValue =
// value!;
// bookingOrderController.update();
// },
// items: bookingOrderController
//     .docTypeList
//     .map<DropdownMenuItem<String>>(
// (String? value) {
// return DropdownMenuItem<String>(
// value: value,
// child: Text(value!),
// );
// }).toList(),
// ),
// ),
// ),
// Positioned(
// top: -6,
// left: 13,
// child: Container(
// padding: EdgeInsets.symmetric(
// horizontal: 2),
// decoration: const BoxDecoration(
// color: Colors.white),
// child: Text(
// "Doc Type*",
// style: TextStyle(
// color: Color(0xfff6d7ab5),
// fontSize: 12),
// )))
// ],
// )),
// ],
// ),
// ),
// Padding(
// padding: const EdgeInsets.only(top: 8.0),
// child: Row(
// children: [
// Expanded(
// child: Stack(
// clipBehavior: Clip.none,
// children: [
// Container(
// padding:
// EdgeInsets.symmetric(horizontal: 6),
// height: textFormFieldSize,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(
// textFormFieldBorderRedius),
// border: Border.all(
// color: Color(0xfff6d7ab5),
// width: 1.8,
// )),
// child: Center(
// child: DropdownButton<String>(
// value: bookingOrderController
//     .packetTypeValue,
// //icon: const Icon(Icons.arrow_downward),
// elevation: 16,
// underline: Container(
// height: 0,
// color: Colors.white,
// ),
// style: const TextStyle(
// color: Colors.black, fontSize: 16),
// dropdownColor: Colors.grey.shade100,
// isExpanded: true,
// onChanged: (String? value) {
// // This is called when the user selects an item.
// bookingOrderController
//     .packetTypeValue = value!;
// bookingOrderController.update();
// },
// items: bookingOrderController
//     .packetTypeList
//     .map<DropdownMenuItem<String>>(
// (String? value) {
// return DropdownMenuItem<String>(
// value: value,
// child: Text(value!),
// );
// }).toList(),
// ),
// ),
// ),
// Positioned(
// top: -6,
// left: 13,
// child: Container(
// padding: EdgeInsets.symmetric(
// horizontal: 2),
// decoration: BoxDecoration(
// color: Colors.white),
// child: Text(
// "Packet Type*",
// style: TextStyle(
// color: Color(0xfff6d7ab5),
// fontSize: 12),
// )))
// ],
// )),
// const SizedBox(
// width: 10,
// ),
// Expanded(
// child: Stack(
// clipBehavior: Clip.none,
// children: [
// Container(
// padding:
// EdgeInsets.symmetric(horizontal: 6),
// height: textFormFieldSize,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(
// textFormFieldBorderRedius),
// border: Border.all(
// color: Color(0xfff6d7ab5),
// width: 1.8,
// )),
// child: Center(
// child: DropdownButton<String>(
// value: bookingOrderController
//     .packetClassifyValue,
// //icon: const Icon(Icons.arrow_downward),
// elevation: 16,
// underline: Container(
// height: 0,
// color: Colors.white,
// ),
// style: const TextStyle(
// color: Colors.black, fontSize: 16),
// dropdownColor: Colors.grey.shade100,
// isExpanded: true,
// onChanged: (String? value) {
// // This is called when the user selects an item.
// bookingOrderController
//     .packetClassifyValue = value!;
// bookingOrderController.update();
// },
// items: bookingOrderController
//     .packetClassifyList
//     .map<DropdownMenuItem<String>>(
// (String? value) {
// return DropdownMenuItem<String>(
// value: value,
// child: Text(value!),
// );
// }).toList(),
// ),
// ),
// ),
// Positioned(
// top: -6,
// left: 13,
// child: Container(
// padding: EdgeInsets.symmetric(
// horizontal: 2),
// decoration: BoxDecoration(
// color: Colors.white),
// child: Text(
// "Packet Classify*",
// style: TextStyle(
// color: Color(0xfff6d7ab5),
// fontSize: 12),
// )))
// ],
// )),
// ],
// ),
// ),
// Padding(
// padding: const EdgeInsets.only(top: 8.0),
// child: Row(
// children: [
// Expanded(
// child: TextBoxs.AppTextFormField(
// bookingOrderController.quantityEdt,
// borderWidth: 1.5,
// borderRadius: textFormFieldBorderRedius,
// label: "Quantity*",
// size: textFormFieldSize,
// keyboardType: TextInputType.number,
// inputFormatters: [
// LengthLimitingTextInputFormatter(10),
// FilteringTextInputFormatter.digitsOnly
// ],
// focusNode: bookingOrderController
//     .focusQuantityrEdt,
// errorMsg: bookingOrderController
//     .errorQuantityEdt, onChange: (v) {
// if (v.toString().isNotEmpty) {
// bookingOrderController.errorQuantityEdt = "";
// bookingOrderController.update();
// }
// })),
// const SizedBox(
// width: 10,
// ),
// Expanded(
// child: TextBoxs.AppTextFormField(
// bookingOrderController.valueEdt,
// borderWidth: 1.5,
// borderRadius: textFormFieldBorderRedius,
// label: "Value*",
// size: textFormFieldSize,
// keyboardType: TextInputType.number,
// inputFormatters: [
// LengthLimitingTextInputFormatter(10),
// FilteringTextInputFormatter.digitsOnly
// ],
// focusNode:
// bookingOrderController.focusValuerEdt,
// errorMsg: bookingOrderController
//     .errorValueEdt, onChange: (v) {
// if (v.toString().isNotEmpty) {
// bookingOrderController.errorValueEdt = "";
// bookingOrderController.update();
// }
// })),
// ],
// ),
// ),
// Padding(
// padding: const EdgeInsets.only(top: 8.0),
// child: Row(
// children: [
// Expanded(
// child: TextBoxs.AppTextFormField(
// bookingOrderController.heightEdt,
// borderWidth: 1.5,
// borderRadius: textFormFieldBorderRedius,
// label: "Height*",
// size: textFormFieldSize,
// keyboardType: TextInputType.number,
// inputFormatters: [
// LengthLimitingTextInputFormatter(10),
// FilteringTextInputFormatter.digitsOnly
// ],
// focusNode: bookingOrderController
//     .focusHeightrEdt,
// errorMsg: bookingOrderController
//     .errorHeighteEdt, onChange: (v) {
// if (v.toString().isNotEmpty) {
// bookingOrderController.errorHeighteEdt = "";
// bookingOrderController.update();
// }
// })),
// const SizedBox(
// width: 10,
// ),
// Expanded(
// child: TextBoxs.AppTextFormField(
// bookingOrderController.widthEdt,
// borderWidth: 1.5,
// borderRadius: textFormFieldBorderRedius,
// label: "Width*",
// size: textFormFieldSize,
// keyboardType: TextInputType.number,
// inputFormatters: [
// LengthLimitingTextInputFormatter(10),
// FilteringTextInputFormatter.digitsOnly
// ],
// focusNode:
// bookingOrderController.focusWidthEdt,
// errorMsg: bookingOrderController
//     .errorWidthEdt, onChange: (v) {
// if (v.toString().isNotEmpty) {
// bookingOrderController.errorWidthEdt = "";
// bookingOrderController.update();
// }
// })),
// ],
// ),
// ),
// Padding(
// padding: const EdgeInsets.only(top: 8.0),
// child: Row(
// children: [
// Expanded(
// child: TextBoxs.AppTextFormField(
// bookingOrderController.lengthEdt,
// borderWidth: 1.5,
// borderRadius: textFormFieldBorderRedius,
// label: "Length*",
// size: textFormFieldSize,
// keyboardType: TextInputType.number,
// inputFormatters: [
// LengthLimitingTextInputFormatter(10),
// FilteringTextInputFormatter.digitsOnly
// ],
// focusNode:
// bookingOrderController.focusLengthEdt,
// errorMsg: bookingOrderController
//     .errorLengthEdt, onChange: (v) {
// if (v.toString().isNotEmpty) {
// bookingOrderController.errorLengthEdt = "";
// bookingOrderController.update();
// }
// })),
// const SizedBox(
// width: 10,
// ),
// Expanded(
// child: TextBoxs.AppTextFormField(
// bookingOrderController.weightEdt,
// borderWidth: 1.5,
// borderRadius: textFormFieldBorderRedius,
// label: "Weight*",
// size: textFormFieldSize,
// keyboardType: TextInputType.number,
// inputFormatters: [
// LengthLimitingTextInputFormatter(10),
// FilteringTextInputFormatter.digitsOnly
// ],
// focusNode:
// bookingOrderController.focusWeightEdt,
// errorMsg: bookingOrderController
//     .errorWeightEdt, onChange: (v) {
// if (v.toString().isNotEmpty) {
// bookingOrderController.errorWeightEdt = "";
// bookingOrderController.update();
// }
// })),
// ],
// ),
// ),
// Padding(
// padding: const EdgeInsets.only(top: 10.0),
// child: TextBoxs.AppTextFormField(
// bookingOrderController.pickUpAddressEdt,
// borderWidth: 1.5,
// borderRadius: textFormFieldBorderRedius,
// label: "PickUp Address*",
// size: textFormFieldSize,
// focusNode:
// bookingOrderController.focusPickUpAddressEdt,
// errorMsg: bookingOrderController
//     .errorPickUpAddressEdt, onChange: (v) {
// if (v.toString().isNotEmpty) {
// bookingOrderController.errorPickUpAddressEdt = "";
// bookingOrderController.update();
// }
// }),
// ),
// Align(
// alignment: Alignment.centerLeft,
// child: Container(
// margin: EdgeInsets.only(top: 30),
// padding: EdgeInsets.symmetric(
// vertical: 8, horizontal: 10),
// decoration: BoxDecoration(
// color: Color(0xfff7ec8eb),
// borderRadius: BorderRadius.circular(8)),
// child: const Text(
// "---Receiver Detail---",
// style: TextStyle(
// fontSize: 16, fontWeight: FontWeight.w600),
// ),
// ),
// ),
// Padding(
// padding: const EdgeInsets.only(top: 8.0),
// child: Row(
// children: [
// Expanded(
// child: TextBoxs.AppTextFormField(
// bookingOrderController.receiverNameEdt,
// borderWidth: 1.5,
// borderRadius: textFormFieldBorderRedius,
// label: "Receiver Name*",
// size: textFormFieldSize,
// focusNode: bookingOrderController
//     .focusReceiverNameEdt,
// errorMsg: bookingOrderController
//     .errorReceiverNameEdt, onChange: (v) {
// if (v.toString().isNotEmpty) {
// bookingOrderController.errorReceiverNameEdt =
// "";
// bookingOrderController.update();
// }
// })),
// const SizedBox(
// width: 10,
// ),
// Expanded(
// child: TextBoxs.AppTextFormField(
// bookingOrderController
//     .receiverMobileNoEdt,
// borderWidth: 1.5,
// borderRadius: textFormFieldBorderRedius,
// label: "Receiver Mobile No.*",
// size: textFormFieldSize,
// keyboardType: TextInputType.number,
// inputFormatters: [
// LengthLimitingTextInputFormatter(10),
// FilteringTextInputFormatter.digitsOnly
// ],
// focusNode: bookingOrderController
//     .focusReceiverMobileNoEdt,
// errorMsg: bookingOrderController
//     .errorReceiverMobileNoEdt,
// onChange: (v) {
// if (v.toString().length == 10) {
// bookingOrderController
//     .errorReceiverMobileNoEdt = "";
// bookingOrderController.update();
// }
// })),
// ],
// ),
// ),
// Padding(
// padding: const EdgeInsets.only(top: 10.0),
// child: TextBoxs.AppTextFormField(
// bookingOrderController.receiverAddressEdt,
// borderWidth: 1.5,
// borderRadius: textFormFieldBorderRedius,
// label: "Receiver Address*",
// size: textFormFieldSize,
// focusNode: bookingOrderController
//     .focusReceiverAddressEdt,
// errorMsg: bookingOrderController
//     .errorReceiverAddressEdt, onChange: (v) {
// if (v.toString().isNotEmpty) {
// bookingOrderController.errorReceiverAddressEdt =
// "";
// bookingOrderController.update();
// }
// }),
// ),
// const SizedBox(
// height: 20,
// ),
// SizedBox(
// width: Get.width * 0.7,
// height: 43,
// child: ElevatedButton(
// style: ElevatedButton.styleFrom(
// backgroundColor: AppConst.buttonColors),
// onPressed: () {
// if (bookingOrderController.validation()) {
// bookingOrderController.getBookOrder(context);
// }
// //  print(loginScreenController.loginEdtController.text);
// },
// child: const Text("Book",
// style: TextStyle(
// fontWeight: FontWeight.w500,
// fontSize: 15))),
// ),
// ],
// )),
