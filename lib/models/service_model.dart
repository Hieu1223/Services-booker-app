class ServiceModel {
  final String id;
  final String name;
  final String description;
  const ServiceModel({required this.id,required this.name, required this.description});
  @override
  String toString() {
    return 'ServiceModel(id: $id, name: $name, description: $description)';
  }
}