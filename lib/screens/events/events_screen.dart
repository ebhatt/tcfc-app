import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../models/event.dart';
import '../../providers/auth_provider.dart';
import '../../services/event_service.dart';
import '../../theme.dart';
import '../../widgets/event_card.dart';
import 'add_event_screen.dart';
import 'event_detail_screen.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final _eventService = EventService();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  List<Event> _eventsForDay(List<Event> all, DateTime day) {
    return all.where((e) => isSameDay(e.date, day)).toList();
  }

  List<Event> _filteredEvents(List<Event> all) {
    if (_selectedDay == null) return all;
    return _eventsForDay(all, _selectedDay!);
  }

  @override
  Widget build(BuildContext context) {
    final isLeader = context.watch<AuthProvider>().isLeader;
    final currentUser = context.watch<AuthProvider>().currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Events')),
      body: StreamBuilder<List<Event>>(
        stream: _eventService.watchEvents(),
        builder: (context, snapshot) {
          final allEvents = snapshot.data ?? [];
          final filtered = _filteredEvents(allEvents);

          return Column(
            children: [
              TableCalendar<Event>(
                firstDay: DateTime(2024),
                lastDay: DateTime(2030),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) =>
                    isSameDay(_selectedDay, day),
                eventLoader: (day) => _eventsForDay(allEvents, day),
                calendarStyle: CalendarStyle(
                  selectedDecoration: const BoxDecoration(
                      color: AppTheme.primary, shape: BoxShape.circle),
                  todayDecoration: BoxDecoration(
                      color: AppTheme.accent.withValues(alpha: 0.4),
                      shape: BoxShape.circle),
                  markerDecoration: const BoxDecoration(
                      color: AppTheme.primary, shape: BoxShape.circle),
                ),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                onDaySelected: (selected, focused) {
                  setState(() {
                    _selectedDay = isSameDay(_selectedDay, selected)
                        ? null
                        : selected;
                    _focusedDay = focused;
                  });
                },
                onPageChanged: (focused) =>
                    setState(() => _focusedDay = focused),
              ),
              const Divider(height: 1),
              Expanded(
                child: filtered.isEmpty
                    ? Center(
                        child: Text(
                          _selectedDay != null
                              ? 'No events on this day'
                              : 'No upcoming events',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filtered.length,
                        itemBuilder: (context, i) {
                          final event = filtered[i];
                          return EventCard(
                            event: event,
                            isLeader: isLeader,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    EventDetailScreen(event: event),
                              ),
                            ),
                            onDelete: () =>
                                _eventService.deleteEvent(event.id),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: isLeader
          ? FloatingActionButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      AddEventScreen(createdBy: currentUser!.uid),
                ),
              ),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
