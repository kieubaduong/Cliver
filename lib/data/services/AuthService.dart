import 'dart:convert';

import 'package:cliver_mobile/app/core/values/strings.dart';
import 'package:get/get_connect/connect.dart';

import '../models/user.dart';

class AuthService extends GetConnect {
  static final AuthService instance = AuthService._initInstance();

  AuthService._initInstance() {
    timeout = const Duration(seconds: 10);
  }

  Future<Response> login({
    required User user,
  }) async {
    return await post("$api_url/auth/login", jsonEncode(user));
  }

  Future<Response> signup({
    required User user,
  }) async {
    return await post(
      "$api_url/auth/register",
      jsonEncode(user),
    );
  }

  Future<Response> verifyEmail({
    required String email,
    required String code,
  }) async {
    Map data = {"email": email, "code": code};
    var body = jsonEncode(data);

    return await post(
      "$api_url/auth/verify-account",
      body,
    );
  }

  Future<Response> getUserData({required token}) async {
    return await get(
      "$api_url/auth/verify",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
    );
  }

  Future<Response> getWallet({required token}) async {
    return await get(
      "$api_url/account/info",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
    );
  }

  Future<Response> verifySeller({required token}) async {
    return await post(
      "$api_url/account/verify-seller",
      {
        "identityCardImage":
            "https://imgv3.fotor.com/images/homepage-feature-card/Upload-an-image.jpg"
      }, //fake link
      headers: <String, String>{
        'Authorization': token,
      },
    );
  }
}
