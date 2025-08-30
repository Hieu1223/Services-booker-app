import 'package:flutter/material.dart';
import 'package:home_fix/views/manage_profile_page.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
        children: [
          // Header for the settings page
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Settings & Account',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Sub-heading/description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Manage your profiles and account settings.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Entry to open the new Manage Profiles page
          _SettingEntry(
            icon: Icons.account_circle_outlined,
            title: 'Manage Profiles',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ManageProfilesPage()),
              );
            },
          ),
          // Log In is the only other visible option
          _SettingEntry(
            icon: Icons.login_outlined,
            title: 'Log In',
            onTap: () {
              // TODO: Implement login functionality
            },
          ),
        ],
      ),
    );
  }
}

// Helper widget for creating a setting entry styled like a service entry
class _SettingEntry extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _SettingEntry({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: theme.colorScheme.outline.withOpacity(0.5)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Icon(icon, color: theme.colorScheme.primary),
        title: Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}