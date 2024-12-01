import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suvidha/widgets/form_bottom_sheet_header.dart';

import '../../widgets/custom_button.dart';

class EmailVerificationProvider extends ChangeNotifier {
  Future<void> verifyEmail() async {
    // todo
    notifyListeners();
  }
  Future<void> resendVerificationEmail() async {
    //todo
    notifyListeners();
  }
  Future<void> registerUser() async {
    //todo
    notifyListeners();
  }s
}

class EmailVerification extends StatelessWidget {
  const EmailVerification(
      {super.key,
      required this.fullname,
      required this.email,
      required this.password,
      required this.phoneNo});
  final String fullname;
  final String email;
  final String password;
  final double phoneNo;
  static Future<T?> show<T>(BuildContext context) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      builder: (context) => const EmailVerification(
          fullname: '', email: '', password: '', phoneNo: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EmailVerificationProvider(),
      child: Consumer<EmailVerificationProvider>(
        builder: (context, provider, child) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                FormBottomSheetHeader(title: 'Verify Email Address'),
                const SizedBox(height: 10),
                const Text(
                  'A verification link has been sent to your email address. Please verify your email address to continue.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                CustomButton(
                  onPressed: () {
                    provider.verifyEmail();
                  },
                  label: 'Resend Verification Email',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
