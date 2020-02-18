import 'package:flutter/material.dart';

class User {
  final String id;
  final String name;
  final String imageUrl;
  String description;
  int sex;
  DateTime birthday;
  int age;
  DateTime createdAt;

  User({
    @required this.id,
    @required this.name,
    @required this.imageUrl,
    this.description,
    this.sex,
    this.birthday,
    this.age,
    this.createdAt,
  });
}
