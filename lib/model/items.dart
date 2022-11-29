import 'package:cloud_firestore/cloud_firestore.dart';

class Items
{
  String? menuID;
  String? sellerUID;
  String? itemID;
  String? name;
  Timestamp? publishedDate;
  String? thumbnailUrl;
  String? description;
  String? status;
  int? quantity;
  int? price;
  String? sellerName;


  Items({
    this.menuID,
    this.sellerUID,
    this.itemID,
    this.name,

    this.publishedDate,
    this.thumbnailUrl,
    this.description,
    this.status,
    this.quantity,
    this.sellerName,
    this.price,
  });

  Items.fromJson(Map<String, dynamic> json)
  {
    menuID = json['menuID'];
    sellerUID = json['sellerUID'];
    itemID = json['itemID'];
    name = json['name'];
    publishedDate = json['publishedDate'];
    thumbnailUrl = json['thumbnailUrl'];
    description = json['description'];
    status = json['status'];
    quantity = json['quantity'];
    price = json['price'];

    sellerName = json['sellerName'];
  }

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['menuID'] = menuID;
    data['sellerUID'] = sellerUID;
    data['itemID'] = itemID;
    data['name'] = name;

    data['price'] = price;
    data['publishedDate'] = publishedDate;
    data['thumbnailUrl'] = thumbnailUrl;
    data['description'] = description;
    data['status'] = status;
    data['quantity'] = quantity;
    data['sellerName'] = sellerName;

    return data;
  }
}