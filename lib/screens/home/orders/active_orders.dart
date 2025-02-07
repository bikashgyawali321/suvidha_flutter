import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suvidha/models/listing_model.dart';
import 'package:suvidha/models/order_models/order_model.dart';
import 'package:suvidha/providers/theme_provider.dart';
import 'package:suvidha/screens/home/services/choose_service_bottom_sheet.dart';
import 'package:suvidha/services/backend_service.dart';
import 'package:suvidha/widgets/custom_button.dart';
import 'package:suvidha/widgets/loading_screen.dart';

class ActiveOrdersProvider extends ChangeNotifier {
  ListingModel listingModel =
      ListingModel(page: 1, limit: 50, status: 'Accepted');
  late BackendService _backendService;

  ActiveOrdersProvider(this.context) {
    initialize();
  }

  final BuildContext context;
  void initialize() {
    _backendService = Provider.of<BackendService>(context, listen: false);
    getActiveOrders();
  }

  bool loading = false;
  List<DocsOrder> activeOrders = [];

  //get all active orders
  Future<void> getActiveOrders() async {
    loading = true;
    notifyListeners();
    final response = await _backendService.fetchAllOrders(
      listModel: listingModel,
    );
    if (response.statusCode == 200 && response.result != null) {
      OrderArrayResponse resp = OrderArrayResponse.fromJson(response.result!);
      activeOrders = resp.docs.isNotEmpty ? resp.docs : [];

      loading = false;
      notifyListeners();
    } else {
      activeOrders = [];
      loading = false;
      notifyListeners();
    }
  }
}

class ActiveOrdersScreen extends StatelessWidget {
  const ActiveOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ActiveOrdersProvider(context),
      builder: (context, child) => Consumer<ActiveOrdersProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Onegoing Orders'),
            ),
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: () => provider.getActiveOrders(),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (provider.loading) LoadingScreen(),
                        if (provider.activeOrders.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                ),
                                Icon(
                                  Icons.shopping_cart_outlined,
                                  size: 80,
                                ),
                                Text(
                                  'No Active Orders',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'You have no active orders at the moment. Create one now?.',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomButton(
                                  label: 'Place New Order',
                                  onPressed: () async {
                                    ServiceListBottomSheet.show(
                                      context,
                                      isForOrder: true,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        if (provider.activeOrders.isNotEmpty) ...[
                          for (var order in provider.activeOrders) ...[
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 25,
                                  backgroundColor:
                                      order.serviceName.name.toColor,
                                  child: Text(
                                    order.serviceName.name[0].toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                ),
                                title:
                                    Text(order.serviceName.name.toUpperCase()),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("View Details"),
                                    Icon(Icons.chevron_right),
                                  ],
                                ),
                                onTap: () => context.push('/order/${order.id}'),
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                          ],
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: CustomButton(
                              label: 'Place New Order',
                              onPressed: () {
                                ServiceListBottomSheet.show(
                                  context,
                                  isForOrder: true,
                                );
                              },
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
          );
        },
      ),
    );
  }
}
