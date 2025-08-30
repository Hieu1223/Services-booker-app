import 'package:flutter/material.dart';
import 'package:home_fix/view_models/add_profile_view_model.dart';
import 'package:provider/provider.dart';

class AddProfilePage extends StatelessWidget {
  final AddProfileViewModel?vm;
  const AddProfilePage({super.key, this.vm});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => vm== null? AddProfileViewModel(): vm!,
      child: const _AddProfileView(),
    );
  }
}

class _AddProfileView extends StatefulWidget {
  const _AddProfileView();

  @override
  State<_AddProfileView> createState() => _AddProfileViewState();
}

class _AddProfileViewState extends State<_AddProfileView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final vm = context.read<AddProfileViewModel>();
    final newProfile = await vm.saveProfile(
      name: _nameController.text,
      address: _addressController.text,
      phoneNumber: _phoneController.text,
    );

    if (mounted && newProfile != null) {
      // Pop the page and return the new profile to the previous screen
      Navigator.of(context).pop(newProfile);
    } else if (mounted) {
      // Handle error case
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save profile.')),
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AddProfileViewModel>().isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter an address' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a phone number' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: isLoading ? null : _saveProfile,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(strokeWidth: 3),
                      )
                    : const Text('Save Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}