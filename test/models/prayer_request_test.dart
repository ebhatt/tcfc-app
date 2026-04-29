import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tcfc_app/models/prayer_request.dart';

void main() {
  group('PrayerRequest', () {
    late FakeFirebaseFirestore fakeFirestore;

    setUp(() {
      fakeFirestore = FakeFirebaseFirestore();
    });

    test('fromDoc parses all fields', () async {
      final now = DateTime(2026, 4, 29);
      await fakeFirestore.collection('prayerRequests').doc('pr1').set({
        'text': 'Please pray for my family.',
        'authorName': 'Priya M.',
        'authorUid': 'uid123',
        'visibility': 'public',
        'prayingCount': 5,
        'prayingUids': ['uid456', 'uid789'],
        'timestamp': Timestamp.fromDate(now),
      });
      final doc =
          await fakeFirestore.collection('prayerRequests').doc('pr1').get();
      final req = PrayerRequest.fromDoc(doc);

      expect(req.id, 'pr1');
      expect(req.text, 'Please pray for my family.');
      expect(req.authorName, 'Priya M.');
      expect(req.visibility, 'public');
      expect(req.isPublic, true);
      expect(req.prayingCount, 5);
      expect(req.prayingUids, ['uid456', 'uid789']);
    });

    test('isPublic is false for private requests', () async {
      final now = DateTime(2026, 4, 29);
      await fakeFirestore.collection('prayerRequests').doc('pr2').set({
        'text': 'Private request',
        'authorName': 'John',
        'authorUid': 'uid111',
        'visibility': 'private',
        'prayingCount': 0,
        'prayingUids': [],
        'timestamp': Timestamp.fromDate(now),
      });
      final doc =
          await fakeFirestore.collection('prayerRequests').doc('pr2').get();
      final req = PrayerRequest.fromDoc(doc);
      expect(req.isPublic, false);
    });

    test('prayingUids defaults to empty list when missing', () async {
      await fakeFirestore.collection('prayerRequests').doc('pr3').set({
        'text': 'Test',
        'authorName': 'Test',
        'authorUid': 'uid',
        'visibility': 'public',
        'prayingCount': 0,
        'timestamp': Timestamp.fromDate(DateTime(2026, 4, 29)),
      });
      final doc =
          await fakeFirestore.collection('prayerRequests').doc('pr3').get();
      final req = PrayerRequest.fromDoc(doc);
      expect(req.prayingUids, isEmpty);
    });
  });
}
