import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suvidha/extensions.dart';
import 'package:suvidha/providers/location_provider.dart';
import 'package:suvidha/screens/home/bookings.dart';
import 'package:suvidha/services/backend_service.dart';
import 'package:suvidha/widgets/custom_button.dart';
import 'package:suvidha/widgets/custom_snackbar.dart';
import 'package:suvidha/widgets/form_bottom_sheet_header.dart';
import 'package:board_datetime_picker/board_datetime_picker.dart';

import '../../../models/bookings/booking_model.dart';

class AddBookingProvider extends ChangeNotifier {
  late BackendService _backendService;
  late LocationProvider _locationProvider;
  final BuildContext context;
  final String choosedServiceId;
  final double totalPrice;
  late BookingsProvider bookingsProvider;
  AddBookingProvider({
    required this.context,
    required this.choosedServiceId,
    required this.totalPrice,
  }) {
    initialize();
  }

  bool loading = false;
  final dateController = TextEditingController();

  void initialize() {
    _backendService = Provider.of<BackendService>(context, listen: false);
    _locationProvider = context.watch<LocationProvider>();
    bookingsProvider = context.watch<BookingsProvider>();
    dateController.text = DateTime.now().toLocal().toVerbalDateTime;
    initialDate = DateTime.now().toLocal();

    newBooking = NewBooking(
      serviceId: choosedServiceId,
      bookingDate: DateTime.now().add(
        Duration(days: 1),
      ),
      location: _locationProvider.currentAddress ?? '',
      totalPrice: totalPrice,
    );
  }

  NewBooking? newBooking;
  Booking? booking;
  DateTime? initialDate;

  final _formKey = GlobalKey<FormState>();
  void _pickDate() async {
    final result = await showBoardDateTimePicker(
      context: context,
      pickerType: DateTimePickerType.datetime,
      initialDate: initialDate,
      minimumDate: DateTime.now(),
      options: BoardDateTimeOptions(
        activeColor: Theme.of(context).colorScheme.primary,
        pickerFormat: 'y M d | hh:mm aa',
        foregroundColor: Colors.transparent,
        useAmpm: true,
        showDateButton: true,
        boardTitle: 'Choose a date to book the service',
        inputable: false,
        pickerSubTitles: BoardDateTimeItemTitles(
          year: "Year",
        ),
      ),
    );
    if (result != null) {
      initialDate = result.toLocal();
      newBooking!.bookingDate = result.toLocal();
      dateController.text = result.toLocal().toVerbalDateTime;
      notifyListeners();
    }
  }

  //  function to create new booking
  Future<void> createBooking() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    loading = true;
    notifyListeners();
    try {
      final response =
          await _backendService.addBooking(newBooking: newBooking!);
      if (response.statusCode == 200 ||
          response.result != null ||
          response.errorMessage == null) {
        loading = false;
        SnackBarHelper.showSnackbar(
          context: context,
          successMessage: response.message,
        );
        notifyListeners();
      } else {
        loading = false;
        notifyListeners();
        SnackBarHelper.showSnackbar(
          context: context,
          errorMessage: response.errorMessage,
        );
      }
    } catch (e) {
      loading = false;
      notifyListeners();
      SnackBarHelper.showSnackbar(
        context: context,
        errorMessage:
            'An error occurred while creating booking,please try again later',
      );
    } finally {
      context.pop();
      loading = false;
      bookingsProvider.fetchBookings();
      notifyListeners();
    }
  }
}

class AddBookingBottomSheet extends StatelessWidget {
  const AddBookingBottomSheet({
    super.key,
    required this.serviceId,
    required this.totalPrice,
  });
  final double totalPrice;
  final String serviceId;
  static Future<T?> show<T>({
    required BuildContext context,
    required String serviceId,
    required double totalPrice,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      builder: (_) => AddBookingBottomSheet(
        serviceId: serviceId,
        totalPrice: totalPrice,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddBookingProvider(
        context: context,
        choosedServiceId: serviceId,
        totalPrice: totalPrice,
      ),
      builder: (context, child) => Consumer<AddBookingProvider>(
        builder: (context, provider, child) => SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FormBottomSheetHeader(title: 'Add Booking'),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Form(
                    key: provider._formKey,
                    child: Column(
                      children: [
                        Text(
                          'Create a new advance booking for a service you want to avail.',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 12),

                        // Date picker
                        TextFormField(
                          controller: provider.dateController,
                          readOnly: true,
                          onTap: provider._pickDate,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                            suffixIcon: Icon(Icons.calendar_today),
                            labelText: 'Booking Date',
                            hintText:
                                'Select a date for when you want to book a service',
                            hintStyle: Theme.of(context).textTheme.bodySmall,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please select a date';
                            }

                            //date should not be beyond three days from today and it should be atleast 1 hour from now
                            if (provider.newBooking!.bookingDate.isBefore(
                              DateTime.now().add(
                                Duration(days: 1),
                              ),
                            )) {
                              return 'Booking date should be atleast 1 day behind from now';
                            }
                            if (provider.newBooking!.bookingDate.isAfter(
                              DateTime.now().add(
                                Duration(days: 3),
                              ),
                            )) {
                              return 'Booking date should not be beyond 3 days from now';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 12),
                        //for address
                        TextFormField(
                          initialValue: provider.newBooking!.location,
                          onChanged: (value) {
                            provider.newBooking!.location = value;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                            prefixIcon: Icon(Icons.location_on),
                            labelText: 'Address',
                            hintText:
                                'Enter the address where you want the service',
                            hintStyle: Theme.of(context).textTheme.bodySmall,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 12),
                        //for total price
                        TextFormField(
                          initialValue: provider.totalPrice.toCurrency,
                          readOnly: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                            prefix: Text(
                              'Rs. ',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            labelText: 'Total Price (fixed)',
                            hintText: 'Total price for the service',
                            hintStyle: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        SizedBox(height: 12),
                        //for optional email
                        TextFormField(
                          onChanged: (value) {
                            provider.newBooking!.optionalEmail = value;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                            prefixIcon: Icon(Icons.email),
                            labelText: 'Email (optional)',
                            hintText: 'Enter an optional email for the service',
                            hintStyle: Theme.of(context).textTheme.bodySmall,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            //regex for email validation
                            final emailRegex = RegExp(
                                r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
                            if (value!.isNotEmpty &&
                                !emailRegex.hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 12),
                        //for optional phone number
                        TextFormField(
                          onChanged: (value) {
                            provider.newBooking!.optionalContact = value;
                          },
                          maxLength: 10,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                            prefixIcon: Icon(Icons.phone),
                            labelText: 'Phone Number(optional)',
                            hintText:
                                'Enter an optional phone number for the service',
                            hintStyle: Theme.of(context).textTheme.bodySmall,
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isNotEmpty && value.length < 10) {
                              return 'Phone number should be 10 digits long';
                            }

                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        CustomButton(
                          label: 'Create Booking',
                          onPressed: () => provider.createBooking(),
                          loading: provider.loading,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
