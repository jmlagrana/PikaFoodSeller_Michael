import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pika_food/mainScreens/new_orders_screen.dart';

import '../assistantMethods/assistant_methods.dart';
import '../global/global.dart';
import '../widgets/order_card.dart';
import '../widgets/progress_bar.dart';
import '../widgets/simple_app_bar.dart';




class PendingScreen extends StatefulWidget
{
  String? purchaserId;
  String? sellerId;
  String? getOrderID;
  String? purchaserAddress;
  double? purchaserLat;
  double? purchaserLng;

  PendingScreen({
    this.purchaserId,
    this.sellerId,
    this.getOrderID,
    this.purchaserAddress,
    this.purchaserLat,
    this.purchaserLng,
  });

  @override
  _PendingScreenState createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen>
    with TickerProviderStateMixin
{
  @override
  Widget build(BuildContext context) {

    TabController _tabController = TabController(length: 2, vsync: this);

    return Scaffold(
      appBar: SimpleAppBar(title: "My Orders",),
      backgroundColor: Colors.orangeAccent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      Container(
      child: Align(
      alignment: Alignment.centerLeft,
        child: TabBar(
          controller: _tabController,
          //isScrollable: true,
          //labelPadding: EdgeInsets.only(left: 20, right: 20),
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black54,
          indicatorColor: Colors.orangeAccent,
          tabs: [
            Tab(text: "Pending",),
            Tab(text: "Done Orders",),
          ],
        ),
        ),
        ),
          Container(
            width: double.maxFinite,
            height: 625,
            child: TabBarView(
              controller: _tabController,
              children: [
                  //PENDING
                Container(
                   child: Scaffold(

                     body: StreamBuilder<QuerySnapshot>(
                       stream: FirebaseFirestore.instance
                           .collection("orders")
                           .where("status", isEqualTo: "preparing")
                           .where("sellerUID", isEqualTo: sharedPreferences!.getString("uid"))
                           .snapshots(),
                         builder: (c, snapshot)
                    {
               return snapshot.hasData
                   ? ListView.builder(
                 itemCount: snapshot.data!.docs.length,
                 itemBuilder: (c, index)
                 {
                   return FutureBuilder<QuerySnapshot>(
                     future: FirebaseFirestore.instance
                         .collection("items")
                         .where("itemID", whereIn: separateOrderItemIDs((snapshot.data!.docs[index].data()! as Map<String, dynamic>) ["productIDs"]))
                         .where("sellerUID", whereIn: (snapshot.data!.docs[index].data()! as Map<String, dynamic>)["uid"])
                         .orderBy("publishedDate", descending: true)
                         .get(),
                     builder: (c, snap)
                     {
                       return snap.hasData
                           ? OrderCard(
                         itemCount: snap.data!.docs.length,
                         data: snap.data!.docs,
                         orderID: snapshot.data!.docs[index].id,
                         seperateQuantitiesList: separateOrderItemQuantities((snapshot.data!.docs[index].data()! as Map<String, dynamic>)["productIDs"]),
                       )
                           : Center(child: circularProgress());
                     },
                   );
                 },
               )
                   : Center(child: circularProgress(),);
             },
         ),
       ),
      ),
                  //FOR PICKUP
                Container(
                  child: Scaffold(
                    body: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("orders")
                          .where("status", isEqualTo: "torate")
                          .where("sellerUID", isEqualTo: sharedPreferences!.getString("uid"))
                          .snapshots(),
                      builder: (c, snapshot)
                      {
                        return snapshot.hasData
                            ? ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (c, index)
                          {
                            return FutureBuilder<QuerySnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection("items")
                                  .where("itemID", whereIn: separateOrderItemIDs((snapshot.data!.docs[index].data()! as Map<String, dynamic>) ["productIDs"]))
                                  .where("sellerUID", whereIn: (snapshot.data!.docs[index].data()! as Map<String, dynamic>)["uid"])
                                  .orderBy("publishedDate", descending: true)
                                  .get(),
                              builder: (c, snap)
                              {

                                return snap.hasData

                                    ? OrderCard(
                                  itemCount: snap.data!.docs.length,
                                  data: snap.data!.docs,
                                  orderID: snapshot.data!.docs[index].id,
                                  seperateQuantitiesList: separateOrderItemQuantities((snapshot.data!.docs[index].data()! as Map<String, dynamic>)["productIDs"]),
                                )
                                    : Center(child: circularProgress());
                              },
                            );
                          },
                        )
                            : Center(child: circularProgress(),);
                      },
                    ),
                  ),

                ),
                        ],
                ),
              ),
        ]
      )
    );

  }
}
