import 'package:flutter/material.dart';

import 'event_detail.dart';

class CheckedEventsScreen extends StatelessWidget {
  CheckedEventsScreen({Key key}) : super(key: key);

  List<Widget> getItemList() {
    List<Widget> returnVal = [];

    return returnVal;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        // 本来はここをstate管理で動的に生成
        itemCount: 20,
        itemBuilder: (context, i) => Column(
          children: <Widget>[
            Divider(
              height: 10.0,
            ),
            ListTile(
                leading: Image.network(
                  'https://bulma.io/images/placeholders/96x96.png',
                ),
                title: Row(children: <Widget>[
                  Flexible(
                    child: Text(
                        'checked event test name aaaaaa aaaa aaaaaa aaaa aaaaaa $i'),
                  )
                ]),
                subtitle: Container(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(
                            "message message message message message message message message$i"),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => EventDetailScreen(
                        eventPath: '/checkedEvents/$i',
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
