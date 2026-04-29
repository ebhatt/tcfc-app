import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/event.dart';
import '../../services/event_service.dart';
import '../../theme.dart';

class AddEventScreen extends StatefulWidget {
  final String createdBy;
  const AddEventScreen({super.key, required this.createdBy});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _timeCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  DateTime? _selectedDate;
  bool _loading = false;
  final _eventService = EventService();

  @override
  void dispose() {
    _titleCtrl.dispose();
    _timeCtrl.dispose();
    _locationCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme:
              const ColorScheme.light(primary: AppTheme.primary),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a date')));
      return;
    }
    setState(() => _loading = true);
    final event = Event(
      id: '',
      title: _titleCtrl.text.trim(),
      date: _selectedDate!,
      time: _timeCtrl.text.trim(),
      description: _descCtrl.text.trim(),
      location: _locationCtrl.text.trim(),
      createdBy: widget.createdBy,
      createdAt: DateTime.now(),
    );
    await _eventService.addEvent(event, createdBy: widget.createdBy);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Event')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleCtrl,
                decoration:
                    const InputDecoration(labelText: 'Event Title'),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Enter a title' : null,
              ),
              const SizedBox(height: 16),
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
              TextFormField(
                controller: _timeCtrl,
                decoration: const InputDecoration(
                    labelText: 'Time (e.g. 10:30 AM)'),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Enter a time' : null,
              ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 24),
              _loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _submit,
                      child: const Text('Save Event'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
