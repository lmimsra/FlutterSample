import 'package:flutter/material.dart';

class EventDetailScreen extends StatelessWidget {
  EventDetailScreen({Key key, this.isMyEvent = false, @required this.eventPath})
      : super(key: key);
  final bool isMyEvent;
  final String eventPath;

  String _getMessage() {
    return (isMyEvent ? 'MyEvent Path is ' : 'Other Event Path is ') +
        eventPath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('イベント詳細'),
      ),
      body: Center(
          child: Text('privante イベント詳細ページ\n' + _getMessage())
      ),
    );
  }
}
