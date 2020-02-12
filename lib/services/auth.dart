import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:privante/utils/twitter/twitter_oauth.dart';

abstract class AuthBase {}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;
  final _twitterOauth = TwitterOauth(
    apiKey: DotEnv().env['TWITTER_API_KEY'],
    apiSecretKey: DotEnv().env['TWITTER_API_SECRET'],
    callbackUri: DotEnv().env['TWITTER_REDIRECT_URI'],
  );

  // 現在のユーザー取得
  Future<FirebaseUser> currentUser() async {
    return await _firebaseAuth.currentUser();
  }

  // 匿名ログイン
  Future<FirebaseUser> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return authResult.user;
  }

  // Twitter ログイン
  Future<FirebaseUser> signInWithTwitter(Map<String, String> token) async {
    final Map<String, String> oauthToken =
        await _twitterOauth.getAccessToken(token);
    final AuthCredential credential = TwitterAuthProvider.getCredential(
      authToken: oauthToken['oauth_token'],
      authTokenSecret: oauthToken['oauth_token_secret'],
    );
    final AuthResult result =
        await _firebaseAuth.signInWithCredential(credential);
    return result.user;
  }

  // Twitter ログインURL取得
  Future<String> getTwitterAuthUrl() async {
    return await _twitterOauth.getAuthorizeUri();
  }

  // Twitter コールバックURL取得
  String getTwitterCallbackUrl() {
    return _twitterOauth.callbackUri;
  }

  // email login
  Future<FirebaseUser> signInWithEmail(
      {
        @required String email,
        @required String password
      }) async {
    AuthResult authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return authResult.user;
  }

  // email create account
  Future<FirebaseUser> createWithEmail(
      {
        @required String email,
        @required String password
      }) async {
    AuthResult authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return authResult.user;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
