import 'package:flutter/material.dart';
import 'package:home_fix/models/service_model.dart';
import 'package:home_fix/view_models/service_page_view_model.dart';
import 'package:home_fix/views/service_form_page.dart';
import 'package:provider/provider.dart';





class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {


    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ServicePageViewModel())
      ],
      child: ServiceList(),
    );
  }
}

class ServiceList extends StatelessWidget {
  const ServiceList({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ServicePageViewModel>();
    final theme = Theme.of(context);

    return FutureBuilder(
      future: vm.loadSuccess,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting || snapshot.data == null) {
          // Use a centered spinner for a better loading experience
          return const Center(child: CircularProgressIndicator());
        }

        // Use a standard ListView to easily prepend a header
        return ListView(
          padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
          children: [
            // Main Heading
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Our Services',
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
                'Select a service below to schedule an appointment with one of our trusted professionals.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // List of service entries
            ...vm.services.map((service) {
              return ServiceEntry(
                service: service,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ServiceFormPage(service: service),
                    ),
                  );
                },
              );
            }).toList(),
          ],
        );
      },
    );
  }
}


class ServiceEntry extends StatelessWidget {
  final ServiceModel service;
  final VoidCallback? onPressed;
  const ServiceEntry({super.key, required this.service, this.onPressed});

  // Helper function to get an icon based on the service ID
  IconData _getIconForService(String serviceId) {
    switch (serviceId) {
      case 'plumbing':
        return Icons.plumbing_outlined;
      case 'electrical':
        return Icons.electrical_services_outlined;
      case 'hvac':
        return Icons.hvac_outlined;
      case 'painting':
        return Icons.format_paint_outlined;
      case 'carpentry':
        return Icons.carpenter_outlined;
      case 'appliance':
        return Icons.local_laundry_service_outlined;
      case 'landscaping':
        return Icons.grass_outlined;
      default:
        return Icons.handyman_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconData = _getIconForService(service.id);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: theme.colorScheme.outline.withOpacity(0.5)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
          child: Icon(
            iconData,
            color: theme.colorScheme.primary,
            size: 26,
          ),
        ),
        title: Text(
          service.name,
          style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            service.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onPressed,
      ),
    );
  }
}