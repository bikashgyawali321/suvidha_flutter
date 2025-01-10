import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suvidha/models/user.dart';
import 'package:suvidha/services/backend.dart';

import '../models/backend_response.dart';

class AuthProvider extends ChangeNotifier {
  User? user;
  final BackendService service;
  final BuildContext context;

  bool loading = false;

  AuthProvider(this.context)
      : service = Provider.of<BackendService>(context, listen: false);
  String? error;

  // Fetch user details from the backend
  Future<void> fetchUserDetails() async {
    loading = true;
    notifyListeners();

    try {
      BackendResponse response = await service.getUserDetails();

      if (response.isError) {
        error = response.message;
        notifyListeners();

        debugPrint("Error fetching user details: ${response.message}");
      } else if (response.data != null) {
        user = User.fromJSON(response.data);
        notifyListeners();
      } else {
        debugPrint("No user data received from the backend.");
      }
    } catch (e) {
      debugPrint("Exception while fetching user details: $e");
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
