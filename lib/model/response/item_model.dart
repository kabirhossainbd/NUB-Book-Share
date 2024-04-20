import 'package:flutter/material.dart';

class ItemModel {
  int? id;
  String? name;
  String? image;
  Color? bgColor;
  Color? itemColor;

  ItemModel({this.id, this.name, this.image, this.bgColor, this.itemColor});

  ItemModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['name'];
    image = json['image'];
    bgColor = json['bgColor'];
    itemColor = json['itemColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['bgColor'] = bgColor;
    data['itemColor'] = itemColor;
    return data;
  }
}
