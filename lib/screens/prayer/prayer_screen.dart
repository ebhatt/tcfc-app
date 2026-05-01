import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/prayer_request.dart';
import '../../providers/auth_provider.dart';
import '../../services/prayer_service.dart';
import '../../theme.dart';
import '../../widgets/prayer_card.dart';
import 'submit_prayer_screen.dart';

class PrayerScreen extends StatelessWidget {
  const PrayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final isPastor = auth.isPastor;
    final isPrayerMinistry = auth.isPrayerMinistry;
    final prayerService = PrayerService();
    final uid = auth.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text(isPastor
            ? 'Prayer Inbox — Pastor'
            : isPrayerMinistry
                ? 'Prayer Inbox — Prayer Ministry'
                : 'Prayer'),
      ),
      body: (isPastor || isPrayerMinistry)
          ? _RequestList(
              stream: isPastor
                  ? prayerService.watchPastorRequests()
                  : prayerService.watchPrayerMinistryRequests(),
              uid: uid,
              prayerService: prayerService,
            )
          : _SubmitPrompt(isLoggedIn: auth.isLoggedIn),
      floatingActionButton: auth.isLoggedIn
          ? FloatingActionButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SubmitPrayerScreen(
                    authorName: auth.currentUser!.displayName,
                    authorUid: auth.currentUser!.uid,
                  ),
                ),
              ),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

class _SubmitPrompt extends StatelessWidget {
  final bool isLoggedIn;
  const _SubmitPrompt({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.volunteer_activism,
                size: 48, color: AppTheme.primary),
            const SizedBox(height: 16),
            const Text(
              'Submit a Prayer Request',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primary),
            ),
            const SizedBox(height: 12),
            const Text(
              'Your request will be sent privately to our Pastor or Prayer Ministry team.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, height: 1.5),
            ),
            if (!isLoggedIn) ...[
              const SizedBox(height: 12),
              const Text(
                'Sign in to submit a request.',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _RequestList extends StatelessWidget {
  final Stream<List<PrayerRequest>> stream;
  final String? uid;
  final PrayerService prayerService;

  const _RequestList({
    required this.stream,
    required this.uid,
    required this.prayerService,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PrayerRequest>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final requests = snapshot.data ?? [];
        if (requests.isEmpty) {
          return const Center(
            child: Text('No prayer requests yet.',
                style: TextStyle(color: Colors.grey)),
          );
        }
        return ListView.builder(
          itemCount: requests.length,
          itemBuilder: (context, i) {
            final req = requests[i];
            final isPraying =
                uid != null && req.prayingUids.contains(uid);
            return PrayerCard(
              request: req,
              isPraying: isPraying,
              canPray: uid != null,
              onTogglePraying: () =>
                  prayerService.togglePraying(req.id, uid!, !isPraying),
            );
          },
        );
      },
    );
  }
}
