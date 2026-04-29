import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tcfc_app/services/auth_service.dart';

void main() {
  group('AuthService', () {
    late MockFirebaseAuth mockAuth;
    late FakeFirebaseFirestore fakeFirestore;
    late AuthService authService;

    setUp(() {
      mockAuth = MockFirebaseAuth();
      fakeFirestore = FakeFirebaseFirestore();
      authService = AuthService(auth: mockAuth, firestore: fakeFirestore);
    });

    test('signUp creates Firestore user document with member role', () async {
      await authService.signUp(
        displayName: 'Jane Doe',
        email: 'jane@test.com',
        password: 'password123',
      );
      final users = await fakeFirestore.collection('users').get();
      expect(users.docs.length, 1);
      final data = users.docs.first.data();
      expect(data['displayName'], 'Jane Doe');
      expect(data['email'], 'jane@test.com');
      expect(data['role'], 'member');
    });

    test('getCurrentUser returns null when not signed in', () async {
      final user = await authService.getCurrentUser();
      expect(user, isNull);
    });

    test('getCurrentUser returns AppUser after signUp', () async {
      await authService.signUp(
        displayName: 'Jane Doe',
        email: 'jane@test.com',
        password: 'password123',
      );
      final user = await authService.getCurrentUser();
      expect(user, isNotNull);
      expect(user!.displayName, 'Jane Doe');
      expect(user.role, 'member');
      expect(user.isLeader, false);
    });
  });
}
