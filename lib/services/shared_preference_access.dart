import 'dart:convert';

import 'package:privante/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

// sharedPreferenceのアクセス用関数(IOしかないので状態は持たない)
class SharedPreferenceAccess {
  static const userInfoKey = 'userInfo';

  // アクセスするためのインスタンス初期化
  static Future<SharedPreferences> _initInstance() async {
    return await SharedPreferences.getInstance();
  }

  // ユーザー情報の取得
  static Future<User> getUserInfo() async {
    final prefs = await _initInstance();
    final data = prefs.get(userInfoKey);
    return User.fromJsonForSharedPreference(jsonDecode(prefs.get(userInfoKey)));
  }

  // ユーザー情報の登録
  static Future<bool> setUserInfo(User user) async{
    final prefs = await _initInstance();
    return prefs.setString(
        userInfoKey, jsonEncode(user.toJsonForSharedPreference()));
  }

  // ローカルに保存している情報を全削除
  static Future<void> deleteLocalData() async {
    final prefs = await _initInstance();
    await prefs.clear();
  }
}
