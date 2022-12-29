
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../AppConst/AppConst.dart';
import 'CompletedOrders/CompletedOrders.dart';
import 'CompletedOrdersCcontrroller.dart';
import 'OngoingOrders/OngoingOrderController.dart';
import 'OngoingOrders/OngoingOrders.dart';

class OrderScreenTab extends StatefulWidget  {
  @override
  State<OrderScreenTab> createState() => _OrderScreenTabState();
}

class _OrderScreenTabState extends State<OrderScreenTab> with SingleTickerProviderStateMixin {
  OngoingOrderController ongoingOrderController =
  Get.put(OngoingOrderController());
  CompletedOrdersContrroller completedOrdersContrroller =
  Get.put(CompletedOrdersContrroller());

  late TabController _tabController;


Function()? onTap;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppConst.buttonColors,
          tabs: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Tab(icon: Icon(Icons.cached,color: AppConst.buttonColors,size: 33,)),
                 Text("  ONGOING",style: TextStyle(color: AppConst.buttonColors,
                   fontWeight: FontWeight.w500,
                   fontSize: 16,

                 ),)
              ],
            ), Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Tab(icon: Icon(Icons.task_alt,color: AppConst.buttonColors,size: 30,)),
                 Text("  COMPLETED",style: TextStyle(
                     fontWeight: FontWeight.w500,
                     fontSize: 16,
                     color: AppConst.buttonColors),)
              ],
            ),


          ],
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('My Orders' ,style: TextStyle(color: AppConst.buttonColorsDark,fontWeight: FontWeight.w700),),
                SizedBox(height: 5,),
                SizedBox(
                  width: Get.width*0.26,
                    child: Divider(thickness: 1 ,height: 0.5,color: AppConst.buttonColors,))
              ],
            ),
            GestureDetector(onTap :(){

              if(_tabController.index==0){
                ongoingOrderController.getOngoingOrders(ongoingOrderController.loginModel!.customerId, ongoingOrderController.loginModel!.accessToken!);

              }else{
                completedOrdersContrroller.getOngoingOrders(ongoingOrderController.loginModel!.customerId, ongoingOrderController.loginModel!.accessToken!);

              }
              print(_tabController.index);
            },child: Icon(Icons.refresh_outlined,color: AppConst.buttonColors,size: 30,))
          ],
        ),
      ),
      body: TabBarView(
controller: _tabController,
        children: [
           Tab(child:  OngoingOrders(ongoingOrderController),),

           Tab(child: CompletedOrders(completedOrdersContrroller),),
        ],
      ),
    );
  }
}
