import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suvidha/providers/service_provider.dart';
import 'package:suvidha/widgets/loading_screen.dart';
import '../../providers/auth_provider.dart';
import '../../services/backend_service.dart';

class DashboardProvider extends ChangeNotifier {
  final BuildContext context;
  late BackendService _backendService;
  late ServiceProvider _serviceProvider;
  DashboardProvider(this.context) {
    initialize();
  }

  bool loading = false;
  late AuthProvider _authProvider;
  void initialize() {
    _backendService = Provider.of<BackendService>(context);
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    _serviceProvider = context.watch<ServiceProvider>();
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key, required this.controller});
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardProvider(context),
      builder: (context, child) => Consumer<DashboardProvider>(
        builder: (context, provider, child) => provider._serviceProvider.loading
            ? const LoadingScreen()
            : provider._serviceProvider.services.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 60,
                        ),
                        Text(
                          'Looks like there are no services available at there moment, please try again later!',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () => provider._serviceProvider.getAllServices(),
                    child: SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              child: Text(
                                provider._authProvider.greetingMessage,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.italic,
                                    ),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            if (provider._serviceProvider.recommendedServices
                                .isNotEmpty) ...[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'Recommended for you',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    for (final recommendedService in provider
                                        ._serviceProvider
                                        .recommendedServices) ...[
                                      ListTile(
                                        title: Text(recommendedService
                                            .serviceName.name),
                                      )
                                    ]
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Choose a service to get started!',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    GridView.builder(
                                      controller: controller,
                                      shrinkWrap: true,
                                      itemCount: provider
                                          ._serviceProvider.services.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 3,
                                        mainAxisSpacing: 5,
                                        childAspectRatio: 2.5,
                                      ),
                                      itemBuilder: (context, index) {
                                        final service = provider
                                            ._serviceProvider.services[index];
                                        return Card(
                                          // color: Color.lerp(
                                          //   Theme.of(context)
                                          //       .colorScheme
                                          //       .surfaceContainer,
                                          //   service.serviceName.name.toColor,
                                          //   0.7,
                                          // ),
                                          child: Center(
                                            child: Text(
                                              service.serviceName.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 90,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
