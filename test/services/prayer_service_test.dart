import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tcfc_app/services/prayer_service.dart';

void main() {
  group('PrayerService', () {
    late FakeFirebaseFirestore fakeFirestore;
    late PrayerService prayerService;

    setUp(() {
      fakeFirestore = FakeFirebaseFirestore();
      prayerService = PrayerService(firestore: fakeFirestore);
    });

    test('submitRequest saves public request to Firestore', () async {
      await prayerService.submitRequest(
        text: 'Pray for my family.',
        authorName: 'John',
        authorUid: 'uid123',
        visibility: 'public',
      );
      final docs =
          await fakeFirestore.collection('prayerRequests').get();
      expect(docs.docs.length, 1);
      final data = docs.docs.first.data();
      expect(data['text'], 'Pray for my family.');
      expect(data['visibility'], 'public');
      expect(data['prayingCount'], 0);
    });

    test('watchPublicRequests only emits public requests', () async {
      await prayerService.submitRequest(
        text: 'Public prayer.',
        authorName: 'John',
        authorUid: 'uid1',
        visibility: 'public',
      );
      await prayerService.submitRequest(
        text: 'Private prayer.',
        authorName: 'Jane',
        authorUid: 'uid2',
        visibility: 'private',
      );

      final requests = await prayerService.watchPublicRequests().first;
      expect(requests.length, 1);
      expect(requests.first.text, 'Public prayer.');
    });

    test('togglePraying adds uid and increments count', () async {
      await prayerService.submitRequest(
        text: 'Prayer.',
        authorName: 'John',
        authorUid: 'uid1',
        visibility: 'public',
      );
      final doc =
          (await fakeFirestore.collection('prayerRequests').get())
              .docs
              .first;
      final id = doc.id;

      await prayerService.togglePraying(id, 'uid999', true);
      final updated =
          await fakeFirestore.collection('prayerRequests').doc(id).get();
      expect(updated.data()!['prayingCount'], 1);
      expect(
          (updated.data()!['prayingUids'] as List).contains('uid999'), true);
    });
  });
}
