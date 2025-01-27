import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suvidha/models/bookings/booking_model.dart';
import 'package:suvidha/screens/home/services/choose_service_bottom_sheet.dart';
import 'package:suvidha/services/backend_service.dart';
import 'package:suvidha/widgets/custom_button.dart';
import 'package:suvidha/widgets/loading_screen.dart';

class BookingsProvider extends ChangeNotifier {
  late BackendService _backendService;
  final BuildContext context;

  BookingsProvider(this.context) {
    initialize();
  }

  bool loading = false;
  List<DocsBooking> bookings = [];
  BookingArrayResponse? arrayResponse;

  Booking? booking;
  void initialize() {
    _backendService = Provider.of<BackendService>(context, listen: false);

    getAllBookings();
  }

  Future<void> getAllBookings() async {
    loading = true;
    notifyListeners();

    try {
      final response = await _backendService.getAllBookings();

      if (response.statusCode == 200 && response.result != null) {
        arrayResponse = BookingArrayResponse.fromJson(response.result!);
        bookings = arrayResponse!.docs;
      } else {
        bookings = [];
      }
    } catch (e) {
      debugPrint("Error in fetching bookings:${e.toString()}");
      bookings = [];
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}

class Bookings extends StatelessWidget {
  const Bookings({super.key, required this.controller});
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BookingsProvider>();
    return SafeArea(
      child: SingleChildScrollView(
        controller: controller,
        child: RefreshIndicator(
          onRefresh: () => provider.getAllBookings(),
          child: Column(
            children: [
              provider.loading
                  ? LoadingScreen()
                  : provider.bookings.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.33,
                                ),
                                Icon(
                                  Icons.error_outline,
                                  size: 60,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Looks like you have no bookings at the moment, create one now!',
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomButton(
                                  label: 'Add Now',
                                  onPressed: () =>
                                      ServiceListBottomSheet.show(context),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                'All your bookings in one place.',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            for (final booking in provider.bookings) ...[
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    5,
                                    5,
                                    5,
                                    0,
                                  ),
                                  child: ListTile(
                                    title: Text(booking.serviceName.name),
                                    subtitle:
                                        Text('Status:${booking.bookingStatus}'),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('View Details'),
                                        Icon(Icons.chevron_right)
                                      ],
                                    ),
                                    onTap: () => context.push(
                                      '/booking/details',
                                      extra: booking,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: CustomButton(
                                  label: 'Create New Booking',
                                  onPressed: () {
                                    ServiceListBottomSheet.show(context);
                                  }),
                            ),
                          ],
                        ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
