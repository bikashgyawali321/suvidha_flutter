import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suvidha/models/service_model/service_array_response.dart';
import 'package:suvidha/extensions.dart';
import 'package:suvidha/screens/home/orders/add_order_bottom_sheet.dart';
import '../../../providers/service_provider.dart';

class ServiceProvidersScreen extends StatelessWidget {
  const ServiceProvidersScreen({super.key, required this.serviceName});
  final String serviceName;

  @override
  Widget build(BuildContext context) {
    final serviceProvider = context.read<ServiceProvider>();
    final isRecommendedServiceProvider =
        serviceProvider.isRecommendedServiceProvider();
    List<DocsService> services = serviceProvider.services
        .where((element) => element.serviceName.name == serviceName)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Providers for $serviceName'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Explore the list of providers offering $serviceName and choose one to place your order request.",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),

              // Display the recommended services first
              ...services.map((service) {
                return Card(
                  child: ListTile(
                    title: Text(service.org.organizationName),
                    subtitle: Text(service.price.toCurrency),
                    trailing: isRecommendedServiceProvider
                        ? Text('Recommended')
                        : null,
                    onTap: () => AddOrderBottomSheet.show(
                      serviceNameId: service.id,
                      context: context,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
