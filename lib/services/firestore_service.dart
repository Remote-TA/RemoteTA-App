import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FirestoreService {
  final CollectionReference users = Firestore.instance.collection("users");

  Future<void> updateStudentUserData(
      {@required String uid,
      @required String email,
      @required String firstName,
      @required String lastName,
      @required String grade,
      @required List activeProjects,
      @required List pendingProjects,
      @required Map<String, String> reviewProjects,
      @required String userType}) async {
    return await users.document(uid).setData(
      {
        'uid': uid,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'grade': grade,
        'activeProjects': activeProjects,
        'reviewProjects': reviewProjects,
        'pendingProjects': pendingProjects,
        'userType': userType
      },
    );
  }

  Future<void> updateUserData(
      {String uid, String email, String fullName, String userType}) async {
    return await users.document(uid).setData(
      {'uid': uid, 'fullName': fullName, 'email': email, 'userType': userType},
    );
  }

  Future<DocumentSnapshot> getUserDocumentSnapshot(String uid) async {
    return await users.document(uid).get();
  }
}
