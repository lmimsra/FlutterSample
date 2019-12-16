import 'package:flutter/material.dart';

class OpenEventsScreen extends StatelessWidget {
  OpenEventsScreen({Key key, @required this.count}) : super(key: key);
  final int count;

  @override
  Widget build(BuildContext context) {
    return Text('公開イベント count->'+'$count');
  }
}
