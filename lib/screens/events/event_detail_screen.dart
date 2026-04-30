import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/event.dart';
import '../../providers/auth_provider.dart';
import '../../theme.dart';
import 'add_event_screen.dart';

class EventDetailScreen extends StatelessWidget {
  final Event event;

  const EventDetailScreen({super.key, required this.event});

  String _dateRangeStr(Event e) {
    final start = DateFormat('EEEE, MMMM d, y').format(e.date);
    if (e.endDate == null) return start;
    // Same year — omit year from start date
    final startShort = DateFormat('EEEE, MMMM d').format(e.date);
    final end = DateFormat('EEEE, MMMM d, y').format(e.endDate!);
    return '$startShort – $end';
  }

  String _timeRangeStr(Event e) {
    if (e.endTime == null) return e.time;
    return '${e.time} – ${e.endTime}';
  }

  @override
  Widget build(BuildContext context) {
    final isLeader = context.watch<AuthProvider>().isLeader;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
        actions: [
          if (isLeader)
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddEventScreen(event: event),
                ),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.title,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primary),
            ),
            const SizedBox(height: 20),
            _DetailRow(
                icon: Icons.calendar_today, text: _dateRangeStr(event)),
            _DetailRow(
                icon: Icons.access_time, text: _timeRangeStr(event)),
            _DetailRow(icon: Icons.location_on, text: event.location),
            if (event.description.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text(
                'About',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppTheme.primary),
              ),
              const SizedBox(height: 8),
              Text(event.description,
                  style: const TextStyle(height: 1.5)),
            ],
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _DetailRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Icon(icon, color: AppTheme.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
