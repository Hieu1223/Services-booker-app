import 'package:flutter/material.dart';
import 'package:home_fix/models/service_model.dart';
import 'package:home_fix/repos/service_repo.dart';

class ServicePageViewModel extends ChangeNotifier{
  late Future<bool> loadSuccess;
  List<ServiceModel> services = [];
  ServicePageViewModel(){
    loadSuccess = loadServices();
  }
  Future<bool> loadServices() async {
    final repoInstance = await ServiceRepo.getInstance();
    services =  await repoInstance.getServices();
    return true;
  }
}