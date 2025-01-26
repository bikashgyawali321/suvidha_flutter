// ignore_for_file: unnecessary_this, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:suvidha/extensions.dart';
import 'package:suvidha/models/bookings/booking_model.dart';

class BookingDetails extends StatelessWidget {
  const BookingDetails({super.key, required this.booking});
  final DocsBooking booking;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Booking Details',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Basic Information',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        'Service Name',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      subtitle: Text(
                        booking.serviceName.name.toUpperCase(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    customDivider(),
                    ListTile(
                      title: Text(
                        'From',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      subtitle: Text(
                        booking.org.organizationName,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    customDivider(),
                    ListTile(
                      title: Text(
                        'Location',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      subtitle: Text(
                        booking.location,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    customDivider(),
                    ListTile(
                      title: Text(
                        'Service Price',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      subtitle: Text(
                        booking.totalPrice.toCurrency,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    customDivider(),
                    ListTile(
                      title: Text(
                        'Booking Date',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      subtitle: Text(
                        booking.bookingDate.toLocal().toVerbalDateTime,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    customDivider(),
                    ListTile(
                      title: Text(
                        'Status',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      subtitle: Text(
                        booking.bookingStatus,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    customDivider(),
                    ListTile(
                      title: Text(
                        'Service Provider Name',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      subtitle: Text(
                        booking.service.serviceProviderName,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    customDivider(),
                    ListTile(
                      title: Text(
                        'Service Provider Phone Number',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      subtitle: Text(
                        booking.service.serviceProviderPhoneNumber,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    customDivider(),
                    if (booking.optionalContact != null)
                      ListTile(
                        title: Text(
                          'Optional Contact',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        subtitle: Text(
                          booking.optionalContact ?? 'N/A',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    customDivider(),
                    if (booking.optionalContact != null)
                      ListTile(
                        title: Text(
                          'Optional Email',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        subtitle: Text(
                          booking.optionalEmail ?? 'N/A',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                  ],
                ),
              ),
            ),

            //TODO: work here to show the booking details , ashma
            //najane sodhne , use card , refer to suvidha org
            //tei mathi ko kura booking ko kura lai tile banayera dekhauni ta ho
          ],
        ),
      ),
    );
  }

  Widget customDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Divider(
        thickness: 0,
        color: Colors.blueGrey[400],
      ),
    );
  }
}

//use this extension after price , like price.toCurrency
extension on num {
  String get toCurrency {
    return 'Rs ' + this.toString();
  }
}
