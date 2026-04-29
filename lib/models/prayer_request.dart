import 'package:cloud_firestore/cloud_firestore.dart';

class PrayerRequest {
  final String id;
  final String text;
  final String authorName;
  final String authorUid;
  final String visibility;
  final int prayingCount;
  final List<String> prayingUids;
  final DateTime timestamp;

  const PrayerRequest({
    required this.id,
    required this.text,
    required this.authorName,
    required this.authorUid,
    required this.visibility,
    required this.prayingCount,
    required this.prayingUids,
    required this.timestamp,
  });

  bool get isPublic => visibility == 'public';

  factory PrayerRequest.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PrayerRequest(
      id: doc.id,
      text: data['text'] as String,
      authorName: data['authorName'] as String,
      authorUid: data['authorUid'] as String,
      visibility: data['visibility'] as String,
      prayingCount: data['prayingCount'] as int? ?? 0,
      prayingUids:
          List<String>.from(data['prayingUids'] as List? ?? const []),
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() => {
        'text': text,
        'authorName': authorName,
        'authorUid': authorUid,
        'visibility': visibility,
        'prayingCount': prayingCount,
        'prayingUids': prayingUids,
        'timestamp': Timestamp.fromDate(timestamp),
      };
}
