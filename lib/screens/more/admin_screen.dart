import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/app_user.dart';
import '../../providers/auth_provider.dart';
import '../../services/user_service.dart';
import '../../theme.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUid = context.read<AuthProvider>().currentUser?.uid;
    final userService = UserService();

    return Scaffold(
      appBar: AppBar(title: const Text('Manage Members')),
      body: StreamBuilder<List<AppUser>>(
        stream: userService.watchAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final users = snapshot.data ?? [];
          if (users.isEmpty) {
            return const Center(
                child: Text('No members yet.',
                    style: TextStyle(color: Colors.grey)));
          }
          return ListView.separated(
            itemCount: users.length,
            separatorBuilder: (context, i) =>
                const Divider(height: 1, indent: 16),
            itemBuilder: (context, i) {
              final user = users[i];
              final isCurrentUser = user.uid == currentUid;
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: user.isLeader
                      ? AppTheme.primary
                      : Colors.grey.shade300,
                  child: Text(
                    user.displayName.isNotEmpty
                        ? user.displayName[0].toUpperCase()
                        : '?',
                    style: TextStyle(
                      color:
                          user.isLeader ? Colors.white : Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  user.displayName,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(user.email,
                    style: const TextStyle(fontSize: 12)),
                trailing: isCurrentUser
                    ? const Chip(
                        label: Text('You',
                            style: TextStyle(fontSize: 11)),
                        padding: EdgeInsets.zero,
                      )
                    : _RoleChip(
                        user: user,
                        onToggle: () => _toggleRole(
                            context, userService, user),
                      ),
              );
            },
          );
        },
      ),
    );
  }

  void _toggleRole(
      BuildContext context, UserService userService, AppUser user) {
    final newRole = user.isLeader ? 'member' : 'leader';
    final action = user.isLeader ? 'Remove leader access from' : 'Make';
    final roleLabel = user.isLeader ? 'member' : 'leader';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('$action ${user.displayName}?'),
        content: Text(
            'This will change their role to $roleLabel.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              userService.setUserRole(user.uid, newRole);
              Navigator.pop(context);
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}

class _RoleChip extends StatelessWidget {
  final AppUser user;
  final VoidCallback onToggle;

  const _RoleChip({required this.user, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: user.isLeader
              ? AppTheme.primary.withValues(alpha: 0.1)
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: user.isLeader ? AppTheme.primary : Colors.grey.shade300,
          ),
        ),
        child: Text(
          user.isLeader ? 'Leader ✓' : 'Member',
          style: TextStyle(
            fontSize: 12,
            color: user.isLeader ? AppTheme.primary : Colors.grey,
            fontWeight: user.isLeader ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
