import 'package:flutter/material.dart';

class MyEventsScreen extends StatelessWidget {
  MyEventsScreen({Key key}) : super(key: key);

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
                Text('my testevent name $i'),
                Text(' test other $i')
              ]),
              subtitle: Container(
                padding: EdgeInsets.only(top: 5.0),
                child: Text("message $i"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
