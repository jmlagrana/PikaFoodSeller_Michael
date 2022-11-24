
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/address.dart';
import '../splashScreen/splash_screen.dart';


class ShipmentAddressDesign extends StatelessWidget
{
  final Address? model;
  final String? orderStatus;
  final String? orderId;
  final String? sellerId;
  final String? orderByUser;
  final String? orderID;
  final String? totalPurchase;

  ShipmentAddressDesign({this.model, this.orderStatus, this.orderId, this.sellerId, this.orderByUser, this.orderID, this.totalPurchase });

  String previousEarnings = "";
  String totalAmount = "";

  confirmedParcelShipment(BuildContext context, String getOrderID, String sellerId, String purchaserId) {

    FirebaseFirestore.instance
        .collection("users")
        .doc(purchaserId)
        .collection("orders")
        .doc(getOrderID)
        .update({
      "status": "pickup",
    });
    Navigator.pop(context);
  }

  updateOrder(BuildContext context, String getOrderID, String sellerUID, String purchaserId) {

    FirebaseFirestore.instance
        .collection("orders")
        .doc(getOrderID)
        .update({
      "status": "pickup",
    });
  }

  confirmedParcelShipmentEnd(BuildContext context, String getOrderID, String sellerId, String purchaserId) {

    FirebaseFirestore.instance
        .collection("users")
        .doc(purchaserId)
        .collection("orders")
        .doc(getOrderID)
        .update({
      "status": "ended",
    });
    Navigator.pop(context);
  }

  updateOrderEnd(BuildContext context, String getOrderID, String sellerUID, String purchaserId) {

    FirebaseFirestore.instance
        .collection("orders")
        .doc(getOrderID)
        .update({
      "status": "ended",
    });
  }

  getPrevEarnings(BuildContext context, String getOrderID, String sellerUID, String purchaserId) {

    FirebaseFirestore.instance
        .collection("sellers")
        .doc(sellerId)
        .get().then((snap)
    {
      previousEarnings = snap.data()!["earnings"].toString();
    }).then((value)
    {
      FirebaseFirestore.instance
          .collection("orders")
          .doc(orderId)
          .get().then((snap)
      {
         totalAmount = snap.data()!["totalAmount"].toString();
      }).then((value)
      {
        FirebaseFirestore.instance
            .collection("sellers")
            .doc(sellerId)
            .update({
          "earnings": (double.parse(totalAmount) + (double.parse(previousEarnings))).toString(),
        });
        print("Test 1: " + totalAmount);
      });
      print("Test 2: " + previousEarnings);
    });
  }


  @override
  Widget build(BuildContext context)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
              'Shipping Details:',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
          ),
        ),
        const SizedBox(
          height: 6.0,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 5),
          width: MediaQuery.of(context).size.width,
          child: Table(
            children: [
              TableRow(
                children: [
                  const Text(
                    "Name",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(model!.name!),
                ],
              ),
              TableRow(
                children: [
                  const Text(
                    "Phone Number",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(model!.phoneNumber!),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            model!.fullAddress!,
            textAlign: TextAlign.justify,
          ),
        ),


        orderStatus == "preparing"
            ? Container(child: Center(
          child: InkWell(
            onTap: ()
            {
              updateOrder(context, orderId!, sellerId!, orderByUser!);
              confirmedParcelShipment(context, orderId!, sellerId!, orderByUser!);
              //getPrevEarnings(context, orderId!, sellerId!, orderByUser!);
            },
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.redAccent,
                      Colors.orangeAccent,
                    ],
                    begin:  FractionalOffset(0.0, 0.0),
                    end:  FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp,
                  )
              ),
              width: MediaQuery.of(context).size.width - 40,
              height: 50,
              child: const Center(
                child: Text(
                  "Done",
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                ),
              ),
            ),
          ),
        ),)
            : Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: InkWell(
              onTap: ()
              {
                updateOrderEnd(context, orderId!, sellerId!, orderByUser!);
                confirmedParcelShipmentEnd(context, orderId!, sellerId!, orderByUser!);
                getPrevEarnings(context, orderId!, sellerId!, orderByUser!);
              },
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.redAccent,
                        Colors.orangeAccent,
                      ],
                      begin:  FractionalOffset(0.0, 0.0),
                      end:  FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    )
                ),
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                child: const Center(
                  child: Text(
                    "Confirm Pick Up",
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 20,),
      ],
    );
  }
}
