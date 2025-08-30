import 'dart:async';
import 'package:home_fix/models/user_profile_model.dart';

class UserProfileRepo {
  // In-memory store to simulate a database
  final List<UserProfileModel> _profiles = [];
  int _nextId = 0; // Simple counter for unique IDs

  // --- Singleton Pattern with Lazy Initialization ---
  // Private constructor

  // The single, static instance
  static UserProfileRepo?_instance;

  static Future<UserProfileRepo> getInstance() async{
    if(_instance == null){
      _instance = UserProfileRepo();
      await _instance!._init();
      return _instance!;
    }
    return _instance!;
  }
  // --- End Singleton Pattern ---

  // Private initializer
  Future<void> _init() async {
    // Simulate initial data loading from a database or network
    await Future.delayed(const Duration(milliseconds: 300));
    _profiles.addAll([
      UserProfileModel(
        id: (_nextId++).toString(),
        name: 'John Doe',
        address: '123 Main St, Anytown, USA',
        phoneNumber: '555-123-4567',
      ),
      UserProfileModel(
        id: (_nextId++).toString(),
        name: 'Jane Smith',
        address: '456 Oak Ave, Sometown, USA',
        phoneNumber: '555-987-6543',
      ),
    ]);
    
  }

  /// Fetches all user profiles.
  Future<List<UserProfileModel>> getProfiles() async {
    // Simulate network delay for the fetch operation
    await Future.delayed(const Duration(milliseconds: 500));
    final res = List<UserProfileModel>.unmodifiable(_profiles);
    return res;
  }

  /// Adds a new user profile.
  /// A unique ID is generated for the new profile.
  Future<UserProfileModel> addProfile({
    required String name,
    required String address,
    required String phoneNumber,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final newProfile = UserProfileModel(
      id: (_nextId++).toString(),
      name: name,
      address: address,
      phoneNumber: phoneNumber,
    );
    _profiles.add(newProfile);
    return newProfile;
  }

  /// Removes a user profile by its ID.
  Future<void> removeProfile(String profileId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _profiles.removeWhere((profile) => profile.id == profileId);
  }
    Future<void> reorderProfiles(int oldIndex, int newIndex) async {
    await Future.delayed(const Duration(milliseconds: 200));

    if (oldIndex < 0 || oldIndex >= _profiles.length) return;
    if (newIndex < 0 || newIndex > _profiles.length) return;

    // Adjust index if moving down the list
    if (newIndex > oldIndex) newIndex -= 1;

    final moved = _profiles.removeAt(oldIndex);
    _profiles.insert(newIndex, moved);
  }
}