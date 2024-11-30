import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:suvidha/models/auth_token.dart';
import 'package:suvidha/models/backend_response.dart';
import 'package:suvidha/models/user.dart';

class BackendService extends ChangeNotifier {
  final Dio _dio = Dio(BaseOptions(baseUrl: "http://127.0.0.1:4000/api/"));

  //register user
  Future<BackendResponse<AuthToken>> registerUser({
    required User user, 
  }) async {
    try {
      Response resp =
          await _dio.post('auth/registeruser', data: user.toJSON());

      BackendResponse<AuthToken> response = BackendResponse<AuthToken>.fromJson(
        resp.data,
        (json) => AuthToken.fromJson(json),
      );
      debugPrint(response.result.toString());

      return response;
    } catch (e) {
      debugPrint("Error while registering   user: ${e.toString()}");
      rethrow;
    }
  }

  // login

  Future<BackendResponse<AuthToken>> login({
    required String email,
    required String password,
  }) async {
    Response resp = await _dio.post('auth/login', data: {
      'email': email,
      'password': password,
    });

    BackendResponse<AuthToken> response = BackendResponse<AuthToken>.fromJson(
      resp.data,
      (json) => AuthToken.fromJson(json),
    );

    return response;
  }

  // refresh token request
  Future<BackendResponse<AuthToken>> refreshToken({
    required String refreshToken,
  }) async {
    Response resp = await _dio.post('auth/refreshToken', data: {
      'refresh_token': refreshToken,
    });

    BackendResponse<AuthToken> response = BackendResponse<AuthToken>.fromJson(
      resp.data,
      (json) => AuthToken.fromJson(json),
    );

    return response;
  }
}
