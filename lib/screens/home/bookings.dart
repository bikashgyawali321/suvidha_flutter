import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suvidha/models/bookings/booking_model.dart';
import 'package:suvidha/models/listing_model.dart';
import 'package:suvidha/screens/home/services/choose_service_bottom_sheet.dart';
import 'package:suvidha/services/backend_service.dart';
import 'package:suvidha/widgets/custom_button.dart';
import 'package:suvidha/widgets/loading_screen.dart';

class BookingsProvider extends ChangeNotifier {
  List<DocsBooking> bookings = [];
  bool loading = false;
  bool hasMore = true;
  bool loadingMore = false;
  String searchTerm = '';

  final BuildContext context;
  late BackendService _backendService;

  ListingModel listingModel = ListingModel(page: 1, limit: 13);

  BookingsProvider(this.context) {
    initialize();
  }

  void initialize() {
    _backendService = Provider.of<BackendService>(context, listen: false);
    fetchBookings();
  }

  Future<void> fetchBookings({bool reset = false}) async {
    if (reset) {
      listingModel.page = 1;
      bookings.clear();
      hasMore = true;
      notifyListeners();
    }

    if (loading || !hasMore) return;

    loading = true;
    notifyListeners();

    final response = await _backendService.getAllBookings(
      listingModel: listingModel,
    );

    if (response.result != null &&
        response.statusCode == 200 &&
        response.errorMessage == null) {
      List<DocsBooking> fetchedBookings =
          BookingArrayResponse.fromJson(response.result).docs;

      if (fetchedBookings.isEmpty ||
          fetchedBookings.length < listingModel.limit!.toInt()) {
        hasMore = false;
      }

      bookings.addAll(fetchedBookings);
    } else {
      hasMore = false;
    }

    loading = false;
    notifyListeners();
  }

  void fetchMoreBookings() async {
    if (loadingMore || !hasMore) return;

    loadingMore = true;
    listingModel.page = (listingModel.page ?? 0) + 1;
    notifyListeners();

    await fetchBookings();

    loadingMore = false;
    notifyListeners();
  }

  void updateSearchTerm(String term) {
    searchTerm = term;
    notifyListeners();
  }

  List<DocsBooking> get filteredBookings {
    List<DocsBooking> filtered = bookings;

    if (searchTerm.isNotEmpty) {
      filtered = bookings.where((booking) {
        return booking.serviceName.name
                .toLowerCase()
                .contains(searchTerm.toLowerCase()) ||
            booking.service.serviceProviderName
                .toLowerCase()
                .contains(searchTerm.toLowerCase());
      }).toList();
    }

    filtered.sort((a, b) {
      const statusOrder = {'Pending': 1, 'Accepted': 2};
      int statusComparison = (statusOrder[a.bookingStatus] ?? 3)
          .compareTo(statusOrder[b.bookingStatus] ?? 3);

      if (statusComparison != 0) {
        return statusComparison;
      }

      return a.bookingDate.compareTo(b.bookingDate);
    });

    return filtered;
  }
}

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookingsProvider(context),
      builder: (context, child) => Consumer<BookingsProvider>(
        builder: (context, provider, child) {
          return SafeArea(
            child: Stack(
              children: [
                if (provider.loading)
                  const Center(child: LoadingScreen())
                else if (provider.filteredBookings.isEmpty)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Icon(
                          Icons.error_outline,
                          size: 60,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'No bookings found!',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      Text(
                        'Looks like there are no bookings available.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: CustomButton(
                          label: 'Create New Booking',
                          onPressed: () {
                            ServiceListBottomSheet.show(context);
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
                        provider.fetchMoreBookings();
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
                        itemCount: provider.filteredBookings.length +
                            (provider.hasMore ? 1 : 0) +
                            1,
                        itemBuilder: (context, index) {
                          if (index == provider.filteredBookings.length) {
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  child: CustomButton(
                                    label: 'Create New Booking',
                                    onPressed: () {
                                      ServiceListBottomSheet.show(context);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 70,
                                ),
                              ],
                            );
                          } else if (index ==
                              provider.filteredBookings.length + 1) {
                            return const SizedBox(
                              height: 100,
                            );
                          }
                          final booking = provider.filteredBookings[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: ListTile(
                              title: Text(
                                booking.serviceName.name.toUpperCase(),
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              subtitle:
                                  Text('Status: ${booking.bookingStatus}'),
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
                        onChanged: (value) => provider.updateSearchTerm(value),
                        decoration: const InputDecoration(
                          hintText: 'Search bookings...',
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
          );
        },
      ),
    );
  }
}
