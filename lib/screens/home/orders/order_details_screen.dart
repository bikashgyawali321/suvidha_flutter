import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:suvidha/screens/review&rating.dart';
import 'package:suvidha/services/backend_service.dart';
import 'package:suvidha/widgets/custom_button.dart';

import '../../../models/order_models/order_model.dart';
import '../../../widgets/loading_screen.dart';

class OrderDetailProvider extends ChangeNotifier {
  DocsOrder? order;
  bool loading = false;
  final BuildContext context;
  final String orderId;
  late BackendService _backendService;

  OrderDetailProvider(this.context, this.orderId) {
    initialize();
  }

  void initialize() {
    _backendService = Provider.of<BackendService>(context, listen: false);

    fetchOrderDetails();
  }

  Future<void> fetchOrderDetails() async {
    loading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));

    final response = await _backendService.getOrderById(orderId: orderId);
    if (response.result != null &&
        response.statusCode == 200 &&
        response.errorMessage == null &&
        response.result.isNotEmpty) {
      order = DocsOrder.fromJson(response.result);
      loading = false;
      notifyListeners();
    } else {
      loading = false;
      notifyListeners();
    }
  }

  //mark order as completed
}

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key, required this.orderId});
  final String orderId;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OrderDetailProvider(context, orderId),
      builder: (context, child) => Consumer<OrderDetailProvider>(
        builder: (context, provider, child) => Scaffold(
          appBar: AppBar(
            title: Text("Order Details"),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: provider.loading
                  ? LoadingScreen()
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Here are the details of the order',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          SizedBox(height: 10),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    title: Text(
                                      'Service Name',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    subtitle: Text(
                                      provider.order?.serviceName.name ??
                                          'Not Available',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                  customDivider(),
                                  ListTile(
                                    title: Text(
                                      'Status',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    subtitle: Text(
                                      provider.order?.status ??
                                          'Not Determined',
                                    ),
                                  ),
                                  customDivider(),
                                  ListTile(
                                    title: Text(
                                      'Address',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    subtitle: Text(
                                      provider.order?.location ??
                                          'Not Available',
                                    ),
                                  ),
                                  if (provider.order?.service != null) ...[
                                    customDivider(),
                                    ListTile(
                                      title: Text(
                                        'Service Provider Name',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      subtitle: Text(
                                        provider.order?.service!
                                                .serviceProviderName ??
                                            'Not Available',
                                      ),
                                      trailing: provider.order != null &&
                                              provider.order!.service!.img
                                                  .isNotEmpty
                                          ? CircleAvatar(
                                              radius: 25,
                                              backgroundImage: NetworkImage(
                                                provider
                                                    .order!.service!.img.first,
                                              ),
                                            )
                                          : null,
                                    ),
                                    customDivider(),
                                    ListTile(
                                      title: Text(
                                        'Service Provider Phone',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      subtitle: Text(
                                        provider.order?.service!
                                                .serviceProviderPhone ??
                                            'Not Available',
                                      ),
                                    ),
                                    customDivider(),
                                    //service rating
                                    ListTile(
                                      title: Text(
                                        'Service Rating',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      subtitle: Row(
                                        children: [
                                          RatingBarIndicator(
                                            itemBuilder: (context, index) =>
                                                Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            rating: provider
                                                    .order?.service!.rating ??
                                                0.0,
                                            itemCount: 5,
                                            itemSize: 20,
                                            direction: Axis.horizontal,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            '(${provider.order?.service!.rating}/5)',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                  if (provider.order?.org != null) ...[
                                    customDivider(),
                                    ListTile(
                                      title: Text(
                                        'Organization Name',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      subtitle: Text(
                                        provider.order?.org!.nameOrg ??
                                            'Not Available',
                                      ),
                                    ),
                                    customDivider(),
                                    ListTile(
                                      title: Text(
                                        'Organization Address',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      subtitle: Text(
                                        provider.order?.org!.address ??
                                            'Not Available',
                                      ),
                                    ),
                                    customDivider(),
                                    ListTile(
                                      title: Text(
                                        'Organization Contact Person',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      subtitle: Text(
                                        provider.order?.org!.contactPerson ??
                                            'Not Available',
                                      ),
                                    ),
                                    customDivider(),
                                    ListTile(
                                      title: Text(
                                        'Organization Rating',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      subtitle: Row(
                                        children: [
                                          RatingBarIndicator(
                                            itemBuilder: (context, index) =>
                                                Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            rating: provider.order?.org!.rating
                                                    .toDouble() ??
                                                0.0,
                                            itemCount: 5,
                                            itemSize: 20,
                                            direction: Axis.horizontal,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            '(${provider.order?.org!.rating.toStringAsFixed(2)}/5)',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                        ],
                                      ),
                                    )
                                  ]
                                ],
                              ),
                            ),
                          ),
                          if (provider.order?.status == 'Completed') ...[
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: CustomButton(
                                label: 'Rate and Review',
                                onPressed: () =>
                                    ReviewAndRatingBottomSheet.show(
                                  context: context,
                                  id: orderId,
                                  isForBooking: false,
                                ),
                              ),
                            ),
                          ],
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget customDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      indent: 20,
      endIndent: 6,
    );
  }
}
