import 'package:flutter/material.dart';
import '../../services/prayer_service.dart';
import '../../theme.dart';

class SubmitPrayerScreen extends StatefulWidget {
  final String authorName;
  final String authorUid;

  const SubmitPrayerScreen({
    super.key,
    required this.authorName,
    required this.authorUid,
  });

  @override
  State<SubmitPrayerScreen> createState() => _SubmitPrayerScreenState();
}

class _SubmitPrayerScreenState extends State<SubmitPrayerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _textCtrl = TextEditingController();
  String _recipient = 'prayer_ministry';
  bool _loading = false;
  final _prayerService = PrayerService();

  @override
  void dispose() {
    _textCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    await _prayerService.submitRequest(
      text: _textCtrl.text.trim(),
      authorName: widget.authorName,
      authorUid: widget.authorUid,
      recipient: _recipient,
    );
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Prayer Request')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _textCtrl,
                decoration: const InputDecoration(
                  labelText: 'Your prayer request',
                  alignLabelWithHint: true,
                ),
                maxLines: 6,
                validator: (v) =>
                    v == null || v.trim().isEmpty
                        ? 'Please enter your request'
                        : null,
              ),
              const SizedBox(height: 24),
              const Text(
                'SEND TO',
                style: TextStyle(
                    fontSize: 11,
                    color: AppTheme.primary,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              _VisibilityOption(
                value: 'prayer_ministry',
                groupValue: _recipient,
                icon: Icons.volunteer_activism,
                title: 'Prayer Ministry',
                subtitle: 'Christina Choppala · Shared with the prayer team',
                onChanged: (v) => setState(() => _recipient = v!),
              ),
              const SizedBox(height: 8),
              _VisibilityOption(
                value: 'private',
                groupValue: _recipient,
                icon: Icons.lock_outline,
                title: 'Pastor',
                subtitle: 'Rev. Rufus Bhimanapalli · Private and confidential',
                onChanged: (v) => setState(() => _recipient = v!),
              ),
              const SizedBox(height: 32),
              _loading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _submit,
                      child: const Text('Submit Request'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VisibilityOption extends StatelessWidget {
  final String value;
  final String groupValue;
  final IconData icon;
  final String title;
  final String subtitle;
  final ValueChanged<String?> onChanged;

  const _VisibilityOption({
    required this.value,
    required this.groupValue,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final selected = value == groupValue;
    return InkWell(
      onTap: () => onChanged(value),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? AppTheme.primary : AppTheme.cardBorder,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected ? AppTheme.primary : Colors.grey,
            ),
            const SizedBox(width: 4),
            Icon(icon,
                color: selected ? AppTheme.primary : Colors.grey,
                size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: selected ? AppTheme.primary : Colors.black),
                  ),
                  Text(subtitle,
                      style: const TextStyle(
                          fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
