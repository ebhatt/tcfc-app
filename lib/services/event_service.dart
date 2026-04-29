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

  Future<void> addEvent(Event event, {required String createdBy}) {
    final map = event.toMap();
    map['createdBy'] = createdBy;
    map['createdAt'] = Timestamp.fromDate(DateTime.now());
    return _firestore.collection('events').add(map);
  }

  Future<void> deleteEvent(String eventId) {
    return _firestore.collection('events').doc(eventId).delete();
  }
}
