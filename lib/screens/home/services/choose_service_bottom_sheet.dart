import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suvidha/providers/service_provider.dart';
import 'package:suvidha/screens/home/booking/add_booking.dart';
import 'package:suvidha/widgets/form_bottom_sheet_header.dart';

class ServiceListBottomSheet extends StatefulWidget {
  const ServiceListBottomSheet({super.key});

  static Future<T?> show<T>(BuildContext context) {
    return showModalBottomSheet<T>(
      context: context,
      builder: (context) => const ServiceListBottomSheet(),
    );
  }

  @override
  State<ServiceListBottomSheet> createState() => _ServiceListBottomSheetState();
}

class _ServiceListBottomSheetState extends State<ServiceListBottomSheet> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final serviceProvider = context.watch<ServiceProvider>();
    final services = serviceProvider.services;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: FormBottomSheetHeader(title: 'Choose a Service'),
            ),
            serviceProvider.loading && services.isEmpty
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          'Select a service to get started with your booking.',
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
                : services.isEmpty
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
                        children: services
                            .map(
                              (service) => Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                child: ListTile(
                                  title: Text(
                                      service.serviceName.name.toUpperCase()),
                                  subtitle: Text(service.org.organizationName),
                                  onTap: () {
                                    context.pop();
                                    AddBookingBottomSheet.show(
                                      context: context,
                                      serviceId: service.id,
                                      totalPrice: service.price,
                                    );
                                  },
                                ),
                              ),
                            )
                            .toList(),
                      ),
            SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
