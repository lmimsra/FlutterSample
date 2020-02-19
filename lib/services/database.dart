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

  // ユーザー情報を取得してUserオブジェクトで返却
  Future<User> getUserInfo(String uid) async {
    final path = DataPath.user(uid: uid);
    // firebaseのデータ取得
    var userData = await Firestore.instance.document(path).get();
    if (userData.data == null)
      return User(
          id: uid,
          name: '匿名ユーザー',
          imageUrl: 'https://bulma.io/images/placeholders/96x96.png',
          description: '秘密');
    return User.fromJson(userData.data);
  }

  Future<void> setUserInfo(User user) async {
    final path = DataPath.user(uid: user.id);
    return await Firestore.instance.document(path).setData(user.toJson());
  }
}
