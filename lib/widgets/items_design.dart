import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:pika_food/mainScreens/Update_Items_Screen.dart';
import 'package:pika_food/model/items.dart';

import '../mainScreens/item_detail_screen.dart';


class ItemsDesignWidget extends StatefulWidget
{
  Items? model;
  BuildContext? context;

  ItemsDesignWidget({this.model, this.context});

  @override
  _ItemsDesignWidgetState createState() => _ItemsDesignWidgetState();
}



class _ItemsDesignWidgetState extends State<ItemsDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemDetailsScreen ()));
      },
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 220,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 1,),
              Text(
                widget.model!.name!,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: "Train",
                ),
              ),
              const SizedBox(height: 2,),
              Image.network(
                widget.model!.thumbnailUrl!,
                height: 150.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 2.0,),
              Text(
                widget.model!.description!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 2.0,),

              Text(
                widget.model!.name! + " x " + widget.model!.quantity.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: "Train",
                ),
              ),

              const SizedBox(height: 1,),
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
