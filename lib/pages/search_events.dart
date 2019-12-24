import 'package:flutter/material.dart';

class SearchEventsScreen extends StatelessWidget {
  SearchEventsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('イベント検索'),
      ),
      body: Text('privante イベント検索ページ'),

    );
  }
}
