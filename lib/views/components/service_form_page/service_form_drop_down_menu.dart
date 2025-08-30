import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:home_fix/models/service_model.dart';
import 'package:home_fix/view_models/service_form_view_model.dart';




class ServiceDropDownMenu extends StatelessWidget {
  final TextEditingController controller;
  final ServiceModel service; // starting value

  const ServiceDropDownMenu({super.key, required this.service, required this.controller});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ServiceFormViewModel>();
    vm.currentService = service;
    return FutureBuilder(
      future: vm.serviceLoadSuccess,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const LinearProgressIndicator();
        }

        return SizedBox(
          width: double.infinity, // 👈 make it stretch full width
          child: DropdownMenu<ServiceModel>(
            label: const Text("Service"),
            controller: controller,
            onSelected: (value) {
              vm.currentService = value;
            },
            width: double.infinity, // 👈 also set width inside
            dropdownMenuEntries: vm.services.map((e) {
              return DropdownMenuEntry<ServiceModel>(
                value: e,
                label: e.name,
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
