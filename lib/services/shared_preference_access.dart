import 'dart:convert';

import 'package:privante/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceAccess {
  SharedPreferences prefs;
  static const userInfoKey = 'userInfo';
  static const isLoginKey = 'isLogin';

  SharedPreferenceAccess() {
    initInstance();
  }

// アクセスするためのインスタンス初期化
  void initInstance() async {
    prefs = await SharedPreferences.getInstance();
  }

// ログイン処理を通ったことがあるか確認
  bool getIsLogin() => prefs.getBool(isLoginKey);

  Future<bool> setIsLogin(bool isLogin) => prefs.setBool(isLoginKey, isLogin);

// ユーザー情報の登録、取得
  User getUserInfo() => User.fromJson(jsonDecode(prefs.getString(userInfoKey)));

  Future<bool> setUserInfo(User user) =>
      prefs.setString(userInfoKey, jsonEncode(user.toJson()));
}
