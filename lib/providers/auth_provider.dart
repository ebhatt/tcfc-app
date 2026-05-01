import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../constants.dart';
import '../models/app_user.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;

  AppUser? _currentUser;
  bool _loading = true;
  String? _error;

  AuthProvider(this._authService) {
    _authService.authStateChanges.listen(_onAuthStateChanged);
  }

  AppUser? get currentUser => _currentUser;
  bool get isLoading => _loading;
  bool get isLoggedIn => _currentUser != null;
  bool get isLeader => _currentUser?.isLeader ?? false;
  bool get isPastor =>
      _currentUser?.email == AppConstants.pastorEmail;
  bool get isPrayerMinistry =>
      _currentUser?.email == AppConstants.prayerMinistryEmail;
  String? get error => _error;

  Future<void> _onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _currentUser = null;
    } else {
      _currentUser = await _authService.getCurrentUser();
    }
    _loading = false;
    notifyListeners();
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    _error = null;
    try {
      await _authService.signIn(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      _error = _friendlyError(e.code);
      notifyListeners();
      rethrow;
    }
  }

  Future<void> signUp({
    required String displayName,
    required String email,
    required String password,
  }) async {
    _error = null;
    try {
      final user = await _authService.signUp(
        displayName: displayName,
        email: email,
        password: password,
      );
      _currentUser = user;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      _error = _friendlyError(e.code);
      notifyListeners();
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _currentUser = null;
    notifyListeners();
  }

  String _friendlyError(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No account found for this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'An account already exists for this email.';
      case 'weak-password':
        return 'Password must be at least 6 characters.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}
