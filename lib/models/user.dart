
import 'package:firebase_auth/firebase_auth.dart';

class User{
  final FirebaseUser _firebaseUser;

  User(this._firebaseUser);

  FirebaseUser get firebaseUser => _firebaseUser;
}