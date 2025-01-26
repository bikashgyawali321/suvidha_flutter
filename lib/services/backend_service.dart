import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:suvidha/models/auth_models/login_request.dart';
import 'package:suvidha/models/auth_models/register_request.dart';
import 'package:suvidha/models/backend_response.dart';
import 'package:suvidha/services/interceptors/token_interceptor.dart';
import '../models/auth_models/update_user_request.dart';
import '../models/bookings/booking_model.dart';
import 'interceptors/log_interceptor.dart';

class BackendService extends ChangeNotifier {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://127.0.0.1:4040/api",
    ),
  )
    ..interceptors.add(TokenInterceptor())
    ..interceptors.add(CustomLogInterceptor());

  //custom request handler for all methods

  Future<BackendResponse> handleRequest(
      {required Future<Response> request,
      required String titleOfRequest}) async {
    try {
      final res = await request;
      return BackendResponse(
        title: res.data['title'],
        message: res.data['message'],
        result: res.data['data'],
        statusCode: res.statusCode,
      );
    } on DioError catch (dioError) {
      if (dioError.response != null) {
        debugPrint(
            "Server responded with error while $titleOfRequest: ${dioError.response?.data}");
        return BackendResponse(
          title: dioError.response?.data['title'] ?? '',
          result: dioError.response?.data['data'],
          statusCode: dioError.response?.statusCode,
          errorMessage: dioError.response?.data['message'],
        );
      } else {
        debugPrint(
            "Request failed with error while $titleOfRequest: ${dioError.message}");
        throw Exception(
            'Unable to process request $titleOfRequest: ${dioError.message}');
      }
    } catch (e) {
      debugPrint(
          "Request failed with error while $titleOfRequest: ${e.toString()}");
      throw Exception(
          'Unable to process request $titleOfRequest: ${e.toString()}');
    }
  }

//register user
  Future<BackendResponse> registerUser(RegisterRequest request) async {
    return await handleRequest(
      request: _dio.post('/auth/registerUser', data: request.toJson()),
      titleOfRequest: 'registering user',
    );
  }

  // Login user
  Future<BackendResponse> login(LoginRequest request) async {
    return await handleRequest(
      request: _dio.post('/auth/login', data: request.toJson()),
      titleOfRequest: 'logging in',
    );
  }

  // Verify email
  Future<BackendResponse> verifyEmail(
      {required String email, required num otp}) async {
    return await handleRequest(
      request: _dio.post('/auth/verifyOtp', data: {
        'email': email,
        'otp': otp,
      }),
      titleOfRequest: 'verifying email',
    );
  }

  // Resend verification email
  Future<BackendResponse> resendVerificationEmail(
      {required String email}) async {
    return await handleRequest(
      request: _dio.post(
        '/auth/resendVerificationEmail',
        data: {
          'email': email,
        },
      ),
      titleOfRequest: 'resending verification email',
    );
  }

  // Send forgot password request
  Future<BackendResponse> sendForgotPasswordRequest({
    required String email,
  }) async {
    return await handleRequest(
      request: _dio.post(
        '/auth/forgetPassword',
        data: {
          'email': email,
        },
      ),
      titleOfRequest: 'sending forgot password request',
    );
  }

  // Verify reset password token
  Future<BackendResponse> verifyResetPasswordToken({
    required String email,
    required num token,
  }) async {
    return await handleRequest(
      request: _dio.post('/auth/verifyOtp', data: {
        'email': email,
        'otp': token,
      }),
      titleOfRequest: 'verifying reset password token',
    );
  }

  // Reset password
  Future<BackendResponse> resetPassword({
    required String email,
    required num token,
    required String password,
    required String confirmPassword,
  }) async {
    return await handleRequest(
      request: _dio.post(
        '/auth/resetPassword',
        data: {
          'email': email,
          'otp': token,
          'password': password,
          'confirmPassword': confirmPassword,
        },
      ),
      titleOfRequest: 'resetting password',
    );
  }

  // Refresh token
  Future<BackendResponse> refreshToken({
    required String refreshToken,
  }) async {
    return await handleRequest(
      request: _dio.post(
        '/auth/refreshToken',
        data: {
          'refreshToken': refreshToken,
        },
      ),
      titleOfRequest: 'refreshing token',
    );
  }

  // Change password
  Future<BackendResponse> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    return await handleRequest(
      request: _dio.post(
        '/auth/changePassword',
        data: {
          'oldPassword': oldPassword,
          'newPassword': newPassword,
          'confirmPassword': confirmPassword,
        },
      ),
      titleOfRequest: 'changing password',
    );
  }

  // Get user details
  Future<BackendResponse> getUserDetails() async {
    return await handleRequest(
      request: _dio.get('/auth/me'),
      titleOfRequest: 'getting user details',
    );
  }

  //update user details

  Future<BackendResponse> updateUserDetails(
      {required UpdateUserRequest data}) async {
    return await handleRequest(
      request: _dio.patch(
        '/auth/user',
        data: data.toJson(),
      ),
      titleOfRequest: 'updating user details',
    );
  }

  //add fcm token

  Future<BackendResponse> addFcmToken({required String fcmToken}) async {
    return await handleRequest(
      request: _dio.post('/auth/addFcm', data: {'fcmToken': fcmToken}),
      titleOfRequest: 'adding fcm token',
    );
  }

  //remove fcm token
  Future<BackendResponse> removeFcmToken({required String fcmToken}) async {
    return await handleRequest(
      request: _dio.post('/auth/removefcm', data: {'fcmToken': fcmToken}),
      titleOfRequest: 'removing fcm token',
    );
  }

  // Post image method
  Future<BackendResponse> postImage({required File image}) async {
    final imageName = image.path.split('/').last;
    final fileExtension = imageName.split('.').last.toLowerCase();
    final supportedFormats = ['jpg', 'jpeg', 'png'];
    if (!supportedFormats.contains(fileExtension)) {
      throw Exception('Unsupported file format: $fileExtension');
    }

    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        image.path,
        filename: imageName,
        contentType: MediaType('image', fileExtension),
      ),
    });

    return await handleRequest(
      request: _dio.post('/image/details', data: formData),
      titleOfRequest: 'posting image',
    );
  }

  // get all services name
  Future<BackendResponse> getAllServiceNames() async {
    return await handleRequest(
      request: _dio.get('/service/serviceName'),
      titleOfRequest: 'getting all service',
    );
  }

  //get all services
  Future<BackendResponse> getAllServices() async {
    return await handleRequest(
      request: _dio.get('/service/details'),
      titleOfRequest: 'getting all services',
    );
  }

  //get recommended service
  Future<BackendResponse> getRecommendedServices() async {
    return await handleRequest(
      request: _dio.get('/service/recommended'),
      titleOfRequest: 'getting recommended service',
    );
  }

  //add booking
  Future<BackendResponse> addBooking({
    required NewBooking newBooking,
  }) async {
    return await handleRequest(
      request: _dio.post(
        '/booking/',
        data: newBooking.toJson(),
      ),
      titleOfRequest: 'adding booking',
    );
  }

  //get all bookings
  Future<BackendResponse> getAllBookings() async {
    return await handleRequest(
        request: _dio.get(
          '/booking/',
        ),
        titleOfRequest: "fetching all bookings by userId");
  }
}
