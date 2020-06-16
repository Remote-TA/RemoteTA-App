import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class User {
  final String uid;
  final FirebaseUser userFromFirebase;

  const User({
    @required this.uid,
    @required this.userFromFirebase
  });
}

class FirebaseAuthService {
  final CollectionReference users = Firestore.instance.collection('users');
  final _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    return user == null ? null : User(uid: user.uid, userFromFirebase: user);
  }

  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final result = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirebase(result.user);
  }

  Future<User> createUserWithEmailAndPassword(String email, String password) async {
    final result = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirebase(result.user);
  }

  Future<void> sendPasswordResetEmail(String email) async {
    return await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<DocumentSnapshot> getUserDocumentSnapshot(String uid) async {
    try {
      return await users.document(uid).get();
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  String convertFirebaseErrorToMessage(String errorCode) {
    switch(errorCode) {
      case "ERROR_WRONG_PASSWORD":
        return "Your password is wrong.";
        break;
      case "ERROR_USER_NOT_FOUND":
        return "User with this email doesn't exist.";
        break;
      case "ERROR_USER_DISABLED":
         return "User with this email has been disabled.";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        return "Too many requests.Try again later.";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        return "Signing in with Email and Password is not enabled.";
        break;
      default:
        return "An undefined Error happened.";
    }
  }
}