import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suvidha/extensions.dart';
import 'package:suvidha/providers/service_provider.dart';
import 'package:suvidha/providers/theme_provider.dart';
import 'package:suvidha/screens/home/booking/add_booking.dart';
import 'package:suvidha/screens/home/orders/add_order_bottom_sheet.dart';
import 'package:suvidha/widgets/form_bottom_sheet_header.dart';

import '../../../models/service_model/service_array_response.dart';

class ServiceListBottomSheet extends StatelessWidget {
  const ServiceListBottomSheet({super.key, this.isForOrder});
  final bool? isForOrder;

  static Future<T?> show<T>(BuildContext context, {bool? isForOrder}) {
    return showModalBottomSheet<T>(
      context: context,
      builder: (context) => ServiceListBottomSheet(
        isForOrder: isForOrder ?? false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final serviceProvider = context.watch<ServiceProvider>();
    final serviceNames = serviceProvider.serviceNames;

    bool isRecommendedService = serviceProvider.isRecommendedService();

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: FormBottomSheetHeader(title: 'Choose a Service'),
            ),
            serviceProvider.loading && serviceNames!.isEmpty
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          'Select a service to get started with your ${isForOrder == true ? 'order' : 'booking'}.',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
            serviceProvider.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : serviceNames!.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 50,
                            ),
                            Text(
                              'Looks like there are no services available at the moment, please try again later!',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      )
                    : Column(
                        children: serviceNames
                            .map(
                              (serviceName) => Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                child: ListTile(
                                  minLeadingWidth: 0,
                                  leading: CircleAvatar(
                                    radius: 22,
                                    backgroundColor: serviceName.toColor,
                                    child: Text(
                                      serviceName[0].toUpperCase(),
                                    ),
                                  ),
                                  title: Text(
                                    serviceName,
                                  ),
                                  trailing: Text(
                                    isForOrder == true
                                        ? 'Order now'
                                        : 'Book now',
                                  ),
                                  subtitle: isRecommendedService
                                      ? Text('Recommended')
                                      : null,
                                  onTap: () {
                                    context.pop();
                                    isForOrder == true
                                        ? AddOrderBottomSheet(
                                            serviceNameId: serviceProvider
                                                .getServiceNameId(serviceName),
                                          )
                                        : ShowBookingOrganizationsBottomSheet
                                            .show(
                                            context,
                                            serviceName,
                                          );
                                  },
                                ),
                              ),
                            )
                            .toList(),
                      ),
            SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}

class ShowBookingOrganizationsBottomSheet extends StatelessWidget {
  const ShowBookingOrganizationsBottomSheet(
      {super.key, required this.serviceName, this.isForOrder});
  final String serviceName;
  final bool? isForOrder;

  static Future<T?> show<T>(BuildContext context, String serviceName,
      {bool? isForOrder}) {
    return showModalBottomSheet<T>(
      context: context,
      builder: (context) => ShowBookingOrganizationsBottomSheet(
        serviceName: serviceName,
        isForOrder: isForOrder ?? false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final serviceProvider = context.watch<ServiceProvider>();
    List<DocsService> services = serviceProvider.services
        .where((element) => element.serviceName.name == serviceName)
        .toList();
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FormBottomSheetHeader(title: 'Choose a Provider'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    'Select a provider to get started with your ${isForOrder == true ? 'order' : 'booking'}.',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
            for (final service in services) ...[
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                child: ListTile(
                  title: Text(
                    service.org.organizationName,
                  ),
                  subtitle: Text('Service Price: ${service.price.toCurrency}'),
                  onTap: () {
                    context.pop();
                    isForOrder == true
                        ? AddOrderBottomSheet.show(
                            context: context,
                            serviceNameId: service.serviceName.id,
                          )
                        : AddBookingBottomSheet.show(
                            context: context,
                            serviceId: service.id,
                            totalPrice: service.price,
                          );
                  },
                ),
              )
            ],
            SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    );
  }
}
