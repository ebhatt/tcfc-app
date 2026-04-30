import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/event.dart';

class EventService {
  final FirebaseFirestore _firestore;

  EventService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<List<Event>> watchEvents() {
    return _firestore
        .collection('events')
        .orderBy('date')
        .snapshots()
        .map((snap) => snap.docs.map(Event.fromDoc).toList());
  }

  Stream<List<Event>> watchUpcomingEvents({int limit = 3}) {
    final startOfToday = DateTime.now();
    final cutoff = DateTime(startOfToday.year, startOfToday.month, startOfToday.day);
    return _firestore
        .collection('events')
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(cutoff))
        .orderBy('date')
        .limit(limit)
        .snapshots()
        .map((snap) => snap.docs.map(Event.fromDoc).toList());
  }

  Future<void> addEvent(Event event, {required String createdBy}) {
    final map = event.toMap();
    map['createdBy'] = createdBy;
    map['createdAt'] = Timestamp.fromDate(DateTime.now());
    return _firestore.collection('events').add(map);
  }

  Future<void> updateEvent(String eventId, Event event) {
    final map = event.toMap();
    if (event.endDate == null) map['endDate'] = FieldValue.delete();
    if (event.endTime == null) map['endTime'] = FieldValue.delete();
    return _firestore.collection('events').doc(eventId).update(map);
  }

  Future<void> deleteEvent(String eventId) {
    return _firestore.collection('events').doc(eventId).delete();
  }
}
