import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:privante/models/user.dart';
import 'package:privante/services/database.dart';

class UserInfoScreen extends StatelessWidget {
  UserInfoScreen({Key key}) : super(key: key);

  // User情報取得
  Future<User> _getUserInfo() async {
    final FirebaseUser _user = await FirebaseAuth.instance.currentUser();
    final database = FirestoreDatabases(uid: _user.uid);
    return await database.getUserInfo(_user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ユーザー情報'),
      ),
      body: Center(
        child: FutureBuilder(
          future: _getUserInfo(),
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            if (!snapshot.hasData) {
              // データの取得に時間がかかる場合は
              return CircularProgressIndicator();
            }
            return Text(snapshot.data.name);
          },
        ),
      ),
    );
  }
}
