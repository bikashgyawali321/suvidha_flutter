import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suvidha/providers/service_provider.dart';
import 'package:suvidha/providers/theme_provider.dart';

import 'orders/add_order_bottom_sheet.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final _serviceProvider = Provider.of<ServiceProvider>(context);
    bool isRecommended = _serviceProvider.isRecommendedService();

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () => _serviceProvider.getAllServices(),
        child: _serviceProvider.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _serviceProvider.services.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 60,
                        ),
                        Text(
                          'Looks like there are no services available at this moment, please try again later!',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 5,
                              bottom: 5,
                              top: 3,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Choose a service to get started!',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            ),
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            itemCount: _serviceProvider.serviceNames!.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 2,
                              childAspectRatio: 0.92,
                            ),
                            itemBuilder: (context, index) {
                              final serviceName =
                                  _serviceProvider.serviceNames![index];

                              return GestureDetector(
                                onTap: () async {
                                  await AddOrderBottomSheet.show(
                                    context: context,
                                    serviceNameId: _serviceProvider
                                        .getServiceNameId(serviceName),
                                  );
                                },
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 10,
                                    ),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            radius: 22,
                                            backgroundColor:
                                                serviceName.toColor,
                                            child: Text(
                                              serviceName[0].toUpperCase(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineMedium
                                                  ?.copyWith(
                                                    color: Colors.white,
                                                  ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            serviceName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                          Spacer(),
                                          if (isRecommended)
                                            Text(
                                              'Recommended',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall
                                                  ?.copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primaryContainer,
                                                  ),
                                            ),
                                        ]),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 90,
                          ),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}
