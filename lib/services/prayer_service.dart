import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/prayer_request.dart';

class PrayerService {
  final FirebaseFirestore _firestore;

  PrayerService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<List<PrayerRequest>> watchPublicRequests() {
    return _firestore
        .collection('prayerRequests')
        .where('visibility', isEqualTo: 'public')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map(PrayerRequest.fromDoc).toList());
  }

  Stream<List<PrayerRequest>> watchPrivateRequests() {
    return _firestore
        .collection('prayerRequests')
        .where('visibility', isEqualTo: 'private')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map(PrayerRequest.fromDoc).toList());
  }

  Future<void> submitRequest({
    required String text,
    required String authorName,
    required String authorUid,
    required String visibility,
  }) {
    return _firestore.collection('prayerRequests').add({
      'text': text,
      'authorName': authorName,
      'authorUid': authorUid,
      'visibility': visibility,
      'prayingCount': 0,
      'prayingUids': [],
      'timestamp': Timestamp.fromDate(DateTime.now()),
    });
  }

  Future<void> togglePraying(
      String requestId, String uid, bool isPraying) {
    final doc =
        _firestore.collection('prayerRequests').doc(requestId);
    if (isPraying) {
      return doc.update({
        'prayingUids': FieldValue.arrayUnion([uid]),
        'prayingCount': FieldValue.increment(1),
      });
    } else {
      return doc.update({
        'prayingUids': FieldValue.arrayRemove([uid]),
        'prayingCount': FieldValue.increment(-1),
      });
    }
  }
}
