import 'package:flutter/material.dart';

void main() => runApp(RootWidget());

class RootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'privante'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var _buttonText = 'Default';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.account_circle), onPressed: () {
            _scaffoldKey.currentState.openDrawer();
        },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            Text(
              _buttonText,
              style: TextStyle(
                fontSize: 32,
                fontStyle: FontStyle.italic
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: new BottomNavigationBar(items: [
        new BottomNavigationBarItem(
          icon: const Icon(Icons.featured_play_list),
          title: new Text('タイムライン'),
        ),
        new BottomNavigationBarItem(
          icon: const Icon(Icons.playlist_add_check),
          title: new Text('Myイベント'),
        ),
        new BottomNavigationBarItem(
          icon: const Icon(Icons.search),
          title: new Text('検索'),
        )
      ]),
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
                color: Colors.blue,

              ),
              // padding margin の設定
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              margin: EdgeInsets.only(bottom: 8.0),
            ),
            ListTile(
              title: Text('Los Angeles'),
              onTap: () {
                setState(() => _buttonText = 'Los Angeles, CA');
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
              title: Text('Tokyo'),
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
