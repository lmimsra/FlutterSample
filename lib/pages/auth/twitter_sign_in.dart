import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:privante/utils/twitter/twitter_oauth.dart';
import 'package:webview_flutter/webview_flutter.dart';

//class TwitterOauthPage extends StatefulWidget {
//  const TwitterOauthPage({Key key}) : super(key: key);
//
//  @override
//  _TwitterOauthPageState createState() => _TwitterOauthPageState();
//}
//
//class _TwitterOauthPageState extends State<TwitterOauthPage> {
//  TwitterOauth _twitterOauth;
//
//  @override
//  void initState() {
//    super.initState();
//    _twitterOauth = TwitterOauth(
//      apiKey: DotEnv().env['TWITTER_API_KEY'],
//      apiSecretKey: DotEnv().env['TWITTER_API_SECRET'],
//      callbackUri: DotEnv().env['TWITTER_REDIRECT_URI'],
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: const Text('Sign In With Twitter'),
//      ),
//      body: Center(
//        child: RaisedButton(
//          child: const Text('Sign In With Twitter.'),
//          onPressed: () async {
//            final String authorizeUri = await _twitterOauth.getAuthorizeUri();
//            Navigator.of(context).pushReplacement<Widget, Widget>(
//              MaterialPageRoute<Widget>(
//                builder: (BuildContext context) {
//                  return TwitterWebView(
////                    uri: authorizeUri,
//                  );
//                },
//              ),
//            );
//          },
//        ),
//      ),
//    );
//  }
//}

// ignore: must_be_immutable
class TwitterWebView extends StatelessWidget {
  TwitterWebView(this._twitterOauth);

  final TwitterOauth _twitterOauth;

  Future<String> _getAuthUri() async {
    return await _twitterOauth.getAuthorizeUri();
  }

  @override
  Widget build(BuildContext context) {
    print('開いた');
    return Scaffold(
        appBar: AppBar(title: Text('twitter login'),),
        body: FutureBuilder(
            future: _getAuthUri(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (!snapshot.hasData) {
                print('グルグル');
                return CircularProgressIndicator();
              }
              print('webview表示');
              print(snapshot.data);

              return WebView(
                // ここ変更
                initialUrl: snapshot.data,
                javascriptMode: JavascriptMode.unrestricted,
                navigationDelegate: (NavigationRequest request) {
                  print('delegate : ${request.url}');
                  if (request.url
                      .startsWith(DotEnv().env['TWITTER_REDIRECT_URI'])) {
                    // クエリストリングを取得
                    final String query = request.url.split('?').last;
                    if (query.contains('denied')) {
                      /// Cancel
                      print('cancel');
                      Navigator.pop(context, null);
                      // 重複pop対策
                    } else {
                      print('ok');
                      final Map<String, String> res =
                          Uri.splitQueryString(query);
                      _twitterSignin(res).then((FirebaseUser user) {
                        /// Navigato to Main Page
                        Navigator.pop(context, user);
                        // 重複pop対策
                        return Future.value(false);
                      });
                    }
                  }
                  // ここは検討
                  print('if 一番した');
                  return NavigationDecision.navigate;
                },
              );
            }));
  }

  Future<FirebaseUser> _twitterSignin(Map<String, String> token) async {
    final Map<String, String> oauthToken =
        await _twitterOauth.getAccessToken(token);
    final AuthCredential credential = TwitterAuthProvider.getCredential(
      authToken: oauthToken['oauth_token'],
      authTokenSecret: oauthToken['oauth_token_secret'],
    );
    final AuthResult result =
        await FirebaseAuth.instance.signInWithCredential(credential);
    return result.user;
  }
}
