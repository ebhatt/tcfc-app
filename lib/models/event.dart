import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String id;
  final String title;
  final DateTime date;
  final String time;
  final DateTime? endDate;
  final String? endTime;
  final String description;
  final String location;
  final String createdBy;
  final DateTime createdAt;

  const Event({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    this.endDate,
    this.endTime,
    required this.description,
    required this.location,
    required this.createdBy,
    required this.createdAt,
  });

  factory Event.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Event(
      id: doc.id,
      title: data['title'] as String,
      date: (data['date'] as Timestamp).toDate(),
      time: data['time'] as String,
      endDate: data['endDate'] != null
          ? (data['endDate'] as Timestamp).toDate()
          : null,
      endTime: data['endTime'] as String?,
      description: data['description'] as String,
      location: data['location'] as String,
      createdBy: data['createdBy'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'title': title,
      'date': Timestamp.fromDate(date),
      'time': time,
      'description': description,
      'location': location,
      'createdBy': createdBy,
      'createdAt': Timestamp.fromDate(createdAt),
    };
    if (endDate != null) map['endDate'] = Timestamp.fromDate(endDate!);
    if (endTime != null) map['endTime'] = endTime;
    return map;
  }
}
