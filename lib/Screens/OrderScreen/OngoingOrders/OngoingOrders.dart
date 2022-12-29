import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swift_air_customer/Models/OngoingModel.dart';
import 'package:swift_air_customer/Screens/OrderScreen/OngoingOrders/OngoingOrderController.dart';

import '../../../AppConst/AppConst.dart';
import '../../OrderDetailScreen/OrderDetailScreen.dart';

class OngoingOrders extends StatelessWidget {
  OngoingOrderController? ongoingOrderController;

  OngoingOrders(this. ongoingOrderController);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ongoingOrderController,
        builder: (ongoingOrderController) => Scaffold(
              body: ongoingOrderController.onGoingList.isNotEmpty
                  ? ListView.builder(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 20),
                      itemCount: ongoingOrderController.onGoingList.length,
                      itemBuilder: (BuildContext context, int index) {
                        OngoingModel ongoingModel =
                            ongoingOrderController.onGoingList[index];
                        return GestureDetector(
                          onTap: ()=>Get.to(OrderDetailScreen(ongoingModel.orderId!,0)),
                          child: Container(
                            margin: EdgeInsets.only(left: 8, right: 8, top: 8),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(width: 0.5),
                                boxShadow: [
                                  BoxShadow(color: Colors.grey, blurRadius: 6)
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      ongoingModel.bookingDate!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      ongoingModel.orderId!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      ongoingModel.status == "1"
                                          ? "Assigned"
                                          : "Pending",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: Colors.amber.shade600),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
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
                                      child: Text(
                                        ongoingModel.toLocation!,
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      child: Text(
                                        ongoingModel.fromLocation!,
                                        style: TextStyle(
                                            fontSize: 16,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Center(child: Text("No Orders found.")),
            ));
  }
}
