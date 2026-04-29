import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final String displayName;
  final String email;
  final String role;
  final DateTime createdAt;

  const AppUser({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.role,
    required this.createdAt,
  });

  bool get isLeader => role == 'leader';

  factory AppUser.fromMap(String uid, Map<String, dynamic> data) {
    return AppUser(
      uid: uid,
      displayName: data['displayName'] as String,
      email: data['email'] as String,
      role: data['role'] as String? ?? 'member',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() => {
        'displayName': displayName,
        'email': email,
        'role': role,
        'createdAt': Timestamp.fromDate(createdAt),
      };
}
