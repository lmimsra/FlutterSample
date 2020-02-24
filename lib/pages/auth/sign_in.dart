import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:privante/components/sign_in_button.dart';
import 'package:privante/components/social_sign_in_button.dart';
import 'package:privante/models/user.dart';
import 'package:privante/pages/auth/mail_sign_in.dart';
import 'package:privante/pages/auth/twitter_sign_in.dart';
import 'package:privante/services/auth.dart';
import 'package:privante/services/data_path.dart';
import 'package:privante/services/database.dart';
import 'package:privante/services/shared_preference_access.dart';

// ignore: must_be_immutable
class SignInScreen extends StatelessWidget {
  SignInScreen({@required this.onSignIn});

  Function(FirebaseUser) onSignIn;
  final Auth _auth = Auth();

//  匿名ユーザーのログイン処理
  Future<void> _signInAnonymously() async {
    try {
      final authResult = await FirebaseAuth.instance.signInAnonymously();
      saveUserData(authResult.user);
      onSignIn(authResult.user);
    } catch (e) {
      print(e.toString());
      // TODO エラー表示
    }
  }

  // メールログイン処理
  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    try {
      FirebaseUser user = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MailSignInScreen(_auth),
            // モーダル表示
            fullscreenDialog: true,
          ));
      if (user != null) {
        saveUserData(user);
        onSignIn(user);
      }
    } catch (e) {
      print(e.toString());
      // TODO エラー表示
    }
  }

  // Twitterログイン処理
  Future<void> _signInWithTwitter(BuildContext context) async {
    try {
      FirebaseUser user = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TwitterWebView(_auth),
            // モーダル表示
            fullscreenDialog: true,
          ));
      if (user != null) {
        saveUserData(user);
        onSignIn(user);
      }
    } catch (e) {
      print(e.toString());
      // TODO エラー表示
    }
  }

  // ログイン後のユーザーデータ登録処理・ローカル保持
  Future<void> saveUserData(FirebaseUser user) async {
    final database = FirestoreDatabases();
    final path = DataPath.user(uid: user.uid);
    final result = await database.checkDocument(path);
    if (!result) {
      await database.setUserInfo(User(
        id: user.uid,
        name: (user.displayName != null) ? user.displayName : '匿名ユーザー',
        imageUrl: (user.photoUrl != null)
            ? user.photoUrl
            : DotEnv().env['DEFAULT_ICON_URL'],
        description: 'はじめまして！',
        createdAt: DateTime.now(),
      ));
    }
    final userData = await database.getUserInfo(user.uid);
    await SharedPreferenceAccess.setUserInfo(userData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('privante'),
      ),
      body: SingleChildScrollView(child: _buildContent(context)),
      backgroundColor: Colors.grey[200],
    );
  }

  // ログイン画面
  Widget _buildContent(BuildContext context) => Padding(
        padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 48.0,
            ),
            Text(
              'サインイン',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 48.0),
//            SocialSignInButton(
//              assetName: 'images/google-logo.png',
//              text: 'Sign in with Google',
//              textColor: Colors.black87,
//              color: Colors.white,
//              onPressed: () {},
//            ),
//            SizedBox(height: 8.0),
//            SocialSignInButton(
//              assetName: 'images/facebook-logo.png',
//              text: 'Sign in with Facebook',
//              textColor: Colors.white,
//              color: Color(0xFF334D92),
//              onPressed: () {},
//            ),
//            SizedBox(height: 8.0),
            SocialSignInButton(
              assetName: 'images/twitter-logo.png',
              text: 'Sign in with Twitter',
              textColor: Colors.white,
              color: Color(0xFF1DA1F2),
              onPressed: () {
                // Twitter sign in logic
                _signInWithTwitter(context);
              },
            ),
            SizedBox(height: 8.0),
            SocialSignInButton(
              assetName: 'images/mail-logo.png',
              text: 'Sign in with Email',
              textColor: Colors.white,
              color: Colors.deepOrangeAccent,
              onPressed: () {
                _signInWithEmailAndPassword(context);
              },
            ),
            SizedBox(height: 8.0),
            Text(
              'or',
              style: TextStyle(fontSize: 14.0, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            SignInButton(
              text: '匿名アカウントで始める',
              textColor: Colors.black,
              color: Colors.lime[300],
              onPressed: () => _signInAnonymously(),
            ),
          ],
        ),
      );
}
