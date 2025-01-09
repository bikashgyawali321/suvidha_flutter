import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suvidha/screens/bottom_sheets/forgot_password_sheet.dart';
import 'package:suvidha/widgets/custom_button.dart';

import '../../providers/theme_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = "", password = "";
  final _formKey = GlobalKey<FormState>();
  bool _obsecureText = true;
  bool loading = false;
  // late AuthProvider _authProvider;
  // _login() async {
  //   if (!(_formKey.currentState?.validate() ?? false)) return;
  //   setState(() {
  //     loading = true;
  //   });
  //   await _authProvider.login(email: username, password: password).then((e) {
  //     context.go('/splash');
  //   }).catchError((e) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text(e.toString())));
  //   }).whenComplete(() {
  //     setState(() {
  //       loading = false;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // _authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
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
                        'सुविधा',
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
                  key: _formKey,
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
                          onChanged: (value) {
                            setState(() {
                              username = value;
                            });
                          },
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
                                  onPressed: () {
                                    setState(() {
                                      _obsecureText = !_obsecureText;
                                    });
                                  },
                                  icon: Icon(_obsecureText
                                      ? Icons.visibility_off
                                      : Icons.visibility))),
                          obscureText: _obsecureText,
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
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
                          onPressed: null,
                          loading: loading,
                        ),
                        TextButton(
                          onPressed: () {
                            context.push('/register');
                          },
                          child: const Text("Don't have an account? Register"),
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
    );
  }
}
