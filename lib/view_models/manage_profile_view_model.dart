import 'package:flutter/material.dart';
import 'package:home_fix/models/user_profile_model.dart';
import 'package:home_fix/repos/user_profile_repo.dart';
import 'package:home_fix/views/common/add_profile.dart';

class ManageProfilesViewModel extends ChangeNotifier {
  List<UserProfileModel> _profiles = [];
  List<UserProfileModel> get profiles => _profiles;

  /// Exposed future for loading status
  Future<bool> loadSuccess = Future(() => false,);

  ManageProfilesViewModel() {
    loadSuccess = loadProfiles();
  }

  Future<bool> loadProfiles() async {
    final repo = await UserProfileRepo.getInstance();
    _profiles = await repo.getProfiles();
    return true;
  }

  Future<void> showAddUserProfilePage(BuildContext context) async {
    // Await for the user to potentially add a profile.
    await Navigator.push<UserProfileModel>(
      context,
      MaterialPageRoute(builder: (context) => const AddProfilePage()),
    );

    // Regardless of whether a profile was added or not, reload the list
    // to ensure the UI is in sync with the repository.
    await loadProfiles();
    notifyListeners();
  }

  Future<void> persistReorder(int oldIndex, int newIndex) async {
   
    final repo = await UserProfileRepo.getInstance();
    await repo.reorderProfiles(oldIndex,newIndex);
  }
  Future<void> deleteProfile(String profileId) async {
    final repo = await UserProfileRepo.getInstance();
    await repo.removeProfile(profileId);
    _profiles = await repo.getProfiles();
    notifyListeners();
  }

  Future<void> navigateToAddProfile(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddProfilePage()),
    );
    await loadProfiles(); // reload after adding
  }

  Future<void> reorderProfiles(int oldIndex, int newIndex) async {
    
    final repo = await UserProfileRepo.getInstance();
    await repo.reorderProfiles(oldIndex, newIndex);
    _profiles = await repo.getProfiles();
    notifyListeners();
  }
}
