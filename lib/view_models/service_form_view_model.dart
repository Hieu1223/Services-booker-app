import 'package:flutter/material.dart';
import 'package:home_fix/models/service_form_model.dart';
import 'package:home_fix/models/service_model.dart';
import 'package:home_fix/models/user_profile_model.dart';
import 'package:home_fix/repos/service_repo.dart';
import 'package:home_fix/repos/user_profile_repo.dart';
import 'package:home_fix/views/common/add_profile.dart';

class ServiceFormViewModel extends ChangeNotifier {
  UserProfileModel?activeProfile;
  List<UserProfileModel> userProfiles = [];
  late Future<bool> userProfileLoadSuccess;

  ServiceModel?currentService;
  List<ServiceModel> services = [];
  late Future<bool> serviceLoadSuccess;

  ServiceFormViewModel() {
    userProfileLoadSuccess = loadUserProfile();
    serviceLoadSuccess = loadServices();
  }

  Future<bool> send(ServiceFormModel form) async {
    print(form);
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
    await loadUserProfile();
    notifyListeners();
  }

  Future<bool> loadUserProfile() async {
    UserProfileRepo repo = await UserProfileRepo.getInstance();
    userProfiles = await repo.getProfiles();
    return true;
  }

  Future<bool> loadServices() async {
    final repoInstance = await ServiceRepo.getInstance();
    services =  await repoInstance.getServices();
    return true;
  }
}
