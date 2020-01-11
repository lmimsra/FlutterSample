import 'package:flutter/material.dart';
import 'package:privante/pages/auth/sign_in.dart';
import 'package:privante/pages/my_events.dart';
import 'package:privante/pages/checked_events.dart';
import 'package:privante/states/home_change_notifer.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//  現在ホーム画面に表示されているページ
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget switchPages() {
    switch (_currentIndex) {
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

  void _pushNavigate() {
    switch (_currentIndex) {
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

  Icon _getFloatButtonIcon() {
    switch (_currentIndex) {
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

  int getCurrentIndex() {
    return _currentIndex == 2 ? 0 : _currentIndex;
  }

  String getAppBarTitle() {
    switch (_currentIndex) {
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
    return ChangeNotifierProvider(
        create: (_) => HomeChangeNotifier(),
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(getAppBarTitle()),
            leading: IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              },
            ),
          ),
          body: switchPages(),
          floatingActionButton: FloatingActionButton(
            onPressed: _pushNavigate,
            tooltip: 'navigate',
            child: _getFloatButtonIcon(),
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
            currentIndex: getCurrentIndex(),
            onTap: (int index) {
              setState(() {
                this._currentIndex = index;
              });
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
                ListTile(
                  title: Text('サインイン'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context){
                        return SignInScreen();
                      },
                      fullscreenDialog: true
                    ));
                  },
                ),
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
        ));
  }
}
