import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pika_food/global/global.dart';
import 'package:pika_food/mainScreens/itemsScreen.dart';
import 'package:pika_food/model/menus.dart';

import '../mainScreens/seller_dashboard.dart';
import '../uploadScreens/menus_upload_screen.dart';


class InfoDesignWidget extends StatefulWidget
{
  Menus? model;
  BuildContext? context;

  InfoDesignWidget({this.model, this.context});

  @override
  _InfoDesignWidgetState createState() => _InfoDesignWidgetState();
}

  deleteMenu(String menuID)
  {
    FirebaseFirestore.instance.collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus")
        .doc(menuID)
        .delete();

    Fluttertoast.showToast(msg: "Menu Deleted Successfully.");
  }

class _InfoDesignWidgetState extends State<InfoDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsScreen(model: widget.model)));
      },
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
          ClipRRect(
            borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0)),
              child: Image.network(
                  widget.model!.thumbnailUrl!,
                  height: 150.0,
                  width: 200.0,
                fit: BoxFit.cover,
              ),
          ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5),
                          child:
                          Text(
                            widget.model!.menuTitle.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: "Acme",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            widget.model!.menuInfo.toString(),
                            style: TextStyle(fontSize: 10.0, color: Colors.white60),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Center(
                      child: IconButton(
                        icon: Icon(
                          Icons.dashboard,
                          color: Colors.black,
                        ),
                        onPressed: ()
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (c)=>  SellerDashboardScreen()));
                        },
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
