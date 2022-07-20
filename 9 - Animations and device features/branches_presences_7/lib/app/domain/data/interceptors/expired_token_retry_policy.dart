import 'dart:convert';

import 'package:branches_presences_7/app/domain/data/constants/firebase_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_interceptor/models/response_data.dart';
import 'package:http_interceptor/models/retry_policy.dart';
import 'package:http/http.dart' as http;

class ExpiredTokenRetryPolicy extends RetryPolicy {

  final _httpClient = http.Client();
  final FlutterSecureStorage secureStorage;

  ExpiredTokenRetryPolicy({
    required this.secureStorage,
  });

  @override
  Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
    if (response.statusCode == 401) {
      var token = await secureStorage.read(key: "refreshApiToken");

      final userRequest = Uri.https(
          FirebaseConstants.tokenBaseUrl,
          '/v1/token',
          { "key": FirebaseConstants.apiKey });

      var userLoginRequestBody = {
        "grant_type": "refresh_token",
        "refresh_token": token,
      };

      final userResponse =
      await _httpClient.post(userRequest, body: userLoginRequestBody);

      final loginJson =
      userResponse.body.isNotEmpty && userResponse.body != 'null'
          ? (jsonDecode(
        userResponse.body,
      )) as Map<String, dynamic>
          : <String, dynamic>{};

      await secureStorage.write(key: "apiToken", value: loginJson["id_token"]);
      return true;
    }
    return false;
  }
}