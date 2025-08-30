import 'package:flutter/material.dart';
import 'package:home_fix/views/services_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final content = ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
          child: Text(
            'Welcome to HomeFix',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          'Your reliable partner for home repairs and maintenance. What can we help you with today?',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 32),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: theme.colorScheme.outline.withOpacity(0.5)),
          ),
          child: InkWell(
            onTap: () {
              // Switch to the 'Services' tab instead of pushing a new page
              DefaultTabController.of(context).animateTo(1);
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Icon(
                    Icons.handyman_outlined,
                    size: 40,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Book a Service',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Browse our list of available services.',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        ListTile(
          leading: const Icon(Icons.history_outlined),
          title: const Text('View Booking History'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 14),
          onTap: () {
            // TODO: Implement navigation to booking history page
          },
        ),
        ListTile(
          leading: const Icon(Icons.support_agent_outlined),
          title: const Text('Contact Support'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 14),
          onTap: () {
            // TODO: Implement navigation to support page
          },
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: content,
    );
  }
}