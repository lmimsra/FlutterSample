import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:privante/components/platform_alert_dialog.dart';
import 'package:privante/pages/my_events.dart';
import 'package:privante/pages/checked_events.dart';
import 'package:privante/states/home_change_notifer.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({@required this.onSignOut});

  final VoidCallback onSignOut;

  // サインアウト処理
  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      onSignOut();
    } catch (e) {
      print(e.toString());
      // TODO エラー表示
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: "Logout",
      content: "本当にログアウトしてよろしいでしょうか？",
      defaultActionText: "ログアウト",
      cancelActionText: "キャンセル",
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut();
    }
  }

  // 表示する画面の切替
  Widget switchPages(int index) {
    switch (index) {
      case 0:
        return CheckedEventsScreen();
        break;
      case 1:
        return MyEventsScreen();
        break;
      default:
        {
          return CheckedEventsScreen();
        }
    }
  }

  // フロートボタン押下時の遷移先切替
  void _pushNavigate(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/eventSearch');
        break;
      case 1:
        Navigator.pushNamed(context, '/eventSearch');
        break;
      default:
        {}
    }
  }

  // 右下フロートボタンのアイコン切替
  Icon _getFloatButtonIcon(int index) {
    switch (index) {
      case 0:
        return Icon(Icons.search);
        break;
      case 1:
        return Icon(Icons.add);
        break;
      default:
        {
          return Icon(Icons.error);
        }
    }
  }

  // 画面の表示に応じてタイトルバーの文言切替
  String getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return '登録済みイベント';
        break;
      case 1:
        return 'Myイベント';
        break;
      default:
        {
          return '';
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<HomeChangeNotifier>(context);
    final index = notifier.homePageIndex;
    return Scaffold(
      appBar: AppBar(
        title: Text(getAppBarTitle(index)),
      ),
      body: switchPages(index),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _pushNavigate(index, context);
        },
        tooltip: 'navigate',
        child: _getFloatButtonIcon(index),
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
            icon: const Icon(Icons.playlist_add_check),
            title: new Text('登録済みイベント'),
          ),
          new BottomNavigationBarItem(
            icon: const Icon(Icons.border_color),
            title: new Text('Myイベント'),
          )
        ],
        currentIndex: index,
        onTap: (int index) {
          notifier.updateHomePageIndex(index);
        },
      ),
      // サイドメニュー
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: Align(
                alignment: FractionalOffset.centerLeft,
                child: Text(
                  'メニュー',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
              ),
              // padding margin の設定
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
//              margin: EdgeInsets.only(bottom: 8.0),
            ),
            Expanded(
                child: ListView(children: <Widget>[
              ListTile(
                title: Text('ユーザー情報'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/userInfo');
                },
              ),
            ])),
            Container(
                // This align moves the children to the bottom
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    // This container holds all the children that will be aligned
                    // on the bottom and should not scroll with the above ListView
                    child: Container(
                        child: Column(
                      children: <Widget>[
                        Divider(),
                        ListTile(
                          // TODO 匿名アカウント時には表示しない
                          leading: Icon(Icons.close),
                          title: Text('ログアウト or 仮アカウント削除'),
                          onTap: () {
                            Navigator.pop(context);
                            _confirmSignOut(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.help),
                          title: Text('ヘルプ'),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/help');
                          },
                        )
                      ],
                    ))))
          ],
        ),
      ),
    );
  }
}
