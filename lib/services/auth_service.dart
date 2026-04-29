import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/app_user.dart';

class AuthService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthService({FirebaseAuth? auth, FirebaseFirestore? firestore})
      : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<AppUser> signUp({
    required String displayName,
    required String email,
    required String password,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final uid = credential.user!.uid;
    final now = DateTime.now();
    final appUser = AppUser(
      uid: uid,
      displayName: displayName,
      email: email,
      role: 'member',
      createdAt: now,
    );
    await _firestore.collection('users').doc(uid).set(appUser.toMap());
    return appUser;
  }

  Future<AppUser?> getCurrentUser() async {
    final firebaseUser = _auth.currentUser;
    if (firebaseUser == null) return null;
    final doc =
        await _firestore.collection('users').doc(firebaseUser.uid).get();
    if (!doc.exists) return null;
    return AppUser.fromMap(firebaseUser.uid, doc.data()!);
  }
}
