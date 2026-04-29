import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants.dart';
import '../../providers/auth_provider.dart';
import '../../theme.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  Future<void> _launchEmail(String email) async {
    final uri = Uri.parse('mailto:$email');
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('More')),
      body: ListView(
        children: [
          // Ministries
          const _SectionHeader(label: 'MINISTRIES'),
          ...AppConstants.ministries.map((m) => ListTile(
                leading: Text(m.emoji,
                    style: const TextStyle(fontSize: 22)),
                title: Text(m.name,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(m.leader,
                    style: const TextStyle(
                        color: AppTheme.primary, fontSize: 12)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showMinistryDetail(context, m),
              )),

          const Divider(),

          // Giving
          const _SectionHeader(label: 'GIVING'),
          ListTile(
            leading:
                const Icon(Icons.credit_card, color: AppTheme.primary),
            title: const Text('Give Online (Vanco)'),
            subtitle: const Text('One-time or recurring'),
            trailing: const Icon(Icons.open_in_new, size: 18),
            onTap: () => _launch(AppConstants.vancoUrl),
          ),
          ListTile(
            leading: const Icon(Icons.send, color: AppTheme.primary),
            title: const Text('Give via Zelle'),
            subtitle: Text(AppConstants.zelleEmail,
                style: const TextStyle(fontSize: 12)),
            trailing: const Icon(Icons.open_in_new, size: 18),
            onTap: () => _launchEmail(AppConstants.zelleEmail),
          ),

          const Divider(),

          // Contact
          const _SectionHeader(label: 'CONTACT'),
          ListTile(
            leading: const Icon(Icons.email_outlined,
                color: AppTheme.primary),
            title: const Text('Email Us'),
            subtitle: const Text(AppConstants.churchEmail),
            trailing: const Icon(Icons.open_in_new, size: 18),
            onTap: () => _launchEmail(AppConstants.churchEmail),
          ),
          ListTile(
            leading: const Icon(Icons.location_on_outlined,
                color: AppTheme.primary),
            title: const Text('Address'),
            subtitle: const Text(
              AppConstants.churchAddress,
              style: TextStyle(fontSize: 12),
            ),
            trailing:
                const Icon(Icons.directions, color: AppTheme.primary),
            onTap: () => _launch(AppConstants.mapsUrl),
          ),

          const Divider(),

          // Account
          const _SectionHeader(label: 'ACCOUNT'),
          if (auth.isLoggedIn) ...[
            ListTile(
              leading: const Icon(Icons.person_outline,
                  color: AppTheme.primary),
              title: Text(auth.currentUser!.displayName),
              subtitle: Text(auth.currentUser!.email),
            ),
            if (auth.isLeader)
              const ListTile(
                leading: Icon(Icons.star, color: AppTheme.accent),
                title: Text('Church Leader',
                    style: TextStyle(color: AppTheme.primary)),
              ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Sign Out',
                  style: TextStyle(color: Colors.red)),
              onTap: () => auth.signOut(),
            ),
          ] else
            ListTile(
              leading:
                  const Icon(Icons.login, color: AppTheme.primary),
              title: const Text('Sign In'),
              onTap: () => auth.signOut(),
            ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _showMinistryDetail(BuildContext context, Ministry ministry) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(ministry.emoji,
                    style: const TextStyle(fontSize: 32)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ministry.name,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primary),
                      ),
                      Text(
                        'Led by ${ministry.leader}',
                        style: const TextStyle(
                            color: Colors.grey, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(ministry.description,
                style: const TextStyle(height: 1.5)),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String label;
  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        label,
        style: const TextStyle(
            fontSize: 11,
            color: AppTheme.primary,
            letterSpacing: 1,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
