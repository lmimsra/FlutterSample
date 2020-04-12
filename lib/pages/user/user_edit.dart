import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:privante/models/user.dart';
import 'package:privante/services/database.dart';
import 'package:privante/services/shared_preference_access.dart';

// ユーザー情報編集画面
class UserEditScreen extends StatefulWidget {
  UserEditScreen({Key key}) : super(key: key);

  @override
  _UserEditState createState() => _UserEditState();
}

class _UserEditState extends State<UserEditScreen> {
  _UserEditState();

  //  各種状態変数
  User _user;
  bool _submitted = false;
  bool _isLoading = false;

  // controllers
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _descriptionEditingController =
      TextEditingController();
  final TextEditingController _imageEditingController = TextEditingController();

  // getter
  String get _name => _nameEditingController.text;

  String get _description => _descriptionEditingController.text;

  String get _image => _imageEditingController.text;

  // TODO Focus node 追加

  // User情報取得
  Future<bool> _initUserInfo() async {
    User _user = await SharedPreferenceAccess.getUserInfo();
    if (_user == null) {
      // ユーザーが保存されていなかったらfirebaseから直接取得
      final FirebaseUser currentUser =
          await FirebaseAuth.instance.currentUser();
      final database = FirestoreDatabases();
      _user = await database.getUserInfo(currentUser.uid);
    }

    // 初期画像をセット
    _imageEditingController.text = _user.imageUrl;
    return true;
  }

  // ユーザー情報更新
  void _submit() async {
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    // TODO 1びょう処理遅らせるので、後で削除すること
    await Future.delayed(Duration(seconds: 1));

  }

  // 画面の描画など
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ユーザー情報編集'),
      ),
      body: Center(
        child: FutureBuilder(
          future: _initUserInfo(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (!snapshot.hasData) {
              // データの取得に時間がかかる場合は
              return CircularProgressIndicator();
            }
            return SingleChildScrollView(
              child: _buildBody(context),
            );
          },
        ),
      ),
    );
  }

  // 画面のコンテンツ
  Widget _buildBody(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 10.0),
      child: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: screenSize.height / 100,
          ),
          Center(
            child: Container(
              width: 140.0,
              height: 140.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    _image,
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(80.0),
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
            ),
          ),
          _buildNameTextField(),
          Divider(height: screenSize.height / 30, color: Colors.grey),
          SizedBox(
            height: screenSize.height / 100,
          ),

          _buildDescriptionField(),
        ],
      ),
    );
  }

  // 氏名の入力フィールド
  Widget _buildNameTextField() {
    return TextField(
      controller: _nameEditingController,
      decoration: InputDecoration(
        labelText: 'name',
      ),
      obscureText: true,
      enabled: _isLoading == false,
    );
  }

 // 概要蘭の入力フィールド
  Widget _buildDescriptionField() {
    return TextField(
      controller: _descriptionEditingController,
      decoration: InputDecoration(
        labelText: 'description',
      ),
      obscureText: true,
      enabled: _isLoading == false,
    );
  }

  // TODO 画像のアップデートどうしよう問題
}
