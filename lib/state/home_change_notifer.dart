import 'package:flutter/material.dart';

class HomeChangeNotifier extends ChangeNotifier {
  List _myEvents;
  List _checkedEvents;

  HomeChangeNotifier() {
    // 各Listの初期化
    _myEvents=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17];
    _checkedEvents=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17];
    updateMyEvents();
    updateCheckedEvents();
  }

  // getter
  List get myEvents => _myEvents;

  List get checkedEvents => _checkedEvents;

  void updateMyEvents(){
    //イベント更新処理
    notifyListeners();
  }

  void updateCheckedEvents(){
    //イベント更新処理
    notifyListeners();
  }
}
