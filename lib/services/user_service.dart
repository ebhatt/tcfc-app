import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/app_user.dart';

class UserService {
  final FirebaseFirestore _firestore;

  UserService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<List<AppUser>> watchAllUsers() {
    return _firestore
        .collection('users')
        .orderBy('displayName')
        .snapshots()
        .map((snap) =>
            snap.docs.map((d) => AppUser.fromMap(d.id, d.data())).toList());
  }

  Future<void> setUserRole(String uid, String role) {
    return _firestore.collection('users').doc(uid).update({'role': role});
  }
}
