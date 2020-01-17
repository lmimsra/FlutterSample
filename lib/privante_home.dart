import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:privante/pages/auth/sign_in.dart';
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
    }
  }

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
        actions: <Widget>[
          FlatButton(
            child: Text(
              'ログアウト',
              style: TextStyle(fontSize: 15.0, color: Colors.white),
            ),
            onPressed: _signOut,
          )
        ],
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
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'メニュー',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
              ),
              // padding margin の設定
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              margin: EdgeInsets.only(bottom: 8.0),
            ),
            ListTile(
              title: Text('ユーザー情報'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/userInfo');
              },
            ),
//                ListTile(
//                  title: Text('サインイン'),
//                  onTap: () {
//                    Navigator.pop(context);
//                    Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                            builder: (BuildContext context) {
//                              return SignInScreen();
//                            },
//                            fullscreenDialog: true));
//                  },
//                ),
            Divider(),
            ListTile(
              title: Text('ヘルプ'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/help');
              },
            ),
          ],
        ),
      ),
    );
  }
}
