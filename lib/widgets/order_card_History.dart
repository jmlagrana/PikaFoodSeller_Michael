import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pika_food/mainScreens/history_Detail_Screen.dart';


import '../mainScreens/order_details_screen.dart';
import '../model/items.dart';



class OrderCardHistory extends StatelessWidget
{
  final int? itemCount;
  final List<DocumentSnapshot>? data;
  final String? orderID;
  final List<String>? seperateQuantitiesList;

  OrderCardHistory({
    this.itemCount,
    this.data,
    this.orderID,
    this.seperateQuantitiesList,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> HistoryDetailScreen(orderID: orderID)));
      },
      child: Column(
        children: [
          Container(
            //addtional codes goes here
            height: 30,
            color: Colors.grey,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
            ),
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.all(5),
            height: itemCount! * 50,
            child: Stack(
              children: [
                Padding(padding: EdgeInsets.all(10)),
                ListView.builder(
                  itemCount: itemCount,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index)
                  {
                    Items model = Items.fromJson(data![index].data()! as Map<String, dynamic>);
                    return Align(
                      heightFactor: 0.3,
                      alignment: Alignment.topCenter,
                      child: placedOrderDesignWidget(model, context, seperateQuantitiesList![index]),
                    );
                  },
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}


Widget placedOrderDesignWidget(Items model, BuildContext context, seperateQuantitiesList)
{
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 120,
    color: Colors.grey[200],
    child: Row(
      children: [
        Image.network(model.thumbnailUrl!, width: 120,),
        const SizedBox(width: 10.0,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(
                height: 20,
              ),

              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      model.name!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "Acme",
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "₱ ",
                    style: TextStyle(fontSize: 16.0, color: Colors.blue),
                  ),
                  Text(
                    model.price.toString(),
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),

              Row(
                children: [
                  const Text(
                      "x ",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                  ),
                  Expanded(
                    child: Text(
                      seperateQuantitiesList,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 30,
                        fontFamily: "Acme",
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ],
    ),
  );
}
