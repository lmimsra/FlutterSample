import 'package:flutter/material.dart';

class UserInfoScreen extends StatelessWidget {
  UserInfoScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ユーザー情報'),
      ),
      body: Text('privante ユーザー情報ページ'),

    );
  }
}
