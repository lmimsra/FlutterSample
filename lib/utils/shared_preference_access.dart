import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceAccess {
  SharedPreferences prefs;
  static const userInfoKey = 'userInfo';

  SharedPreferenceAccess() {
    initInstance();
  }

// アクセスするためのインスタンス初期化
  void initInstance() async {
    prefs = await SharedPreferences.getInstance();
  }
// ユーザー情報の登録、取得
  Map getUserInfo() => jsonDecode(prefs.getString(userInfoKey));

  Future<bool> setUserInfo(Map userInfo) =>
      prefs.setString(userInfoKey, jsonEncode(userInfo));
}
