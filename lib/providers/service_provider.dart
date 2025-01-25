import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suvidha/models/service_model/service_array_response.dart';
import 'package:suvidha/services/backend_service.dart';

class ServiceProvider extends ChangeNotifier {
  late BackendService _backendService;

  ServiceProvider(this.context) {
    initialize();
  }

  final BuildContext context;
  void initialize() {
    _backendService = Provider.of<BackendService>(context, listen: false);
    getAllServices();
    getRecommendedServices();
  }

  bool loading = false;

  List<DocsService> services = [];
  ServiceArrayResponse? serviceArrayResponse;
  List<DocsService> recommendedServices = [];

  // get all services provided to the users
  Future<void> getAllServices() async {
    loading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    final response = await _backendService.getAllServices();
    if (response.statusCode == 200 &&
        response.result != null &&
        response.result!.isNotEmpty) {
      ServiceArrayResponse serviceArrayResponse =
          ServiceArrayResponse.fromJson(response.result!);
      serviceArrayResponse.docs.isNotEmpty
          ? services = serviceArrayResponse.docs
          : services = [];
      loading = false;
      notifyListeners();
    } else {
      services = [];
      loading = false;
      notifyListeners();
    }
  }

  //get recommended services
  Future<void> getRecommendedServices() async {
    loading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    final response = await _backendService.getRecommendedServices();
    if (response.statusCode == 200 &&
        response.result != null &&
        response.result!.isNotEmpty) {
      ServiceArrayResponse serviceArrayResponse =
          ServiceArrayResponse.fromJson(response.result!);
      serviceArrayResponse.docs.isNotEmpty
          ? recommendedServices = serviceArrayResponse.docs
          : recommendedServices = [];
      loading = false;
      notifyListeners();
    } else {
      recommendedServices = [];
      loading = false;
      notifyListeners();
    }
  }
}
