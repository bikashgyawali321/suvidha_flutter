import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_button.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  ForgotPasswordProvider(
      this.context, this.email, this.otp, this.newPassword, this.vsync)
      : tabController = TabController(length: 3, vsync: vsync);
  String email;
  String otp;
  String newPassword;
  bool obsecureText = true;
  final formKey = GlobalKey<FormState>();
  final TabController tabController;
  final BuildContext context;
  final TickerProvider vsync;
  int tabIndex = 0;
  FocusNode focusNode = FocusNode();
  //toggle password visibility
  void togglePasswordVisibility() {
    obsecureText = !obsecureText;
    notifyListeners();
  }

  //set the tab  index
  void setTabIndex() {
    tabController.index = tabIndex;
    notifyListeners();
  }

  //verify email address
  void verifyEmail() {
    if (!(formKey.currentState?.validate() ?? false)) return;
    focusNode.unfocus();
    tabIndex = 1;
    //TODO: send otp email
    tabController.animateTo(1);
    //set the focus node to false
    notifyListeners();
  }

  //verify otp
  void verifyOTP() {
    if (!(formKey.currentState?.validate() ?? false)) return;
    focusNode.unfocus();
    tabIndex = 2;
    //TODO: verify otp code here
    tabController.animateTo(2);
    notifyListeners();
  }

  //submit new password
  void submitNewPassword() {
    if (!(formKey.currentState?.validate() ?? false)) return;
    //TODO: submit new password here
    focusNode.unfocus();

    //navigate to login screen
    Navigator.pop(context);
  }
}

class ForgotPasswordSheet extends StatefulWidget {
  const ForgotPasswordSheet({super.key});
  static Future<T?> show<T>(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => ForgotPasswordSheet());
  }

  @override
  _ForgotPasswordSheetState createState() => _ForgotPasswordSheetState();
}

class _ForgotPasswordSheetState extends State<ForgotPasswordSheet>
    with SingleTickerProviderStateMixin {
  int tabIndex = 0;
  @override
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ForgotPasswordProvider(context, '', '', '', this),
      child: Consumer<ForgotPasswordProvider>(
        builder: (context, provider, child) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Text('Forgot Password?',
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text(
                    'Let\'s reset it',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TabBar(
                  controller: provider.tabController,
                  labelPadding: EdgeInsets.only(right: 16),
                  onTap: (index) {
                    provider.setTabIndex();
                  },
                  dividerColor: Colors.transparent,
                  tabs: const [
                    Tab(
                      text: '1 Email',
                    ),
                    Tab(
                      text: '2 OTP',
                    ),
                    Tab(
                      text: '3 New Password',
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Form(
                      key: provider.formKey,
                      child: TabBarView(
                        controller: provider.tabController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          // Email field
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 16),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    provider.email = value;
                                  });
                                },
                                focusNode: provider.focusNode,
                                validator: (value) {
                                  RegExp emailRegex = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

                                  if (value == null || value.isEmpty) {
                                    return "Email is required";
                                  }
                                  if (!emailRegex.hasMatch(value)) {
                                    return "Invalid email address";
                                  }

                                  return null;
                                },
                                autofocus: false,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              CustomButton(
                                label: 'Continue',
                                onPressed: provider.verifyEmail,
                              ),
                            ],
                          ),
                          // OTP field
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Verification code',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Enter the 6 digit verification OTP code sent to \n ${provider.email}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.grey),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    provider.otp = value;
                                  });
                                },
                                keyboardType: TextInputType.number,
                                autofocus: true,
                                focusNode: provider.focusNode,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "OTP is required";
                                  }
                                  if (value.length != 6) {
                                    return "OTP should be of 6 digits";
                                  }
                                    return null;

                                },
                                maxLength: 6,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomButton(
                                label: 'Verify',
                                onPressed: provider.verifyOTP,
                              ),
                            ],
                          ),
                          // New password field
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'New Password',
                                  suffixIcon: IconButton(
                                    icon: Icon(provider.obsecureText
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                    onPressed: () {
                                      provider.togglePasswordVisibility();
                                    },
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    provider.newPassword = value;
                                  });
                                },
                                focusNode: provider.focusNode,
                                validator: (value) {
                                  RegExp passwordRegex = RegExp(
                                      r'^(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{6,})');
                                  if (value == null || value.isEmpty) {
                                    return "Password is required";
                                  }

                                  if (!passwordRegex.hasMatch(value)) {
                                    return "Password must be 7+ characters with a letter, number,\nand symbol.'";
                                  }
                                  return null;
                                },
                                obscureText: provider.obsecureText,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Confirm Password',
                                  suffixIcon: IconButton(
                                    icon: Icon(provider.obsecureText
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                    onPressed: () {
                                      provider.togglePasswordVisibility();
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  RegExp passwordRegex = RegExp(
                                      r'^(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{6,})');
                                  if (value == null || value.isEmpty) {
                                    return "Password is required";
                                  }
                                  if (!passwordRegex.hasMatch(value)) {
                                    return "Password must be 7+ characters with a letter, number,\nand symbol.'";
                                  }
                                  if (value != provider.newPassword) {
                                    return "Passwords do not match";
                                  }
                                  return null;
                                },
                                obscureText: provider.obsecureText,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomButton(
                                label: 'Submit',
                                onPressed: provider.submitNewPassword,
                              ),
                            ],
                          ),
                        ],
                      ),
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
