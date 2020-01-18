import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:privante/pages/auth/sign_in.dart';
import 'package:privante/privante_home.dart';
import 'package:privante/states/home_change_notifer.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  FirebaseUser _user;

  Future<void> _checkCurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    _updateUser(user);
  }
  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }
  void _updateUser(FirebaseUser user) {
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return SignInScreen(
        onSignIn: _updateUser,
      );
    }
    return ChangeNotifierProvider(
        create: (_) => HomeChangeNotifier(),
        child: MyHomePage(
          onSignOut: () => _updateUser(null),
        ));
  }
}
