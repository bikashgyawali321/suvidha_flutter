import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suvidha/models/listing_model.dart';
import 'package:suvidha/providers/theme_provider.dart';
import 'package:suvidha/screens/home/services/choose_service_bottom_sheet.dart';
import 'package:suvidha/services/backend_service.dart';
import 'package:suvidha/widgets/custom_button.dart';
import 'package:suvidha/widgets/loading_screen.dart';

import '../../models/order_models/order_model.dart';

class OrderProvider extends ChangeNotifier {
  List<DocsOrder> orders = [];
  bool loading = false;
  bool hasMore = true;
  bool loadingMore = false;
  String searchTerm = '';

  final BuildContext context;
  late BackendService _backendService;

  ListingModel listingModel = ListingModel(page: 1, limit: 50);

  OrderProvider(this.context) {
    initialize();
  }

  void initialize() {
    _backendService = Provider.of<BackendService>(context, listen: false);
    fetchOrders();
  }

  Future<void> fetchOrders({bool reset = false}) async {
    if (reset) {
      listingModel.page = 1;
      orders.clear();
      hasMore = true;
      notifyListeners();
    }

    if (loading || !hasMore) return;

    loading = true;
    notifyListeners();

    final response = await _backendService.fetchAllOrders(
      listModel: listingModel,
    );

    if (response.result != null &&
        response.statusCode == 200 &&
        response.errorMessage == null) {
      OrderArrayResponse orderArrayResponse =
          OrderArrayResponse.fromJson(response.result);
      List<DocsOrder> fetchedOrders = orderArrayResponse.docs;

      if (fetchedOrders.isEmpty ||
          fetchedOrders.length < listingModel.limit!.toInt()) {
        hasMore = false;
      }

      orders.addAll(fetchedOrders);
    } else {
      hasMore = false;
    }

    loading = false;
    notifyListeners();
  }

  void fetchMoreOrders() async {
    if (loadingMore || !hasMore) return;

    loadingMore = true;
    listingModel.page = (listingModel.page ?? 0) + 1;
    notifyListeners();

    await fetchOrders();

    loadingMore = false;
    notifyListeners();
  }

  void updateSearchTerm(String term) {
    searchTerm = term;
    notifyListeners();
  }

  List<DocsOrder> get filteredOrders {
    List<DocsOrder> filtered = orders;

    if (searchTerm.isNotEmpty) {
      filtered = orders.where((order) {
        return order.serviceName.name
            .toLowerCase()
            .contains(searchTerm.toLowerCase());
      }).toList();
    }

    filtered.sort((a, b) {
      const statusOrder = {'Requested': 1, 'Accepted': 2};
      int statusComparison =
          (statusOrder[a.status] ?? 3).compareTo(statusOrder[b.status] ?? 3);

      if (statusComparison != 0) {
        return statusComparison;
      }

      return a.createdAt.compareTo(b.createdAt);
    });

    return filtered;
  }
}

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OrderProvider(context),
      builder: (context, child) => Consumer<OrderProvider>(
        builder: (context, provider, child) {
          return SafeArea(
            child: RefreshIndicator(
              onRefresh: () => provider.fetchOrders(reset: true),
              child: Stack(
                children: [
                  if (provider.loading)
                    const Center(child: LoadingScreen())
                  else if (provider.filteredOrders.isEmpty)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Icon(
                            Icons.shopping_cart_checkout_outlined,
                            size: 60,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'No orders found!',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          'Looks like there are no orders available.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 20,
                          ),
                          child: CustomButton(
                            label: 'Create New Order',
                            onPressed: () {
                              ServiceListBottomSheet.show(
                                context,
                                isForOrder: true,
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  else
                    NotificationListener<ScrollNotification>(
                      onNotification: (scrollInfo) {
                        if (scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent &&
                            provider.hasMore) {
                          provider.fetchMoreOrders();
                        }
                        return false;
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 35),
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical: 20,
                          ),
                          itemCount: provider.filteredOrders.length +
                              (provider.hasMore ? 1 : 0) +
                              1,
                          itemBuilder: (context, index) {
                            if (index == provider.filteredOrders.length) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 20,
                                    ),
                                    child: CustomButton(
                                      label: 'Create New Order',
                                      onPressed: () {
                                        ServiceListBottomSheet.show(
                                          context,
                                          isForOrder: true,
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 70,
                                  ),
                                ],
                              );
                            } else if (index ==
                                provider.filteredOrders.length + 1) {
                              return const SizedBox(
                                height: 100,
                              );
                            }
                            final orders = provider.filteredOrders[index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 25,
                                  backgroundColor:
                                      orders.serviceName.name.toColor,
                                  child: Text(
                                    orders.serviceName.name[0].toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                ),
                                title: Text(
                                  orders.serviceName.name.toUpperCase(),
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                subtitle: Text('Status: ${orders.status}'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('View Details'),
                                    Icon(Icons.chevron_right)
                                  ],
                                ),
                                onTap: () => context.push(
                                  '/order/${orders.id}',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  Positioned(
                    top: -2,
                    left: 00,
                    right: 0,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      color: Theme.of(context).appBarTheme.foregroundColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          onChanged: (value) =>
                              provider.updateSearchTerm(value),
                          decoration: const InputDecoration(
                            hintText: 'Search Orders...',
                            prefixIcon: Icon(
                              Icons.search,
                              size: 30,
                            ),
                            contentPadding: EdgeInsets.all(10),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
