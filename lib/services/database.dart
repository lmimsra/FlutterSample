import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:privante/models/user.dart';
import 'package:privante/services/data_path.dart';

abstract class Database {}

class FirestoreDatabases implements Database {
  // Document単体の取得
  Future<DocumentSnapshot> getDocument(String path) async {
    return await Firestore.instance.document(path).get();
  }

  // Collection単位の取得
  Future<QuerySnapshot> getCollection(String path) async {
    return await Firestore.instance.collection(path).getDocuments();
  }

  // Documentの追加
  Future<void> addDocument(Map<String, dynamic> data, String path) async {
    return await Firestore.instance.collection(path).add(data);
  }

  // Documentの更新、作成
  Future<void> setDocument(Map<String, dynamic> data, String path) async {
    return await Firestore.instance.collection(path).add(data);
  }

  // Documentの存在確認
  Future<bool> checkDocument(String path) async {
    final check = await Firestore.instance.document(path).get();
    return check.exists;
  }

  // イベント作成
  Future<void> createEvent(Map<String, dynamic> eventData, String uid) async {
    final eventPath = '/events';
    final userPath = '/users/$uid/myEvents';
    final addRef =
        await Firestore.instance.collection(eventPath).add(eventData);
    await Firestore.instance
        .document(userPath + '/${addRef.documentID}')
        .setData(eventData);
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
        description: '秘密',
        createdAt: DateTime.now(),
      );
    return User.fromJson(userData.data);
  }

  // Userオブジェクトからfirestoreに保存
  Future<void> setUserInfo(User user) async {
    final path = DataPath.user(uid: user.id);
    return await Firestore.instance.document(path).setData(user.toJson());
  }
}
