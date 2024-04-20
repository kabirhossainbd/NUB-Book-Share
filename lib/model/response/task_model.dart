import 'package:flutter/material.dart';

class TaskModel {
  int? id;
  String? name;
  Color? color;
  String? taskNo;
  String? createAt;
  List<Users>? users;

  TaskModel(
      {this.id, this.name, this.color, this.taskNo, this.createAt, this.users});

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    taskNo = json['task_no'];
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
    data['task_no'] = taskNo;
    data['createAt'] = createAt;
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  int? id;
  String? name;
  String? photo;

  Users({this.id, this.name, this.photo});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['photo'] = photo;
    return data;
  }
}
