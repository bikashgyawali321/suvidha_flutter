import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suvidha/extensions.dart';
import 'package:suvidha/models/bookings/booking_model.dart';
import 'package:suvidha/models/listing_model.dart';
import 'package:suvidha/providers/theme_provider.dart';
import 'package:suvidha/screens/home/services/choose_service_bottom_sheet.dart';
import 'package:suvidha/services/backend_service.dart';
import 'package:suvidha/widgets/custom_button.dart';
import 'package:suvidha/widgets/loading_screen.dart';

class ActiveBookingProvider extends ChangeNotifier {
  ListingModel listingModel =
      ListingModel(page: 1, limit: 50, status: 'Accepted');
  late BackendService _backendService;

  ActiveBookingProvider(this.context) {
    initialize();
  }

  final BuildContext context;
  void initialize() {
    _backendService = Provider.of<BackendService>(context, listen: false);
    getActiveOrders();
  }

  bool loading = false;
  List<DocsBooking> activeBookings = [];

  //get all active orders
  Future<void> getActiveOrders() async {
    loading = true;
    notifyListeners();
    final response = await _backendService.getAllBookings(
      listingModel: listingModel,
    );
    if (response.statusCode == 200 && response.result != null) {
      BookingArrayResponse resp = BookingArrayResponse.fromJson(
        response.result!,
      );
      activeBookings = resp.docs.isNotEmpty ? resp.docs : [];

      loading = false;
      notifyListeners();
    } else {
      activeBookings = [];
      loading = false;
      notifyListeners();
    }
  }
}

class ActiveBookingScreen extends StatelessWidget {
  const ActiveBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ActiveBookingProvider(context),
      builder: (context, child) => Consumer<ActiveBookingProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Upcoming Bookings'),
            ),
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: () => provider.getActiveOrders(),
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (provider.loading) LoadingScreen(),
                        if (provider.activeBookings.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                ),
                                Icon(
                                  Icons.event_outlined,
                                  size: 80,
                                ),
                                Text(
                                  'No Active Bookings',
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
                                  'You have no active bookings at the moment. Create one now?.',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomButton(
                                  label: 'Place New Booking',
                                  onPressed: () async {
                                    ServiceListBottomSheet.show(
                                      context,
                                      isForOrder: false,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        if (provider.activeBookings.isNotEmpty) ...[
                          for (var booking in provider.activeBookings) ...[
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 25,
                                  backgroundColor:
                                      booking.serviceName.name.toColor,
                                  child: Text(
                                    booking.serviceName.name[0].toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                ),
                                title: Text(
                                  booking.serviceName.name.toUpperCase(),
                                ),
                                subtitle: Text(
                                  booking.bookingDate.toMarkerDate,
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("View Details"),
                                    Icon(Icons.chevron_right),
                                  ],
                                ),
                                onTap: () => context.push(
                                  '/booking/details',
                                  extra: booking,
                                ),
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
                                label: 'Place New Booking',
                                onPressed: () {
                                  ServiceListBottomSheet.show(
                                    context,
                                    isForOrder: false,
                                  );
                                }),
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
