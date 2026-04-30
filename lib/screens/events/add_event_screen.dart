import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/event.dart';
import '../../services/event_service.dart';
import '../../theme.dart';

class AddEventScreen extends StatefulWidget {
  final String? createdBy;
  final Event? event;

  const AddEventScreen({
    super.key,
    this.createdBy,
    this.event,
  }) : assert(event != null || createdBy != null);

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  DateTime? _selectedEndDate;
  TimeOfDay? _selectedEndTime;
  bool _loading = false;
  final _eventService = EventService();

  @override
  void initState() {
    super.initState();
    final e = widget.event;
    if (e != null) {
      _titleCtrl.text = e.title;
      _locationCtrl.text = e.location;
      _descCtrl.text = e.description;
      _selectedDate = e.date;
      _selectedTime = _parseTime(e.time);
      _selectedEndDate = e.endDate;
      if (e.endTime != null) _selectedEndTime = _parseTime(e.endTime!);
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _locationCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  TimeOfDay? _parseTime(String timeStr) {
    try {
      final parts = timeStr.trim().split(' ');
      final timeParts = parts[0].split(':');
      int hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);
      if (parts.length > 1) {
        final isPM = parts[1].toUpperCase() == 'PM';
        if (isPM && hour != 12) hour += 12;
        if (!isPM && hour == 12) hour = 0;
      }
      return TimeOfDay(hour: hour, minute: minute);
    } catch (_) {
      return null;
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now.add(const Duration(days: 1)),
      firstDate: widget.event != null ? DateTime(2020) : now,
      lastDate: DateTime(2030),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: AppTheme.primary),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        // If end date is now before start, reset it
        if (_selectedEndDate != null &&
            _selectedEndDate!.isBefore(picked)) {
          _selectedEndDate = null;
          _selectedEndTime = null;
        }
      });
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: AppTheme.primary),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _selectedTime = picked);
  }

  Future<void> _pickEndDate() async {
    final minDate = _selectedDate ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedEndDate != null &&
              !_selectedEndDate!.isBefore(minDate)
          ? _selectedEndDate!
          : minDate,
      firstDate: minDate,
      lastDate: DateTime(2030),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: AppTheme.primary),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _selectedEndDate = picked);
  }

  Future<void> _pickEndTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedEndTime ?? TimeOfDay.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: AppTheme.primary),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _selectedEndTime = picked);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a start date')));
      return;
    }
    if (_selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a start time')));
      return;
    }
    setState(() => _loading = true);
    final isEditing = widget.event != null;
    final event = Event(
      id: isEditing ? widget.event!.id : '',
      title: _titleCtrl.text.trim(),
      date: _selectedDate!,
      time: _formatTime(_selectedTime!),
      endDate: _selectedEndDate,
      endTime:
          _selectedEndTime != null ? _formatTime(_selectedEndTime!) : null,
      description: _descCtrl.text.trim(),
      location: _locationCtrl.text.trim(),
      createdBy:
          isEditing ? widget.event!.createdBy : widget.createdBy!,
      createdAt:
          isEditing ? widget.event!.createdAt : DateTime.now(),
    );
    if (isEditing) {
      await _eventService.updateEvent(widget.event!.id, event);
    } else {
      await _eventService.addEvent(event, createdBy: widget.createdBy!);
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.event != null;
    return Scaffold(
      appBar: AppBar(
          title: Text(isEditing ? 'Edit Event' : 'Add Event')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleCtrl,
                decoration:
                    const InputDecoration(labelText: 'Event Title'),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Enter a title' : null,
              ),
              const SizedBox(height: 24),

              // ── Start ──────────────────────────────────────
              _SectionLabel(label: _selectedEndDate != null ? 'START' : 'DATE & TIME'),
              const SizedBox(height: 8),
              InkWell(
                onTap: _pickDate,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Date',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(
                    _selectedDate == null
                        ? 'Select date'
                        : DateFormat('MMMM d, y').format(_selectedDate!),
                    style: TextStyle(
                        color: _selectedDate == null
                            ? Colors.grey
                            : Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: _pickTime,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Time',
                    prefixIcon: Icon(Icons.access_time),
                  ),
                  child: Text(
                    _selectedTime == null
                        ? 'Select time'
                        : _formatTime(_selectedTime!),
                    style: TextStyle(
                        color: _selectedTime == null
                            ? Colors.grey
                            : Colors.black),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ── End ────────────────────────────────────────
              const _SectionLabel(label: 'END (OPTIONAL)'),
              const SizedBox(height: 8),
              InkWell(
                onTap: _pickEndDate,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'End Date',
                    prefixIcon: const Icon(Icons.event),
                    suffixIcon: _selectedEndDate != null
                        ? IconButton(
                            icon: const Icon(Icons.clear,
                                size: 18, color: Colors.grey),
                            onPressed: () => setState(() {
                              _selectedEndDate = null;
                              _selectedEndTime = null;
                            }),
                          )
                        : null,
                  ),
                  child: Text(
                    _selectedEndDate == null
                        ? 'Not set'
                        : DateFormat('MMMM d, y').format(_selectedEndDate!),
                    style: TextStyle(
                        color: _selectedEndDate == null
                            ? Colors.grey
                            : Colors.black),
                  ),
                ),
              ),
              if (_selectedEndDate != null) ...[
                const SizedBox(height: 16),
                InkWell(
                  onTap: _pickEndTime,
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'End Time',
                      prefixIcon: const Icon(Icons.access_time_outlined),
                      suffixIcon: _selectedEndTime != null
                          ? IconButton(
                              icon: const Icon(Icons.clear,
                                  size: 18, color: Colors.grey),
                              onPressed: () =>
                                  setState(() => _selectedEndTime = null),
                            )
                          : null,
                    ),
                    child: Text(
                      _selectedEndTime == null
                          ? 'Not set'
                          : _formatTime(_selectedEndTime!),
                      style: TextStyle(
                          color: _selectedEndTime == null
                              ? Colors.grey
                              : Colors.black),
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 24),

              // ── Details ────────────────────────────────────
              const _SectionLabel(label: 'DETAILS'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _locationCtrl,
                decoration:
                    const InputDecoration(labelText: 'Location'),
                validator: (v) =>
                    v == null || v.trim().isEmpty
                        ? 'Enter a location'
                        : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descCtrl,
                decoration:
                    const InputDecoration(labelText: 'Description'),
                maxLines: 4,
              ),
              const SizedBox(height: 28),
              _loading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _submit,
                      child: Text(
                          isEditing ? 'Update Event' : 'Save Event'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
          fontSize: 11,
          color: AppTheme.primary,
          letterSpacing: 1,
          fontWeight: FontWeight.w600),
    );
  }
}
