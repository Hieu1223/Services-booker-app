import 'package:home_fix/models/service_model.dart';

class ServiceRepo {
  List<ServiceModel> testList = [
      ServiceModel(
        id: 'plumbing',
        name: 'Plumbing Services',
        description: 'Leaky faucets, clogged drains, pipe installation, and water heater repairs.',
      ),
      ServiceModel(
        id: 'electrical',
        name: 'Electrical Work',
        description: 'Fixture installation, outlet repairs, wiring issues, and circuit breaker problems.',
      ),
      ServiceModel(
        id: 'hvac',
        name: 'HVAC Maintenance',
        description: 'Heating, ventilation, and air conditioning tune-ups, repairs, and installation.',
      ),
      ServiceModel(
        id: 'painting',
        name: 'Interior & Exterior Painting',
        description: 'Give your home a fresh look with our professional painting services.',
      ),
      ServiceModel(
        id: 'carpentry',
        name: 'Carpentry',
        description: 'Custom shelves, furniture assembly, deck repairs, and trim installation.',
      ),
      ServiceModel(
        id: 'appliance',
        name: 'Appliance Repair',
        description: 'Fixing washers, dryers, refrigerators, ovens, and other household appliances.',
      ),
      ServiceModel(
        id: 'landscaping',
        name: 'Lawn & Garden Care',
        description: 'Lawn mowing, garden design, and seasonal yard cleanup services.',
      ),
    ];



  static ServiceRepo? _instance;
  static Future<ServiceRepo> getInstance() async{
    if(_instance == null){
      _instance = ServiceRepo();
      await _instance!.init();
      return _instance!;
    }
    return _instance!;
  }
  Future<void> init() async{

  }
  /// Fetches a list of available services.
  /// In a real application, this would make a network request.
  Future<List<ServiceModel>> getServices() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Return a mock list of services
    return testList;
  }
  
}