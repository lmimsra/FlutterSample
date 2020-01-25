import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:privante/components/sign_in_button.dart';
import 'package:privante/components/social_sign_in_button.dart';
import 'package:privante/pages/auth/mail_sign_in.dart';
import 'package:privante/pages/auth/twitter_sign_in.dart';
import 'package:privante/services/auth.dart';
import 'package:privante/utils/twitter/twitter_oauth.dart';

// ignore: must_be_immutable
class SignInScreen extends StatelessWidget {
  SignInScreen({@required this.onSignIn});

  Function(FirebaseUser) onSignIn;
  final Auth _auth = Auth();

//  匿名ユーザーのログイン処理
  Future<void> _signInAnonymously() async {
    try {
      final authResult = await FirebaseAuth.instance.signInAnonymously();
      onSignIn(authResult.user);
    } catch (e) {
      print(e.toString());
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
              fullscreenDialog: true));
      if (user != null) {
        onSignIn(user);
      }
    } catch (e) {
      print(e.toString());
      // エラー表示の処理追加
    }
  }

  // Twitterログイン処理
  Future<void> _signInWithTwitter(BuildContext context) async {
    try {
      TwitterOauth _twitterOauth = TwitterOauth(
        apiKey: DotEnv().env['TWITTER_API_KEY'],
        apiSecretKey: DotEnv().env['TWITTER_API_SECRET'],
        callbackUri: DotEnv().env['TWITTER_REDIRECT_URI'],
      );

      FirebaseUser user = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TwitterWebView(_auth),
              // モーダル表示
              fullscreenDialog: true));
      if (user != null) {
        onSignIn(user);
      }

      print('user is null');
    } catch (e) {
      print(e.toString());
      // エラー表示の処理追加
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('privante'),
      ),
      body: _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context) => Padding(
        padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'サインイン',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 48.0,
            ),
            SocialSignInButton(
              assetName: 'images/google-logo.png',
              text: 'Sign in with Google',
              textColor: Colors.black87,
              color: Colors.white,
              onPressed: () {},
            ),
            SizedBox(height: 8.0),
            SocialSignInButton(
              assetName: 'images/facebook-logo.png',
              text: 'Sign in with Facebook',
              textColor: Colors.white,
              color: Color(0xFF334D92),
              onPressed: () {},
            ),
            SizedBox(height: 8.0),
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
            SignInButton(
              text: 'Sign in with email',
              textColor: Colors.white,
              color: Colors.teal[700],
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
