import 'package:flutter/material.dart';
import 'package:privante/pages/event_detail.dart';
import 'package:privante/states/home_change_notifer.dart';
import 'package:provider/provider.dart';

class MyEventsScreen extends StatelessWidget {
  MyEventsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<HomeChangeNotifier>(context);
    return Container(
      child: ListView.builder(
        // 本来はここをstate管理で動的に生成
        itemCount: events.myEvents.length,
        itemBuilder: (context, i) => Column(
          children: <Widget>[
            Divider(
              height: 10.0,
            ),
            ListTile(
              // TODO 文字列の折り返しをサポートすること。
                leading: Image.network(
                  'https://bulma.io/images/placeholders/96x96.png',
                ),
                title: Row(children: <Widget>[
                  Text('my testevent name ' + events.myEvents.elementAt(i).toString()),
                  Text(' test other $i')
                ]),
                subtitle: Container(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text('message ' + events.myEvents.elementAt(i).toString()),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => EventDetailScreen(
                        isMyEvent: true,
                        eventPath: '/myEvents/$i',
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
