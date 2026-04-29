import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tcfc_app/models/event.dart';

void main() {
  group('Event', () {
    late FakeFirebaseFirestore fakeFirestore;

    setUp(() {
      fakeFirestore = FakeFirebaseFirestore();
    });

    test('fromDoc parses all fields', () async {
      final date = DateTime(2026, 5, 10, 10, 30);
      final now = DateTime(2026, 4, 29);
      await fakeFirestore.collection('events').doc('evt1').set({
        'title': 'Sunday Worship',
        'date': Timestamp.fromDate(date),
        'time': '10:30 AM',
        'description': 'Weekly worship service',
        'location': 'Ashburn VA',
        'createdBy': 'uid123',
        'createdAt': Timestamp.fromDate(now),
      });
      final doc =
          await fakeFirestore.collection('events').doc('evt1').get();
      final event = Event.fromDoc(doc);

      expect(event.id, 'evt1');
      expect(event.title, 'Sunday Worship');
      expect(event.time, '10:30 AM');
      expect(event.location, 'Ashburn VA');
    });

    test('toMap produces correct map', () {
      final date = DateTime(2026, 5, 10);
      final event = Event(
        id: 'evt1',
        title: 'Bible Study',
        date: date,
        time: '6:30 PM',
        description: 'Weekly study',
        location: 'Church hall',
        createdBy: 'uid123',
        createdAt: date,
      );
      final map = event.toMap();
      expect(map['title'], 'Bible Study');
      expect(map['time'], '6:30 PM');
      expect(map['description'], 'Weekly study');
    });
  });
}
