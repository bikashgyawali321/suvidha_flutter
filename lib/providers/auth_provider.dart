import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suvidha/models/auth_models/user_model.dart';
import 'package:suvidha/services/backend_service.dart';
import 'package:suvidha/widgets/custom_snackbar.dart';

import '../services/notification.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? user;
  final BackendService service;
  final BuildContext context;

  bool loading = false;

  AuthProvider(this.context)
      : service = Provider.of<BackendService>(context, listen: false);

  //greeting message to the user based on the time of the day
  String get greetingMessage {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning,${user?.name ?? 'User'} 😊';
    }
    if (hour < 17) {
      return 'Good Afternoon,${user?.name ?? 'User'} 😊';
    }
    return 'Good Evening, ${user?.name ?? 'User'} 😊';
  }

  // Fetch user details from the backend
  Future<void> fetchUserDetails(BuildContext context) async {
    loading = true;
    notifyListeners();

    try {
      final response = await service.getUserDetails();

      if (response.result != null && response.statusCode == 200) {
        user = UserModel.fromJson(response.result!);
        if (user!.role != "User") {
          context.go('/login');
          SnackBarHelper.showSnackbar(
            context: context,
            warningMessage:
                'You are not authorized to access this app, please login with a valid user account',
          );
          return;
        }
        context.read<NotificationService>().sendFCMToken();
        context.go('/home');

        debugPrint("User details: ${user!.name}");
      } else {
        SnackBarHelper.showSnackbar(
          context: context,
          errorMessage: response.errorMessage,
        );
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Exception while fetching user details: $e");
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  //function to refresh the auth token
}
