
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:privante/pages/auth/sign_in.dart';
import 'package:privante/privante_home.dart';

class LandingScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>{
  FirebaseUser _user;

  void _initUser() async{
    // TODO: ログイン情報を保持できるようにする
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    _user = user;
  }

  void _updateUser(FirebaseUser user){
    setState(() {
      _user = user;
    });
  }
  @override
  Widget build(BuildContext context) {
    _initUser();
    if (_user == null) {
      return SignInScreen(
        onSignIn: _updateUser,
      );
    }
    return MyHomePage();
  }

}