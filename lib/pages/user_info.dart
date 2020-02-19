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
    print(_user.uid);
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
            return SingleChildScrollView(
              child: _buildBody(context, snapshot.data),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, User user) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 10.0),
      child: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: screenSize.height / 20,
          ),
          Center(
            child: Container(
              width: 140.0,
              height: 140.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    user.imageUrl,
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(80.0),
                border: Border.all(
                  color: Colors.white,
                  width: 5.0,
                ),
              ),
            ),
          ),
          Text(user.name),
          Text(user.description),
          Divider(height: screenSize.height / 30, color: Colors.black),
          Row(
            children: <Widget>[
              rowCell(673826, 'FOLLOWERS'),
              rowCell(275, 'FOLLOWING'),
            ],
          ),
          Divider(height: screenSize.height / 30, color: Colors.black),
        ],
      ),
    );
  }

  // セルの中身
  Widget rowCell(int count, String type) => Expanded(
        child: Column(
          children: <Widget>[
            Text('$count', style: TextStyle(color: Colors.black)),
            Text(
              type,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
            )
          ],
        ),
      );
}
