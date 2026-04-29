import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/prayer_request.dart';
import '../../providers/auth_provider.dart';
import '../../services/prayer_service.dart';
import '../../widgets/prayer_card.dart';
import 'submit_prayer_screen.dart';

class PrayerScreen extends StatefulWidget {
  const PrayerScreen({super.key});

  @override
  State<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen>
    with SingleTickerProviderStateMixin {
  final _prayerService = PrayerService();
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final isLeader = auth.isLeader;
    final uid = auth.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prayer Requests'),
        bottom: isLeader
            ? TabBar(
                controller: _tabController,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white60,
                indicatorColor: Colors.white,
                tabs: const [
                  Tab(text: 'Congregation'),
                  Tab(text: 'Private'),
                ],
              )
            : null,
      ),
      body: isLeader
          ? TabBarView(
              controller: _tabController,
              children: [
                _RequestList(
                    stream: _prayerService.watchPublicRequests(),
                    uid: uid,
                    prayerService: _prayerService,
                    canPray: auth.isLoggedIn),
                _RequestList(
                    stream: _prayerService.watchPrivateRequests(),
                    uid: uid,
                    prayerService: _prayerService,
                    canPray: false),
              ],
            )
          : _RequestList(
              stream: _prayerService.watchPublicRequests(),
              uid: uid,
              prayerService: _prayerService,
              canPray: auth.isLoggedIn),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!auth.isLoggedIn) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Sign in to submit a prayer request')));
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SubmitPrayerScreen(
                authorName: auth.currentUser!.displayName,
                authorUid: auth.currentUser!.uid,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _RequestList extends StatelessWidget {
  final Stream<List<PrayerRequest>> stream;
  final String? uid;
  final PrayerService prayerService;
  final bool canPray;

  const _RequestList({
    required this.stream,
    required this.uid,
    required this.prayerService,
    required this.canPray,
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
              canPray: canPray,
              onTogglePraying: () =>
                  prayerService.togglePraying(req.id, uid!, !isPraying),
            );
          },
        );
      },
    );
  }
}
