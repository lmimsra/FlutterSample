import 'package:flutter/material.dart';
import 'package:privante/components/mail_password_form.dart';
import 'package:privante/services/auth.dart';

class MailSignInScreen extends StatelessWidget {
  MailSignInScreen(this._auth);
  final Auth _auth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
        elevation: 2.0,
      ),
      body: Card(child: MailPasswordForm(auth: _auth)),
      backgroundColor: Colors.grey[200],
    );
  }
}
