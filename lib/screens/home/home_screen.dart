import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants.dart';
import '../../theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header banner
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primary, AppTheme.accent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.fromLTRB(24, 64, 24, 32),
              child: const Column(
                children: [
                  Text(
                    '✦ TELUGU CHRISTIAN ✦',
                    style: TextStyle(
                        color: Colors.white70, letterSpacing: 2, fontSize: 12),
                  ),
                  SizedBox(height: 8),
                  Text(
                    AppConstants.churchShortName,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    AppConstants.churchTagline,
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),

            // Service card
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
                                    fontSize: 18, fontWeight: FontWeight.bold),
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
                              onPressed: () => _launch(AppConstants.youtubeUrl),
                              icon: const Icon(Icons.play_circle_outline),
                              label: const Text('Watch Live'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => _launch(AppConstants.mapsUrl),
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

            // Address card
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Card(
                child: ListTile(
                  leading:
                      const Icon(Icons.location_on, color: AppTheme.primary),
                  title: const Text(
                    AppConstants.churchAddress,
                    style: TextStyle(fontSize: 13),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _launch(AppConstants.mapsUrl),
                ),
              ),
            ),

            // Contact card
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.email_outlined,
                      color: AppTheme.primary),
                  title: const Text(AppConstants.churchEmail),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () =>
                      _launch('mailto:${AppConstants.churchEmail}'),
                ),
              ),
            ),

            // Social media
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
                          onTap: () => _launch(AppConstants.instagramUrl)),
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
