import 'package:home_fix/models/service_model.dart';
import 'package:home_fix/models/user_profile_model.dart';

class ServiceFormModel {
  final ServiceModel service;
  final String date;
  final String time;
  final UserProfileModel profile;
  ServiceFormModel({required this.service,required this.date,required this.time,required this.profile});
  @override
  String toString() {
    return 'ServiceFormModel(service: $service, date: $date, time: $time, profile: $profile)';
  }
}