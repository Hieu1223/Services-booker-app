class UserProfileModel {
  final String id;
  final String name;
  final String address;
  final String phoneNumber;

  UserProfileModel({
    required this.id,
    required this.name,
    required this.address,
    required this.phoneNumber,
  });
  @override
  String toString() {
    return 'UserProfileModel(id: $id, name: $name, address: $address, phoneNumber: $phoneNumber)';
  }
}
