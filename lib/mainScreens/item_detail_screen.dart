import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pika_food/mainScreens/home_screen.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

import '../global/global.dart';
import '../model/items.dart';
import '../splashScreen/splash_screen.dart';
import '../widgets/simple_app_bar.dart';



class ItemDetailsScreen extends StatefulWidget
{
  final Items? model;
  ItemDetailsScreen({this.model});

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}




class _ItemDetailsScreenState extends State<ItemDetailsScreen>
{
  TextEditingController counterTextEditingController = TextEditingController();

  int _newQuantity = 0;

  deleteItem(String itemID)
  {
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus")
        .doc(widget.model!.menuID!)
        .collection("items")
        .doc(itemID)
        .delete().then((value)
    {
      FirebaseFirestore.instance
          .collection("items")
          .doc(itemID)
          .delete();

      Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
      Fluttertoast.showToast(msg: "Item Deleted Successfully.");
    });
  }


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: SimpleAppBar(title: sharedPreferences!.getString("name"),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(widget.model!.thumbnailUrl.toString()),

          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              widget.model!.name.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Text(
              widget.model!.description.toString(),
              textAlign: TextAlign.justify,
              style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Text(
            "₱ " + widget.model!.price.toString()  ,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Text(
              "Items in stock : " + widget.model!.quantity.toString()  ,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          Divider(
            height: 15,
            color: Colors.grey,
          ),
          Container(
            width: 150,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: NumberInputPrefabbed.squaredButtons(
                buttonArrangement: ButtonArrangement.incRightDecLeft,
                controller: counterTextEditingController,
                incDecBgColor: Colors.amber,
                min: 1,
                initialValue: 1,
              ),
            ),
          ),
          //Try button only
          //INCREMENT
          Center(
            child: InkWell(
              onTap: ()
              {
                _newQuantity = widget.model!.quantity!.toInt() + int.parse(counterTextEditingController.text);

                FirebaseFirestore.instance
                    .collection("sellers")
                    .doc(widget.model!.sellerUID)
                    .collection("menus")
                    .doc(widget.model!.menuID)
                    .collection("items")
                    .doc(widget.model!.itemID)
                    .update({
                  "quantity": _newQuantity,
                });

                Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
                Fluttertoast.showToast(msg: "Item updated successfully.");
                debugPrint("Quantity: " +  _newQuantity.toString());
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
                width: MediaQuery.of(context).size.width - 13,
                height: 50,
                child: const Center(
                  child: Text(
                    "Increase Item Qty",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
          ),
          Divider(
            height: 7.5,
            color: Colors.grey,
          ),
          //DECREMENT
          Center(
            child: InkWell(
              onTap: ()
              {
                _newQuantity = widget.model!.quantity!.toInt() - int.parse(counterTextEditingController.text);

                FirebaseFirestore.instance
                    .collection("sellers")
                    .doc(widget.model!.sellerUID)
                    .collection("menus")
                    .doc(widget.model!.menuID)
                    .collection("items")
                    .doc(widget.model!.itemID)
                    .update({
                  "quantity": _newQuantity,
                });
                Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
                Fluttertoast.showToast(msg: "Item updated successfully.");
                debugPrint("Quantity: " +  _newQuantity.toString());
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
                width: MediaQuery.of(context).size.width - 13,
                height: 50,
                child: const Center(
                  child: Text(
                    "Decrease Item Qty",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
          ),
          Divider(
            height: 15,
            color: Colors.grey,
          ),
          Center(
            child: InkWell(
              onTap: ()
              {
                //delete item
                deleteItem(widget.model!.itemID!);
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
                width: MediaQuery.of(context).size.width - 13,
                height: 50,
                child: const Center(
                  child: Text(
                    "Delete this Item",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
