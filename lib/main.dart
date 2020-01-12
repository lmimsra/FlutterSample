import 'package:flutter/material.dart';
import 'package:privante/landing.dart';
import 'package:privante/pages/auth/sign_in.dart';
import 'package:privante/pages/help.dart';
import 'package:privante/pages/search_events.dart';
import 'package:privante/pages/user_info.dart';
import 'package:privante/privante_home.dart';

void main() => runApp(RootWidget());

class RootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: LandingScreen(),
      routes: <String, WidgetBuilder> {
        '/userInfo': (BuildContext context) => UserInfoScreen(),
        '/eventSearch': (BuildContext context) => SearchEventsScreen(),
        '/help': (BuildContext context) => HelpScreen(),
      },
    );
  }
}