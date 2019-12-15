import 'package:flutter/material.dart';
import 'package:sample_flutter_app/privante_home.dart';

void main() => runApp(RootWidget());

class RootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(title: 'privante'),
    );
  }
}