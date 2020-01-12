import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserInfoScreen extends StatelessWidget {
  UserInfoScreen({Key key}) : super(key: key);

  Future<String> _getUserInfo() async {
    final FirebaseUser _user = await FirebaseAuth.instance.currentUser();
    return 'uid: ${_user.uid} display Name: ${_user.displayName} email: ${_user.email}';
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
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) {
              // データの取得に時間がかかる場合は
              return CircularProgressIndicator();
            }
            return Text(snapshot.data);
          },
        ),
      ),
    );
  }
}
