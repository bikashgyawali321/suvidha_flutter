import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:suvidha/models/user.dart';
import 'package:suvidha/providers/theme_provider.dart';
import 'package:suvidha/services/backend.dart';
import '../widgets/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  bool obsecureText = true;
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  late BackendService _service;
  final User user = User(name: '', email: '', password: '', phonenumber: '');

  final PageController pageController = PageController();

  _register() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() {
      loading = true;
    });
    await _service.registerUser(user: user).then((e) {
      context.go('/login');
    }).catchError((e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }).whenComplete(() {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _service = Provider.of<BackendService>(context);
    return Scaffold(
      backgroundColor: primaryDark,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: PageView.builder(
              itemCount: 2,
              controller: pageController,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        
                        Hero(
                          tag: 'logo',
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/icon/app_icon.png',
                                height: 200,
                              ),
                              Text(
                                'सुविधा',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall
                                    ?.copyWith(color: suvidhaWhite),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Card(
                          margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Text(
                                  "Create an account",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                                const SizedBox(height: 25),
                                TextFormField(
                                  decoration: const InputDecoration(
                                      labelText: 'Full Name'),
                                  onChanged: (value) {
                                    setState(() {
                                      user.name = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Full Name is required';
                                    }
                                    if (!RegExp(r'^[a-zA-Z ]+$')
                                        .hasMatch(value)) {
                                      return 'Full Name can only contain alphabets and spaces';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  decoration:
                                      const InputDecoration(labelText: 'Email'),
                                  onChanged: (value) {
                                    setState(() {
                                      user.email = value;
                                    });
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Email is required';
                                    }
                                    if (!RegExp(
                                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                        .hasMatch(value)) {
                                      return 'Enter a valid email address';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  decoration: const InputDecoration(
                                      labelText: 'Phone Number'),
                                  maxLength: 10,
                                  onChanged: (value) {
                                    setState(() {
                                      user.phonenumber = value;
                                    });
                                  },
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Phone Number is required';
                                    }
                                    if (!RegExp(r'^[0-9]{10}$')
                                        .hasMatch(value)) {
                                      return 'Enter a valid phone number';
                                    }
                                    if (value.length != 10) {
                                      return 'Phone number should be of 10 digits';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 6),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    suffixIcon: IconButton(
                                      icon: Icon(obsecureText
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                      onPressed: () => setState(
                                          () => obsecureText = !obsecureText),
                                    ),
                                  ),
                                  obscureText: obsecureText,
                                  onChanged: (value) {
                                    setState(() {
                                      user.password = value;
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
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'Confirm Password',
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              obsecureText = !obsecureText;
                                            });
                                          },
                                          icon: Icon(obsecureText
                                              ? Icons.visibility_off
                                              : Icons.visibility))),
                                  obscureText: obsecureText,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please confirm your password';
                                    }
                                    if (value != user.password) {
                                      return 'Passwords do not match';
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (value) => _register(),
                                ),
                                const SizedBox(height: 20),
                                CustomButton(
                                  label: 'Register',
                                  onPressed: _register,
                                  loading: loading,
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.pop();
                                  },
                                  child: const Text(
                                      'Already have an account? Login'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      Expanded(
                        child: Hero(
                          tag: 'logo',
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.asset(
                                  'assets/icon/app_icon.png',
                                  height: 230,
                                ),
                              ),
                              Expanded(
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
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text('Verify your email',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium),
                              SizedBox(
                                height: 25,
                              ),
                              Text(
                                'A 6 digit verification code has been sent to your email address. Please enter the code below to verify your email address.',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: Colors.deepOrange,
                                        fontStyle: FontStyle.italic),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Verification Code',
                                ),
                                keyboardType: TextInputType.number,
                                maxLength: 6,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Verification code is required';
                                  }
                                  if (value.length != 6) {
                                    return 'Verification code should be of 6 digits';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              CustomButton(
                                label: 'Verify',
                                onPressed: () {},
                                loading: false,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Didn\'t receive the code?'),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text('Resend'),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                }
              }
              
              
              
              
              ),
        ),
      ),
    );
  }
}
