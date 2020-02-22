import 'package:flutter/material.dart';

class User {
  final String id;
  final String name;
  final String imageUrl;
  String email;
  String description;
  int sex;
  DateTime birthday;
  int age;
  DateTime createdAt;

  User({
    @required this.id,
    @required this.name,
    @required this.imageUrl,
    @required this.description,
    @required this.createdAt,
    this.sex,
    this.birthday,
    this.age,
  });

  // json形式からclassに変換
  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        imageUrl = json['imageUrl'],
        email = json['email'],
        description = json['description'],
        sex = json['sex'],
        birthday = json['birthday'],
        age = json['age'],
        createdAt = json['createdAt'].toDate();

  // json形式にマッピング
  Map<String, dynamic> toJson() => {
        "id": id,
        'name': name,
        "imageUrl": imageUrl,
        'email': email,
        'description': description,
        'sex': sex,
        'birthday': birthday,
        'age': age,
        'createdAt': createdAt,
      };
}
