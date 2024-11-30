import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suvidha/models/user.dart';
import 'package:suvidha/services/backend.dart';

class AuthProvider extends ChangeNotifier {
  final BuildContext context;
  User? user;
  final BackendService _service;

  bool loading = false;

  AuthProvider(this.context)
      : _service = Provider.of<BackendService>(context, listen: false);

  Future<void> login({required String email, required String password}) async {
    loading = true;
    notifyListeners();
    final response = await _service.login(email: email, password: password);

    if (response.error == null) {
      //TODO:save token
      notifyListeners();
    }
  }
}
