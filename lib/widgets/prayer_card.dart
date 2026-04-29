import 'package:flutter/material.dart';
import '../models/prayer_request.dart';
import '../theme.dart';

class PrayerCard extends StatelessWidget {
  final PrayerRequest request;
  final bool isPraying;
  final bool canPray;
  final VoidCallback onTogglePraying;

  const PrayerCard({
    super.key,
    required this.request,
    required this.isPraying,
    required this.canPray,
    required this.onTogglePraying,
  });

  @override
  Widget build(BuildContext context) {
    final timeAgo = _timeAgo(request.timestamp);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  request.authorName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: AppTheme.primary),
                ),
                Text(
                  timeAgo,
                  style:
                      const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(request.text, style: const TextStyle(height: 1.4)),
            const SizedBox(height: 10),
            InkWell(
              onTap: canPray ? onTogglePraying : null,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isPraying
                      ? AppTheme.primary.withValues(alpha: 0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color:
                        isPraying ? AppTheme.primary : AppTheme.cardBorder,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('🙏',
                        style:
                            TextStyle(fontSize: isPraying ? 16 : 14)),
                    const SizedBox(width: 4),
                    Text(
                      '${request.prayingCount} praying',
                      style: TextStyle(
                          fontSize: 12,
                          color:
                              isPraying ? AppTheme.primary : Colors.grey,
                          fontWeight: isPraying
                              ? FontWeight.bold
                              : FontWeight.normal),
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

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    return '${diff.inMinutes}m ago';
  }
}
