import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swift_air_customer/AppConst/AppConst.dart';
import 'package:swift_air_customer/Screens/OrderDetailScreen/OrderDetailScreenController.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../support/AlertDialogManager.dartAlertDialogManager.dart';

class OrderDetailScreen extends StatefulWidget {
  String orderId;
  int type;

  OrderDetailScreen(this.orderId,this.type, {Key? key}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  late OrderDetailScreenController orderDetailScreenController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orderDetailScreenController =
        Get.put(OrderDetailScreenController(widget.orderId));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: orderDetailScreenController,
        builder: (orderDetailScreenController) =>
            WillPopScope(
                onWillPop: () => Get.delete<OrderDetailScreenController>(),
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    titleSpacing: 0,
                    title: const Text(
                      "Order Details",
                      style: TextStyle(color: Colors.black),
                    ),
                    leading: GestureDetector(
                        onTap: () => Get.back(),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        )),
                  ),
                  body: orderDetailScreenController.orderDetailsModel != null
                      ? Container(

                    width: Get.width,

                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.all(10),
                    // decoration: const BoxDecoration(
                    //   color: Colors.white,
                    //   boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3)],
                    // ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "AWB # ",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                orderDetailScreenController
                                    .orderDetailsModel!.orderId!,
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            Container(

                              margin: EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 2),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),

                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5,
                                      spreadRadius: 2.1,
                                      offset: Offset(1, 4))
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "PICKUP INFO",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  /* const SizedBox(
                              width: 130,
                              child: Divider(
                                height: 0.5,
                                thickness: 0.5,
                                color: Colors.black54,
                              )),*/
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(
                                          child: Text("Name",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight
                                                      .w500))),
                                      Expanded(
                                          child: Text(
                                              orderDetailScreenController
                                                  .orderDetailsModel!
                                                  .senderName!,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500)))
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: const Divider(
                                      height: 0.5,
                                      thickness: 0.5,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(
                                          child: Text("Contact",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight
                                                      .w500))),
                                      Expanded(
                                          child: Text(
                                              orderDetailScreenController
                                                  .orderDetailsModel!
                                                  .senderPhone!,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500)))
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: const Divider(
                                      height: 0.5,
                                      thickness: 0.5,
                                      color: Colors.black,
                                    ),
                                  ),

                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Expanded(
                                          child: Text("Pickup Address",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight
                                                      .w500))),
                                      Expanded(
                                          child: Text(
                                              orderDetailScreenController
                                                  .orderDetailsModel!
                                                  .fromLocation!,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500)))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 8),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),

                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5,
                                      spreadRadius: 2.1,
                                      offset: Offset(1, 4))
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "DROP OFF INFO",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  /* const SizedBox(
                              width: 130,
                              child: Divider(
                                height: 0.5,
                                thickness: 0.5,
                                color: Colors.black54,
                              )),*/
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(
                                          child: Text("Name",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight
                                                      .w500))),
                                      Expanded(
                                          child: Text(
                                              orderDetailScreenController
                                                  .orderDetailsModel!
                                                  .dropoffName!,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500)))
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: const Divider(
                                      height: 0.5,
                                      thickness: 0.5,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(
                                          child: Text("Contact",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight
                                                      .w500))),
                                      Expanded(
                                          child: Text(
                                              orderDetailScreenController
                                                  .orderDetailsModel!
                                                  .dropoffPhone!,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500)))
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: const Divider(
                                      height: 0.5,
                                      thickness: 0.5,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Expanded(
                                          child: Text("Drop off Address",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight
                                                      .w500))),
                                      Expanded(
                                          child: Text(
                                              orderDetailScreenController
                                                  .orderDetailsModel!
                                                  .toLocation!,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500)))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 2),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5,
                                      spreadRadius: 2.1,
                                      offset: Offset(1, 4))
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "EXTRA INFO",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  /* const SizedBox(
                              width: 130,
                              child: Divider(
                                height: 0.5,
                                thickness: 0.5,
                                color: Colors.black54,
                              )),*/
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(
                                          child: Text("Booking Date",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight
                                                      .w500))),
                                      Expanded(
                                          child: Text(
                                              orderDetailScreenController
                                                  .orderDetailsModel!
                                                  .bookingDate!,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500)))
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Divider(
                                      height: 0.5,
                                      thickness: 0.5,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(
                                          child: Text("Priority",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight
                                                      .w500))),
                                      Expanded(
                                          child: Text(
                                              orderDetailScreenController
                                                  .orderDetailsModel!.priority!,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500)))
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Divider(
                                      height: 0.5,
                                      thickness: 0.5,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(
                                          child: Text("Quantity",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight
                                                      .w500))),
                                      Expanded(
                                          child: Text(
                                              orderDetailScreenController
                                                  .orderDetailsModel!.qty!,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500)))
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Divider(
                                      height: 0.5,
                                      thickness: 0.5,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(
                                          child: Text("Doc Type",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight
                                                      .w500))),
                                      Expanded(
                                          child: Text(
                                              orderDetailScreenController
                                                  .orderDetailsModel!.docType!,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500)))
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Divider(
                                      height: 0.5,
                                      thickness: 0.5,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(
                                          child: Text("Packet Type",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight
                                                      .w500))),
                                      Expanded(
                                          child: Text(
                                              orderDetailScreenController
                                                  .orderDetailsModel!
                                                  .packetType!,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500)))
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Divider(
                                      height: 0.5,
                                      thickness: 0.5,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(
                                          child: Text("Packet Classify",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight
                                                      .w500))),
                                      Expanded(
                                          child: Text(
                                              orderDetailScreenController
                                                  .orderDetailsModel!
                                                  .packetClassify!,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500)))
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Divider(
                                      height: 0.5,
                                      thickness: 0.5,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(
                                          child: Text("Status",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight
                                                      .w500))),
                                      Expanded(
                                          child: Text(
                                              orderDetailScreenController
                                                  .orderDetailsModel!.status!,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500)))
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Divider(
                                      height: 0.5,
                                      thickness: 0.5,
                                      color: Colors.black,
                                    ),
                                  ),
                                  if(orderDetailScreenController
                                      .orderDetailsModel!.specialInstructions!
                                      .isNotEmpty)
                                    Row(
                                      children: [
                                        const Expanded(
                                            child: Text("Instruction",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight
                                                        .w500))),
                                        Expanded(
                                            child: Text(
                                                orderDetailScreenController
                                                    .orderDetailsModel!
                                                    .specialInstructions!,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight
                                                        .w500)))
                                      ],
                                    ),

                                  if(orderDetailScreenController
                                      .orderDetailsModel!.driverName!
                                      .isNotEmpty)
                                    if(orderDetailScreenController
                                        .orderDetailsModel!.specialInstructions!
                                        .isNotEmpty)
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Divider(
                                          height: 0.5,
                                          thickness: 0.5,
                                          color: Colors.black,
                                        ),
                                      ),

                                  if(orderDetailScreenController
                                      .orderDetailsModel!.driverName!
                                      .isNotEmpty)
                                    Row(
                                      children: [
                                        const Expanded(
                                            child: Text("Driver Name",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight
                                                        .w500))),
                                        Expanded(
                                            child: Text(
                                                orderDetailScreenController
                                                    .orderDetailsModel!
                                                    .driverName!,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight
                                                        .w500)))
                                      ],
                                    ),

                                  if(orderDetailScreenController
                                      .orderDetailsModel!.driverPhone!
                                      .isNotEmpty)
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Divider(
                                        height: 0.5,
                                        thickness: 0.5,
                                        color: Colors.black,
                                      ),
                                    ),

                                  if(orderDetailScreenController
                                      .orderDetailsModel!.driverPhone!
                                      .isNotEmpty)
                                    Row(
                                      children: [
                                        const Expanded(
                                            child: Text("Driver Phone",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight
                                                        .w500))),
                                        Expanded(
                                            child: Text(
                                                orderDetailScreenController
                                                    .orderDetailsModel!
                                                    .driverPhone!,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight
                                                        .w500)))
                                      ],
                                    ),

                                ],
                              ),
                            ),

                            widget.type == 0 ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(

                                    child: ElevatedButton(

                                        onPressed: () =>
                                        orderDetailScreenController.
                                        orderDetailsModel!.status!
                                            .toLowerCase() == "pending"
                                            ?
                                        AlertDialogManager()
                                            .IsAlertLogoutDialogMessage(context,
                                            "Order Id - ${orderDetailScreenController
                                                .orderDetailsModel!.orderId}",
                                            "Do you really cancel this order?", () => null)
                                            : null,
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: orderDetailScreenController
                                                .
                                            orderDetailsModel!.status!
                                                .toLowerCase() == "pending"
                                                ? AppConst.buttonColors
                                                : Colors.grey,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .circular(10)
                                            )
                                        ),

                                        child: const Text("Cancel")),
                                  ),
                                  const SizedBox(width: 15,),
                                  Expanded(
                                    child: ElevatedButton(onPressed: () => orderDetailScreenController.orderDetailsModel!.driverPhone!
                                        .isNotEmpty ?
                                      orderDetailScreenController.getContactDriver(context, "Contact to Driver", "", () => null):null
                                    ,
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: orderDetailScreenController
                                                .
                                            orderDetailsModel!.driverPhone!
                                                .isNotEmpty ? AppConst
                                                .buttonColors : Colors.grey,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .circular(10)
                                            )
                                        ),

                                        child: const Text("Contact Driver")),
                                  )
                                ],
                              ),
                            ) :
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(

                                    child: ElevatedButton(

                                        onPressed: () =>
                                            podBottomSheet(context),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: AppConst
                                                .buttonColors,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .circular(10)
                                            )
                                        ),

                                        child: const Text("POD")),
                                  ),
                                  const SizedBox(width: 15,),
                                  Expanded(
                                    child: ElevatedButton(onPressed: () => orderDetailScreenController
                                        .details.isNotEmpty? podBottomSheet(context) : null,
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:orderDetailScreenController
                                                .details.isNotEmpty? AppConst
                                                .buttonColors : Colors.grey,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .circular(10)
                                            )
                                        ),

                                        child: const Text("Problem")),
                                  )
                                ],
                              ),
                            ),
                          ],))
                      ],
                    ),
                  )
                      : Container(),
                )));
  }

  podBottomSheet(BuildContext buildContext) async {
    orderDetailScreenController.getPODDetails();
    return showModalBottomSheet(
      //   isScrollControlled: true,
      context: buildContext,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      builder: (context) {
        return GetBuilder(
            init: orderDetailScreenController,
            builder: (orderDetailScreenController) =>
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  height: Get.height / 1.2,
                  child: Column(
                    children: [
                      Container(
                        height: 5,
                        width: 150,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey),

                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("POD", style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 2, vertical: 2),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5,
                                    spreadRadius: 2.1,
                                    offset: Offset(1, 4))
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "RECEIVER INFO",
                                  style: TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.w500),
                                ),
                                /* const SizedBox(
                    width: 130,
                    child: Divider(
                          height: 0.5,
                          thickness: 0.5,
                          color: Colors.black54,
                    )),*/
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    const Expanded(
                                        child: Text("Name",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500))),
                                    Expanded(
                                        child: Text(
                                            orderDetailScreenController
                                                .deliveredTo,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500)))
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Divider(
                                    height: 0.5,
                                    thickness: 0.5,
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Expanded(
                                        child: Text("Contact No.",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500))),
                                    Expanded(
                                        child: Text(
                                            orderDetailScreenController
                                                .altNo,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500)))
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Divider(
                                    height: 0.5,
                                    thickness: 0.5,
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(bottom: 5),
                                              width: Get.width,
                                              decoration: BoxDecoration(
                                                  color: AppConst.buttonColors,
                                                  borderRadius: BorderRadius
                                                      .circular(3),
                                                  border: Border.all(
                                                      color: Colors.white)
                                              ),
                                              padding: EdgeInsets.all(5),
                                              child: const Center(
                                                child: Text("Signature",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight
                                                            .w500)),
                                              ),
                                            ),
                                            Container(
                                              width: Get.width,
                                                height: 170,
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .circular(8),
                                                    border: Border.all()
                                                ),
                                                child: Center(
                                                  child: Image.network(orderDetailScreenController
                                                      .deliverySignature,errorBuilder:
                                                      (BuildContext context,
                                                      Object exception, StackTrace? stackTrace) {
                                                    // Appropriate logging or analytics, e.g.
                                                    // myAnalytics.recordError(
                                                    //   'An error occurred loading "https://example.does.not.exist/image.jpg"',
                                                    //   exception,
                                                    //   stackTrace,
                                                    // );
                                                    return Text("Signature is not uploaded.!",textAlign: TextAlign.center,);
                                                  },),
                                                ),)
                                          ],
                                        )),
                                    SizedBox(width: 8,),
                                    Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(bottom: 5),
                                              width: Get.width,
                                              decoration: BoxDecoration(
                                                  color: AppConst.buttonColors,
                                                  borderRadius: BorderRadius
                                                      .circular(3),
                                                  border: Border.all(
                                                      color: Colors.white)
                                              ),
                                              padding: EdgeInsets.all(5),
                                              child: const Center(
                                                child: Text("Image",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight
                                                            .w500)),
                                              ),
                                            ),
                                            Container(
                                              width: Get.width,
                                              height: 170,
                                              padding: EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(8),
                                                  border: Border.all()
                                              ),
                                              child: Center(
                                                child: Image.network(orderDetailScreenController
                                                    .deliveryProof1,errorBuilder:
                                                    (BuildContext context,
                                                    Object exception, StackTrace? stackTrace) {
                                                  // Appropriate logging or analytics, e.g.
                                                  // myAnalytics.recordError(
                                                  //   'An error occurred loading "https://example.does.not.exist/image.jpg"',
                                                  //   exception,
                                                  //   stackTrace,
                                                  // );
                                                  return const Text("POD is not uploaded.!",textAlign: TextAlign.center,);
                                                },),
                                              ),)
                                          ],
                                        ))
                                  ],
                                ),
                                Center(
                                  child: ElevatedButton(onPressed: () => Get.back(),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: AppConst.buttonColors,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  10)
                                          )
                                      ),

                                      child: const Text("OK")),
                                )
                              ],
                            ),
                          ),
                        ),
                      )


                    ],
                  ),
                ));
      },
    );
  }
}
