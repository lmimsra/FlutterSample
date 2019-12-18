import 'package:flutter/material.dart';
import 'package:privante/pages/my_events.dart';
import 'package:privante/pages/open_events.dart';
import 'package:privante/pages/search_events.dart';
import 'package:privante/pages/user_info.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var _buttonText = 'Default';
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Widget switchPages() {
    switch (_currentIndex) {
      case 0:
        return OpenEventsScreen(count: _counter,);
        break;
      case 1:
        return MyEventsScreen();
        break;
      case 2:
        return UserInfoScreen();
        break;
      default:
        {
          return OpenEventsScreen(count: _counter,);
        }
    }
  }

  int getCurrentIndex() {
    return _currentIndex == 2 ? 0 : _currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
      ),
//      body: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              'You have pushed the button this many times:',
//            ),
//            Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.display1,
//            ),
//            Text(
//              _buttonText,
//              style: TextStyle(fontSize: 32, fontStyle: FontStyle.italic),
//            )
//          ],
//        ),
//      ),
      body: switchPages(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
            icon: const Icon(Icons.playlist_add_check),
            title: new Text('登録済みイベント'),
          ),
//          new BottomNavigationBarItem(
//            icon: const Icon(Icons.search),
//            title: new Text('検索'),
//            backgroundColor: Colors.blue
//          ),
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
                'menu',
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
                setState(() {
                  _buttonText = 'Los Angeles, CA';
                  _currentIndex = 2;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Honolulu'),
              onTap: () {
                setState(() => _buttonText = 'Honolulu, HI');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Dallas'),
              onTap: () {
                setState(() => _buttonText = 'Dallas, TX');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Seattle'),
              onTap: () {
                setState(() => _buttonText = 'Seattle, WA');
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              title: Text('お問合せ'),
              onTap: () {
                setState(() => _buttonText = 'Tokyo, Japan');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
