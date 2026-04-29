import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tcfc_app/models/event.dart';
import 'package:tcfc_app/services/event_service.dart';

void main() {
  group('EventService', () {
    late FakeFirebaseFirestore fakeFirestore;
    late EventService eventService;

    setUp(() {
      fakeFirestore = FakeFirebaseFirestore();
      eventService = EventService(firestore: fakeFirestore);
    });

    Future<Event> makeEvent(String title, DateTime date) async {
      final event = Event(
        id: '',
        title: title,
        date: date,
        time: '10:30 AM',
        description: 'Test event',
        location: 'Ashburn VA',
        createdBy: 'uid123',
        createdAt: DateTime(2026, 4, 29),
      );
      await eventService.addEvent(event, createdBy: 'uid123');
      final docs = await fakeFirestore.collection('events').get();
      return Event.fromDoc(docs.docs.last);
    }

    test('addEvent saves document to Firestore', () async {
      final event = await makeEvent('Sunday Worship', DateTime(2026, 5, 10));
      expect(event.title, 'Sunday Worship');
      expect(event.time, '10:30 AM');
    });

    test('watchEvents emits events ordered by date', () async {
      await makeEvent('Event B', DateTime(2026, 5, 20));
      await makeEvent('Event A', DateTime(2026, 5, 10));

      final events = await eventService.watchEvents().first;
      expect(events.length, 2);
      expect(events[0].title, 'Event A');
      expect(events[1].title, 'Event B');
    });

    test('deleteEvent removes document from Firestore', () async {
      final event = await makeEvent('To Delete', DateTime(2026, 5, 15));
      await eventService.deleteEvent(event.id);
      final docs = await fakeFirestore.collection('events').get();
      expect(docs.docs, isEmpty);
    });
  });
}
