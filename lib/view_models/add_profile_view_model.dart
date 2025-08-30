import 'package:flutter/material.dart';
import 'package:home_fix/models/user_profile_model.dart';
import 'package:home_fix/repos/user_profile_repo.dart';

class AddProfileViewModel extends ChangeNotifier {
  // The repo is now loaded asynchronously.
  // We don't need to hold an instance here.
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  /// Saves a new profile and returns the created model.
  /// Returns null if the operation fails.
  Future<UserProfileModel?> saveProfile({
    required String name,
    required String address,
    required String phoneNumber,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Get the initialized repo instance
      final repo = await UserProfileRepo.getInstance();
      final newProfile = await repo.addProfile(
        name: name,
        address: address,
        phoneNumber: phoneNumber,
      );
      return newProfile;
    } catch (e) {
      // In a real app, you would handle errors more gracefully
      debugPrint("Error saving profile: $e");
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}