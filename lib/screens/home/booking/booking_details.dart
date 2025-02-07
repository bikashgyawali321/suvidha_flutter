import 'package:flutter/material.dart';
import 'package:suvidha/extensions.dart';
import 'package:suvidha/models/bookings/booking_model.dart';
import 'package:suvidha/widgets/custom_button.dart';

import '../../review&rating.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Here are the details of your booking',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
                        'Address',
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
                        'Price',
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
                      trailing: booking.service.images!.isNotEmpty
                          ? CircleAvatar(
                              radius: 25,
                              backgroundImage: booking
                                      .service.images!.isNotEmpty
                                  ? NetworkImage(booking.service.images!.first)
                                  : null,
                            )
                          : null,
                      title: Text(
                        'Service Provider',
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
                        'Mobile Number',
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
                    ListTile(
                      title: Text(
                        'Email',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      subtitle: Text(
                        booking.service.serviceProviderEmail,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (booking.bookingStatus == "Completed") ...[
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: CustomButton(
                  label: 'Rate and Review',
                  onPressed: ()=> ReviewAndRatingBottomSheet.show(
                    context: context,
                     id:booking.id,
                     isForBooking: true,
                ),
              ),
              ),
            ]
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
        height: 0,
      ),
    );
  }
}
