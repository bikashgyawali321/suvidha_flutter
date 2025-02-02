import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suvidha/models/order_models/order_model.dart';
import 'package:suvidha/providers/location_provider.dart';
import 'package:suvidha/services/backend_service.dart';
import 'package:suvidha/widgets/custom_button.dart';
import 'package:suvidha/widgets/custom_snackbar.dart';
import 'package:suvidha/widgets/form_bottom_sheet_header.dart';

class AddOrderBottomSheetProvider extends ChangeNotifier {
  final BuildContext context;
  late BackendService _backendService;
  late LocationProvider _locationProvider;
  final String serviceId;

  AddOrderBottomSheetProvider(
      {required this.context,
      required this.serviceId}) {
    debugPrint(serviceId);
    initialize();
  }

  void initialize() {
    _backendService = Provider.of<BackendService>(
      context,
      listen: false,
    );
    _locationProvider = Provider.of<LocationProvider>(context, listen: false);

    newOrder = NewOrderModel(
      serviceId: serviceId,
      longitudeLatitude: LongitudeLatitudeModel(
        type: 'Point',
        coordinates: [
          _locationProvider.currentPosition?.latitude ?? 0.0,
          _locationProvider.currentPosition?.longitude ?? 0.0,
        ],
      ),
      location: _locationProvider.currentAddress ?? '',
    );
  }

  bool loading = false;
  NewOrderModel? newOrder;

  final _formKey = GlobalKey<FormState>();

  //place an order
  Future<void> placeOrder() async {
    if (!_formKey.currentState!.validate()) return;
    loading = true;
    notifyListeners();

    try {
      final response = await _backendService.createOrder(newOrder: newOrder!);

      if (response.statusCode == 200) {
        context.go('/home');
        SnackBarHelper.showSnackbar(
            context: context,
            successMessage:
                'Order placed successfully, wait for the service provider to accept');
      } else {
        context.pop();
        SnackBarHelper.showSnackbar(
          context: context,
          errorMessage: response.errorMessage,
        );
      }
    } catch (e) {
      debugPrint("Error while placing order: $e");
      SnackBarHelper.showSnackbar(
        context: context,
        errorMessage: 'Error while placing order',
      );
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}

class AddOrderBottomSheet extends StatelessWidget {
  final String serviceNameId;

  const AddOrderBottomSheet({super.key, required this.serviceNameId});

  static Future<T?> show<T>({
    required BuildContext context,
    required String serviceNameId,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AddOrderBottomSheet(
          serviceNameId: serviceNameId,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddOrderBottomSheetProvider(
        context: context,
        serviceId: serviceNameId,
      ),
      child: Consumer<AddOrderBottomSheetProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    key: provider._formKey,
                    child: Column(
                      children: [
                        FormBottomSheetHeader(
                          title: 'Place Order Request',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Your service, your way! Place an order request and connect with top-rated providers nearby.",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          initialValue: provider.newOrder?.location,
                          decoration: InputDecoration(
                            labelText: 'Address',
                            hintText:
                                'Enter your address where the service is required',
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                          ),
                          onChanged: (value) {
                            provider.newOrder!.location = value;
                          },
                          validator: (value) {
                            if (value == null && value!.isEmpty) {
                              return 'Please enter your location';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: CustomButton(
                                label: 'Not Now',
                                onPressed: () => context.go('/home'),
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: CustomButton(
                                label: 'Request Now',
                                onPressed: provider.placeOrder,
                                loading: provider.loading,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
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
