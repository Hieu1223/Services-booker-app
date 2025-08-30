import 'package:flutter/material.dart';
import 'package:home_fix/view_models/manage_profile_view_model.dart';
import 'package:provider/provider.dart';

class ManageProfilesPage extends StatelessWidget {
  const ManageProfilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ManageProfilesViewModel(),
      child: const _ManageProfilesView(),
    );
  }
}

class _ManageProfilesView extends StatelessWidget {
  const _ManageProfilesView();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ManageProfilesViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Profiles"),
      ),
      body: FutureBuilder(
        future: vm.loadSuccess,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting || snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (vm.profiles.isEmpty) {
            return const Center(child: Text("No profiles added yet"));
          }

          return ReorderableListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: vm.profiles.length,
            onReorder: (oldIndex, newIndex) async {
              await vm.reorderProfiles(oldIndex, newIndex);
            },
            itemBuilder: (context, index) {
              final profile = vm.profiles[index];
              return ReorderableDragStartListener(
                key: ValueKey(profile.id),
                index: index,
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    title: Text(
                      profile.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(profile.address),
                        Text(profile.phoneNumber),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.redAccent,
                          ),
                          onPressed: () => vm.deleteProfile(profile.id),
                        ),
                        const SizedBox(width: 12), // pushes delete button further
                        const Icon(Icons.drag_handle), // drag handle
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => vm.showAddUserProfilePage(context),
        icon: const Icon(Icons.add),
        label: const Text("Add Profile"),
      ),
    );
  }
}
