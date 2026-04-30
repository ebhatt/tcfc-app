import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants.dart'; // provides AppConstants and ScheduleItem
import '../../models/event.dart';
import '../../services/event_service.dart';
import '../../theme.dart';
import '../events/event_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final eventService = EventService();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Header ───────────────────────────────────────
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primary, AppTheme.accent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 28),
              child: Column(
                children: [
                  // Logo — transparent PNG on gold gradient
                  Image.asset(
                    'assets/images/tcfc_logo.png',
                    height: 90,
                  ),
                  const SizedBox(height: 16),
                  // Full name on one line
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      AppConstants.churchFullName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Ashburn, Virginia',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),

            // ── Schedule (fixed recurring) ────────────────────
            const _SectionLabel(text: 'SCHEDULE'),
            SizedBox(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: AppConstants.schedule.length,
                separatorBuilder: (context, i) =>
                    const SizedBox(width: 10),
                itemBuilder: (context, i) =>
                    _ScheduleItemCard(item: AppConstants.schedule[i]),
              ),
            ),
            const SizedBox(height: 12),
            const Divider(height: 1),

            // ── Upcoming Events (from calendar) ───────────────
            StreamBuilder<List<Event>>(
              stream: eventService.watchUpcomingEvents(limit: 5),
              builder: (context, snapshot) {
                final events = snapshot.data ?? [];
                if (events.isEmpty) return const SizedBox.shrink();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _SectionLabel(text: 'UPCOMING EVENTS'),
                    SizedBox(
                      height: 130,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: events.length,
                        separatorBuilder: (context, i) =>
                            const SizedBox(width: 10),
                        itemBuilder: (context, i) => _ScheduleCard(
                          event: events[i],
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    EventDetailScreen(event: events[i])),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Divider(height: 1),
                  ],
                );
              },
            ),

            // ── Sunday Service ────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 4,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppTheme.primary,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'SUNDAY WORSHIP',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: AppTheme.primary,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 2),
                              Text(
                                AppConstants.serviceTime,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                AppConstants.serviceMode,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () =>
                                  _launch(AppConstants.youtubeUrl),
                              icon: const Icon(Icons.play_circle_outline),
                              label: const Text('Watch Live'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () =>
                                  _launch(AppConstants.mapsUrl),
                              icon: const Icon(Icons.directions_outlined),
                              label: const Text('Directions'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ── Year Promise ──────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.primary.withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: AppTheme.primary.withValues(alpha: 0.2)),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.auto_awesome,
                            color: AppTheme.accent, size: 15),
                        const SizedBox(width: 6),
                        Text(
                          AppConstants.promiseYear.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 11,
                              color: AppTheme.primary,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      AppConstants.promiseTheme,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primary),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      AppConstants.promiseText,
                      style: const TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        height: 1.65,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '— ${AppConstants.promiseVerse}',
                      style: const TextStyle(
                        color: AppTheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Follow Us ─────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 4, bottom: 8),
                    child: Text(
                      'FOLLOW US',
                      style: TextStyle(
                          fontSize: 11,
                          color: AppTheme.primary,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Row(
                    children: [
                      _SocialButton(
                          label: 'Facebook',
                          icon: Icons.facebook,
                          onTap: () => _launch(AppConstants.facebookUrl)),
                      const SizedBox(width: 8),
                      _SocialButton(
                          label: 'Instagram',
                          icon: Icons.camera_alt_outlined,
                          onTap: () =>
                              _launch(AppConstants.instagramUrl)),
                      const SizedBox(width: 8),
                      _SocialButton(
                          label: 'YouTube',
                          icon: Icons.play_circle_outline,
                          onTap: () => _launch(AppConstants.youtubeUrl)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 11,
            color: AppTheme.primary,
            letterSpacing: 1,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _ScheduleItemCard extends StatelessWidget {
  final ScheduleItem item;
  const _ScheduleItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              color: AppTheme.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Text(
              item.emoji,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        height: 1.3),
                  ),
                  const Spacer(),
                  Text(
                    item.timing,
                    style: const TextStyle(
                        fontSize: 10, color: AppTheme.primary),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScheduleCard extends StatelessWidget {
  final Event event;
  final VoidCallback onTap;
  const _ScheduleCard({required this.event, required this.onTap});

  static const _months = [
    'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
    'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.cardBorder),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Date header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                color: AppTheme.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    event.date.day.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        height: 1),
                  ),
                  Text(
                    _months[event.date.month - 1],
                    style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                        letterSpacing: 1),
                  ),
                ],
              ),
            ),
            // Event info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          height: 1.3),
                    ),
                    const Spacer(),
                    Text(
                      event.time,
                      style: const TextStyle(
                          fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _SocialButton(
      {required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.cardBorder),
          ),
          child: Column(
            children: [
              Icon(icon, color: AppTheme.primary),
              const SizedBox(height: 4),
              Text(label,
                  style: const TextStyle(
                      fontSize: 11, color: AppTheme.primary)),
            ],
          ),
        ),
      ),
    );
  }
}
