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
    sortServices();
  }

  bool loading = false;

  List<DocsService> services = [];
  List<String>? serviceNames = [];

  List<String>? recommendedServiceNames = [];

  ServiceArrayResponse? serviceArrayResponse;
  List<DocsService> recommendedServices = [];

  //get serviceName id from service name
  String getServiceId(String serviceName) {
    for (final service in services) {
      if (service.serviceName.name == serviceName) {
        return service.serviceName.id;
      }
    }
    return '';
  }

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
      await getRecommendedServices();

      getServicesNames();
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
      getRecommendedServiceNames();
      notifyListeners();
    } else {
      recommendedServices = [];
      loading = false;
      notifyListeners();
    }
  }

  //fn to get all the service names as list, don't add the services names that are already in the list
  void getServicesNames() {
    for (int i = 0; i < services.length; i++) {
      if (!serviceNames!.contains(services[i].serviceName.name)) {
        serviceNames!.add(services[i].serviceName.name);
      }
    }
  }

  void getRecommendedServiceNames() {
    for (int i = 0; i < recommendedServices.length; i++) {
      if (!recommendedServiceNames!
          .contains(recommendedServices[i].serviceName.name)) {
        recommendedServiceNames!.add(
          recommendedServices[i].serviceName.name,
        );
      }
    }
  }

  bool isRecommendedService() {
    return serviceNames!.any((name) => recommendedServiceNames!.contains(name));
  }

  bool isRecommendedServiceProvider() {
    for (final service in services) {
      if (recommendedServices
          .any((recommended) => recommended.org.id == service.org.id)) {
        return true;
      }
    }
    return false;
  }

//sort recommended services first
  void sortServices() {
    services.sort((a, b) {
      if (recommendedServiceNames!.contains(a.serviceName.name) &&
          !recommendedServiceNames!.contains(b.serviceName.name)) {
        return -1;
      } else if (!recommendedServiceNames!.contains(a.serviceName.name) &&
          recommendedServiceNames!.contains(b.serviceName.name)) {
        return 1;
      } else {
        return 0;
      }
    });
  }
}
