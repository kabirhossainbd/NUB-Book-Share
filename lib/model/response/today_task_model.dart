import 'package:flutter/material.dart';
import 'package:nub_book_sharing/model/response/task_model.dart';

class TodayModel {
  int? id;
  String? name;
  Color? color;
  String? createAt;
  List<Users>? users;

  TodayModel({this.id, this.name, this.color, this.createAt, this.users});

  TodayModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    createAt = json['createAt'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['color'] = color;
    data['createAt'] = createAt;
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

