import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:privante/models/user.dart';
import 'package:privante/services/data_path.dart';

abstract class Database {}

class FirestoreDatabases implements Database {
  FirestoreDatabases({@required this.uid});

  final String uid;

  Future<void> createEvent(Map<String, dynamic> eventData) async {
    final eventPath = '/events';
    final userPath = '/users/$uid/myEvents';
    final addRef =
        await Firestore.instance.collection(eventPath).add(eventData);
    await Firestore.instance
        .document(userPath + '/${addRef.documentID}')
        .setData(eventData);
  }

  Future<DocumentSnapshot> getContent(String path) async {
    return await Firestore.instance.document(path).get();
  }

  Future<User> getUserInfo(String uid) async {
    final path = DataPath.user(uid: uid);
    // firebaseのデータ取得
    var userData = await Firestore.instance.document(path).get();
    if (userData.data == null)
      return User(id: uid, name: "匿名ユーザー", imageUrl: "");
    return new User(
      id: uid,
      name: userData.data['name'],
      imageUrl: userData.data['imageUrl'],
      description: userData.data['description'],
      age: userData.data['age'],
      createdAt: userData.data['created_at'].toDate(),
    );
  }
}
