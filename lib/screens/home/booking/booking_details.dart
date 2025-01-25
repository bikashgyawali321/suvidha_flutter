// ignore_for_file: unnecessary_this, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
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
      body: Column(
        children: [
          //TODO: work here to show the booking details , ashma
          //najane sodhne , use card , refer to suvidha org
          //tei mathi ko kura booking ko kura lai tile banayera dekhauni ta ho
        ],
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
