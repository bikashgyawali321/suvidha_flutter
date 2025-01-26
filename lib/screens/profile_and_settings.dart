// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:suvidha/models/auth_models/update_user_request.dart';
import 'package:suvidha/screens/auth/bottomsheets/logout.dart';
import 'package:suvidha/screens/bottom_sheets/change_theme_bottom_sheet.dart';
import 'package:suvidha/services/backend_service.dart';
import 'package:suvidha/widgets/custom_button.dart';
import 'package:suvidha/widgets/custom_snackbar.dart';
import 'package:suvidha/widgets/form_bottom_sheet_header.dart';

import '../models/auth_models/user_model.dart';
import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart';
import 'auth/bottomsheets/change_password.dart';

class AccountAndSettingsProvider extends ChangeNotifier {
  late BackendService _backendService;
  late AuthProvider _authProvider;
  late ThemeProvider themeProvider;
  final BuildContext context;
  File? profilePicture;
  AccountAndSettingsProvider({required this.context}) {
    initialize();
  }

  void initialize() {
    loading = false;
    _backendService = Provider.of<BackendService>(context);
    _authProvider = Provider.of<AuthProvider>(context);
    themeProvider = Provider.of<ThemeProvider>(context);
    updateUserRequest = UpdateUserRequest(
        name: _authProvider.user!.name,
        phoneNumber: _authProvider.user!.phoneNumber,
        profilePicture: _authProvider.user!.profilePicture);
  }

  UpdateUserRequest? updateUserRequest;
  final formKey = GlobalKey<FormState>();
  bool? loading;

  Future<void> updateUserProfile() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    loading = true;
    notifyListeners();
    try {
      await Future.delayed(const Duration(seconds: 2));

      final response =
          await _backendService.updateUserDetails(data: updateUserRequest!);
      if (response.statusCode == 200) {
        _authProvider.user = UserModel.fromJson(response.result!);

        SnackBarHelper.showSnackbar(
          context: context,
          successMessage: response.message,
        );
      } else {
        SnackBarHelper.showSnackbar(
          context: context,
          errorMessage: response.errorMessage,
        );
      }
    } catch (e) {
      SnackBarHelper.showSnackbar(
        context: context,
        errorMessage: 'Something went wrong. Please try again later.',
      );
      debugPrint('Error updating user profile: $e');
    } finally {
      loading = false;
      notifyListeners();
      context.pop();
    }
  }

  //add profile picture
  Future<void> addProfilePicture() async {
    try {
      final response = await _backendService.postImage(image: profilePicture!);

      if (response.statusCode == 200 && response.result != null) {
        updateUserRequest!.profilePicture = response.result;
        final updateResponse =
            await _backendService.updateUserDetails(data: updateUserRequest!);
        if (updateResponse.statusCode == 200) {
          _authProvider.user = UserModel.fromJson(updateResponse.result!);
        }
        SnackBarHelper.showSnackbar(
          context: context,
          successMessage: response.message,
        );
        notifyListeners();
      } else {
        SnackBarHelper.showSnackbar(
          context: context,
          errorMessage: response.errorMessage,
        );
      }
    } catch (e) {
      SnackBarHelper.showSnackbar(
        context: context,
        errorMessage: 'Error uploading Organization image',
      );
      notifyListeners();
      debugPrint("Error uploading Organization image: ${e.toString()}");
    } finally {
      notifyListeners();
    }
  }

  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final source = await _showImageSourceDialog();

      if (source != null) {
        final pickedFile = await picker.pickImage(
          source: source,
        );

        if (pickedFile != null) {
          File selectedImage = File(pickedFile.path);
          profilePicture = selectedImage;
          addProfilePicture();
          notifyListeners();
        }
      }
    } catch (e) {
      debugPrint("Error picking image: ${e.toString()}");
    }
  }

  Future<ImageSource?> _showImageSourceDialog() async {
    return showDialog<ImageSource>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Choose an image source"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text("Camera"),
                onTap: () => Navigator.pop(context, ImageSource.camera),
                leading: Icon(Icons.camera_alt),
              ),
              ListTile(
                title: Text("Gallery"),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
                leading: Icon(Icons.photo_library_rounded),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile & Settings',
        ),
        automaticallyImplyLeading: true,
        titleSpacing: 0,
      ),
      body: ChangeNotifierProvider(
        create: (_) => AccountAndSettingsProvider(context: context),
        builder: (context, child) => Consumer<AccountAndSettingsProvider>(
          builder: (context, provider, child) => SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 3,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: provider.pickImage,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                backgroundImage: provider._authProvider.user
                                            ?.profilePicture !=
                                        null
                                    ? NetworkImage(provider
                                        ._authProvider.user!.profilePicture!)
                                    : null,
                                child: provider._authProvider.user
                                            ?.profilePicture ==
                                        null
                                    ? Icon(
                                        Icons.person,
                                        size: 60,
                                      )
                                    : SizedBox(),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              provider._authProvider.user?.name ?? 'N/A',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              provider._authProvider.user?.email ?? 'N/A',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              provider._authProvider.user?.phoneNumber ?? 'N/A',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 10,
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            title: const Text('Edit Profile'),
                            leading: const Icon(Icons.manage_accounts_outlined),
                            trailing: customTrallingIcon(),
                            onTap: () {
                              provider._authProvider.user != null
                                  ? EditProfile.show(context, provider)
                                  : null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 10,
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            title: const Text('Notifications'),
                            leading: const Icon(Icons.notifications),
                            trailing: customTrallingIcon(),
                            onTap: () => context.push('/notification'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 10,
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            title: const Text('Orders History'),
                            leading: const Icon(Icons.history),
                            trailing: customTrallingIcon(),
                            onTap: () {},
                          ),
                          customDivider(),
                          ListTile(
                            title: const Text('Ongoing Orders'),
                            leading: const Icon(Icons.delivery_dining),
                            trailing: customTrallingIcon(),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 10,
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            title: const Text('Change Theme'),
                            leading: Icon(
                              provider.themeProvider.themeMode == ThemeMode.dark
                                  ? Icons.dark_mode
                                  : provider.themeProvider.themeMode ==
                                          ThemeMode.light
                                      ? Icons.light_mode
                                      : Icons.brightness_auto,
                            ),
                            trailing: customTrallingIcon(),
                            onTap: () {
                              ChangeThemeBottomSheet.show(context);
                            },
                            subtitle: Text(
                              provider.themeProvider.themeMode == ThemeMode.dark
                                  ? 'Dark'
                                  : provider.themeProvider.themeMode ==
                                          ThemeMode.light
                                      ? 'Light'
                                      : 'System',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 10,
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            title: const Text('Change Password'),
                            leading: const Icon(Icons.password),
                            trailing: customTrallingIcon(),
                            onTap: () {
                              ChangePassword.show(context);
                            },
                          ),
                          customDivider(),
                          ListTile(
                            title: const Text('Logout'),
                            leading: const Icon(Icons.logout),
                            trailing: customTrallingIcon(),
                            onTap: () async {
                              LogoutScreen.show(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget customDivider() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      child: Divider(
        thickness: 0,
        height: 0,
      ),
    );
  }

  Widget customTrallingIcon() {
    return Icon(
      Icons.chevron_right,
      size: 18,
    );
  }
}

class EditProfile extends StatelessWidget {
  EditProfile({super.key, required this.accountProvider});
  AccountAndSettingsProvider accountProvider;
  static Future<T?> show<T>(
      BuildContext context, AccountAndSettingsProvider provider) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      builder: (context) => EditProfile(
        accountProvider: provider,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Form(
              key: accountProvider.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FormBottomSheetHeader(title: 'Edit Profile'),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: accountProvider._authProvider.user!.name,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter your name',
                    ),
                    onChanged: (value) {
                      accountProvider.updateUserRequest!.name = value;
                    },
                    validator: (value) {
                      if (value == null && value!.isEmpty) {
                        return 'Name is required';
                      }
                      if (value.length < 5) {
                        return 'Name must be at least 5 characters';
                      }
                      if (!RegExp(r'[a-zA-Z]').hasMatch(value)) {
                        return 'Name must contain at least one character';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    initialValue:
                        accountProvider._authProvider.user!.phoneNumber,
                    decoration: InputDecoration(
                        labelText: 'Phone Number',
                        hintText: 'Enter your phone number',
                        prefixIcon: Icon(
                          Icons.phone,
                        )),
                    maxLength: 10,
                    onChanged: (value) {
                      accountProvider.updateUserRequest!.phoneNumber = value;
                    },
                    validator: (value) {
                      if (value == null && value!.isEmpty) {
                        return 'Phone number is required';
                      }
                      if (value.length < 10) {
                        return 'Phone number must be at least 10 characters';
                      }
                      if (!RegExp(r'[0-9]').hasMatch(value)) {
                        return 'Phone number must contain only numbers';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: CustomButton(
                            label: 'Not Now',
                            onPressed: () => context.pop(),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomButton(
                            label: 'Update',
                            onPressed: () =>
                                accountProvider.updateUserProfile(),
                            backgroundColor: Colors.deepOrange,
                            loading: accountProvider.loading ?? false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
