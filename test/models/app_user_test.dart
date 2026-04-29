import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tcfc_app/models/app_user.dart';

void main() {
  group('AppUser', () {
    final now = DateTime(2026, 4, 29, 12, 0);
    final map = {
      'displayName': 'John Doe',
      'email': 'john@test.com',
      'role': 'member',
      'createdAt': Timestamp.fromDate(now),
    };

    test('fromMap parses all fields', () {
      final user = AppUser.fromMap('uid123', map);
      expect(user.uid, 'uid123');
      expect(user.displayName, 'John Doe');
      expect(user.email, 'john@test.com');
      expect(user.role, 'member');
      expect(user.isLeader, false);
    });

    test('isLeader returns true when role is leader', () {
      final leaderMap = Map<String, dynamic>.from(map)..['role'] = 'leader';
      final user = AppUser.fromMap('uid456', leaderMap);
      expect(user.isLeader, true);
    });

    test('toMap produces correct map', () {
      final user = AppUser.fromMap('uid123', map);
      final result = user.toMap();
      expect(result['displayName'], 'John Doe');
      expect(result['email'], 'john@test.com');
      expect(result['role'], 'member');
    });

    test('role defaults to member when missing', () {
      final noRoleMap = Map<String, dynamic>.from(map)..remove('role');
      final user = AppUser.fromMap('uid789', noRoleMap);
      expect(user.role, 'member');
    });
  });
}
