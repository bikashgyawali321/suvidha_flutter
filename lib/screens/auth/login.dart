import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suvidha/models/auth_models/login_request.dart';
import 'package:suvidha/screens/auth/bottomsheets/forgot_password_sheet.dart';
import 'package:suvidha/services/backend_service.dart';
import 'package:suvidha/services/custom_hive.dart';
import 'package:suvidha/widgets/custom_button.dart';
import 'package:suvidha/widgets/custom_snackbar.dart';

import '../../models/auth_models/auth_token.dart';
import '../../providers/theme_provider.dart';

class LoginProvider extends ChangeNotifier {
  final BuildContext context;
  bool loading = false;
  late BackendService _backendService;
  bool _obsecureText = true;
  LoginRequest request = LoginRequest(email: '', password: '');
  final _formKey = GlobalKey<FormState>();
  LoginProvider(this.context)
      : _backendService = Provider.of<BackendService>(context);

  //void toggle visiblitity of password
  void toggleVisibility() {
    _obsecureText = !_obsecureText;
    notifyListeners();
  }

  Future<void> login() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    loading = true;
    notifyListeners();

    final response = await _backendService.login(request);
    if (response.result != null) {
      loading = false;
      notifyListeners();
      AuthToken token = AuthToken.fromJson(response.result!);
      await CustomHive().saveAuthToken(token);
      context.go('/');
    } else {
      loading = false;
      notifyListeners();
      SnackBarHelper.showSnackbar(
        context: context,
        errorMessage: response.errorMessage,
      );
    }
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginProvider(context),
      builder: (context, child) => Consumer<LoginProvider>(
        builder: (context, provider, child) => Scaffold(
          backgroundColor: primaryDark,
          body: SafeArea(
            child: Center(
              child: Column(
                children: [
                  Expanded(
                      child: Hero(
                    tag: 'logo',
                    child: Column(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Image.asset(
                            'assets/icon/app_icon.png',
                            height: 200,
                            width: 200,
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text(
                            'Suvidha',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(color: suvidhaWhite),
                          ),
                        ),
                      ],
                    ),
                  )),
                  Card(
                    margin: const EdgeInsets.all(20),
                    child: Form(
                      key: provider._formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Let's login",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                label: Text('Email'),
                              ),
                              onChanged: (value) =>
                                  provider.request.email = value,
                              validator: (value) {
                                RegExp emailRegex =
                                    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }

                                if (!emailRegex.hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }

                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  label: Text('Password'),
                                  suffixIcon: IconButton(
                                      onPressed: () =>
                                          provider.toggleVisibility(),
                                      icon: Icon(provider._obsecureText
                                          ? Icons.visibility_off
                                          : Icons.visibility))),
                              obscureText: provider._obsecureText,
                              onChanged: (value) =>
                                  provider.request.password = value,
                              validator: (value) {
                                RegExp passwordRegex = RegExp(
                                    r'^(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{6,})');

                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (!passwordRegex.hasMatch(value)) {
                                  return 'Password must be 7+ characters with a letter, number,\nand symbol.';
                                }
                                return null;
                              },
                              // onFieldSubmitted: (value) => _login(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      // context.push('/forgotPassword');
                                      ForgotPasswordSheet.show(context);
                                    },
                                    child: Text('Forgot password?'))
                              ],
                            ),
                            CustomButton(
                              label: 'Login',
                              onPressed: provider.login,
                              loading: provider.loading,
                            ),
                            TextButton(
                              onPressed: () {
                                context.push('/register');
                              },
                              child:
                                  const Text("Don't have an account? Register"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
