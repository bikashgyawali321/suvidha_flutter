import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:suvidha/models/auth_models/loginRequest.dart';
import 'package:suvidha/models/auth_models/registerRequest.dart';
import 'package:suvidha/models/backend_response.dart';

import '../models/auth_token.dart';
import 'custom_hive.dart';

class BackendService extends ChangeNotifier {
  final Dio _dio = Dio(BaseOptions(
      baseUrl: "http://127.0.0.1:4000/api",
      headers: {"Content-Type": "application/json"}));

  //initialize custom hive to save the token
  CustomHive customHive = CustomHive();

  //register user
  Future<BackendResponse> registerUser(RegisterRequest request) async {
    try {
      Response response = await _dio.post(
        '/auth/registerUser',
        data: request.toJson(),
      );
      debugPrint("Response : ${response.toString()}");
      if (response.statusCode == 200) {
        return BackendResponse.fromJson(response.data);
      } else {
        return BackendResponse(
          title: 'Error',
          message: response.extra["message"] ?? 'Unknown error',
        );
      }
    } catch (e) {
      debugPrint("Error in registering User :${e.toString()}");

      throw Exception('Failed to register user');
    }
  }

  // login

  Future<BackendResponse> loginUser(LoginRequest request) async {
    try {
      Response response = await _dio.post(
        '/auth/login',
        data: request.toJson(),
      );

      BackendResponse backendResponse = BackendResponse.fromJson(response.data);

      if (backendResponse.isError) {
        return backendResponse;
      }

      // If successful, map the token data to AuthToken
      if (backendResponse.data != null) {
        AuthToken authToken = AuthToken.fromJson(backendResponse.data);
        await customHive.saveAuthToken(authToken);

        return BackendResponse.fromJson({
          'title': 'success',
          'message': 'Login successful',
          'data': authToken,
        });
      } else {
        throw Exception('Tokens not found in the response data');
      }
    } catch (e) {
      debugPrint("Error while logging in: ${e.toString()}");
      throw Exception('Unable to login');
    }
  }

  //verify email

  Future<BackendResponse> verifyEmail(
      {required String email, required num otp}) async {
    try {
      Response response = await _dio.post(
        '/auth/verifyEmail',
        data: {
          'email': email,
          'otp': otp,
        },
      );

      return BackendResponse.fromJson(response.data);
    } catch (e) {
      debugPrint("Error while verifying email :${e.toString()}");
      throw Exception('Unable to verify email');
    }
  }

  //resend verification email

  Future<BackendResponse> resendVerificationEmail(
      {required String email}) async {
    try {
      Response response = await _dio.post(
        '/auth/resendVerificationEmail',
        data: {
          'email': email,
        },
      );

      return BackendResponse.fromJson(response.data);
    } catch (e) {
      debugPrint("Error while resending verification email :${e.toString()}");
      throw Exception('Unable to resend verification email');
    }
  }

  // reset password request
  Future<BackendResponse> sendForgotPasswordRequest({
    required String email,
  }) async {
    try {
      Response response = await _dio.post(
        '/auth/forgotPassword',
        data: {
          'email': email,
        },
      );

      return BackendResponse.fromJson(response.data);
    } catch (e) {
      debugPrint(
          "Error while sending forgot password request :${e.toString()}");
      throw Exception('Unable to send forgot password request');
    }
  }

//verify reset password token
  Future<BackendResponse> verifyResetPasswordToken({
    required String email,
    required String token,
  }) async {
    try {
      Response resp = await _dio.post('auth/verifyResetPasswordToken', data: {
        'email': email,
        'otp': token,
      });

      BackendResponse response = BackendResponse.fromJson(resp.data);

      return response;
    } catch (e) {
      debugPrint("Error while verifying reset password token :${e.toString()}");
      throw Exception('Unable to verify reset password token');
    }
  }

  // reset password
  Future<BackendResponse> resetPassword({
    required String email,
    required String token,
    required String password,
  }) async {
    try {
      Response response = await _dio.post(
        '/auth/resetPassword',
        data: {
          'email': email,
          'otp': token,
          'password': password,
        },
      );

      return BackendResponse.fromJson(response.data);
    } catch (e) {
      debugPrint("Error while resetting password :${e.toString()}");
      throw Exception('Unable to reset password');
    }
  }

  // refresh token request
  Future<BackendResponse> refreshToken({
    required String refreshToken,
  }) async {
    try {
      Response response = await _dio.post(
        '/auth/refreshToken',
        data: {
          'refreshToken': refreshToken,
        },
      );

      return BackendResponse.fromJson(response.data);
    } catch (e) {
      debugPrint("Error while refreshing token :${e.toString()}");
      throw Exception('Unable to refresh token');
    }
  }

  //change password
  Future<BackendResponse> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      Response response = await _dio.post(
        '/auth/changePassword',
        data: {
          'oldPassword': oldPassword,
          'newPassword': newPassword,
          'confirmPassword': confirmPassword,
        },
      );

      return BackendResponse.fromJson(response.data);
    } catch (e) {
      debugPrint("Error while changing password :${e.toString()}");
      throw Exception('Unable to change password');
    }
  }

  //get user details
  Future<BackendResponse> getUserDetails() async {
    try {
      Response response = await _dio.get('/auth/me');
      return BackendResponse.fromJson(response.data);
    } catch (e) {
      debugPrint("Error while getting user details :${e.toString()}");
      throw Exception('Unable to get user details');
    }
  }
}
