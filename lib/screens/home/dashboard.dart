import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suvidha/providers/service_provider.dart';
import 'package:suvidha/widgets/loading_screen.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key, required this.controller});
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    final _serviceProvider = Provider.of<ServiceProvider>(context);
    bool isRecommended = _serviceProvider.isRecommendedService();

    return _serviceProvider.loading
        ? const LoadingScreen()
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
            : RefreshIndicator(
                onRefresh: () => _serviceProvider.getAllServices(),
                child: SafeArea(
                  child: SingleChildScrollView(
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
                            controller: controller,
                            shrinkWrap: true,
                            itemCount: _serviceProvider.serviceNames!.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 2,
                              childAspectRatio: 1.7,
                            ),
                            itemBuilder: (context, index) {
                              final serviceName =
                                  _serviceProvider.serviceNames![index];

                              return GestureDetector(
                                onTap: () => context.push(
                                  '/service/details',
                                  extra: serviceName,
                                ),
                                child: Card(
                                  // color: Color.lerp(
                                  //   Theme.of(context)
                                  //       .colorScheme
                                  //       .surfaceContainer,
                                  //   serviceName.toColor,
                                  //   0.7,
                                  // ),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Text(
                                            serviceName.toUpperCase(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
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
