import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference users = Firestore.instance.collection("users");

  Future<void> updateUserData(
      {String uid, String email, String fullName, String type}) async {
    return await users.document(uid).setData(
      {'uid': uid, 'fullName': fullName, 'email': email, 'type': type},
    );
  }

  Future<DocumentSnapshot> getUserDocumentSnapshot(String uid) async {
    return await users.document(uid).get();
  }
}
