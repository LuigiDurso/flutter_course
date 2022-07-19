import 'dart:convert';

import 'package:branches_presences_7/users/domain/data/users/users_data_provider.dart';
import 'package:branches_presences_7/users/domain/models/user.dart';
import 'package:http/http.dart' as http;

class UsersNotFoundFailure implements Exception {}

class UsersRequestFailure implements Exception {}

class FirebaseUsersClient implements UsersDataProvider {
  final _baseUrl = "si-presences-default-rtdb.firebaseio.com";
  final _loginBaseUrl = "identitytoolkit.googleapis.com";

  final http.Client _httpClient;

  FirebaseUsersClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  @override
  Future<User> getUserByEmail(String email) async {
    final userRequest = Uri.https(
        _baseUrl, '/users.json',
        {"orderBy": "\"email\"", "equalTo": "\"$email\""},
    );
    final userResponse = await _httpClient.get(userRequest);

    if (userResponse.statusCode != 200) {
      throw UsersRequestFailure();
    }

    final usersJson = userResponse.body.isNotEmpty && userResponse.body != '{}'
        ? (jsonDecode(
            userResponse.body,
          )) as Map<String, dynamic>
        : <String, dynamic>{};

    return usersJson.values
        .where((element) => element != null)
        .map((e) => User.fromMap(e))
        .first;
  }

  @override
  Future<String> authenticate(String email, String password) async {
    final userRequest = Uri.https(
        _loginBaseUrl,
        '/v1/accounts:signInWithPassword',
        {"key": "AIzaSyCwcGzqreAiYqRsdkUtvkVUbcUd5lA0ioQ"});
    var userLoginRequestBody = {
      "email": email,
      "password": password,
      "returnSecureToken": "true"
    };

    final userResponse =
        await _httpClient.post(userRequest, body: userLoginRequestBody);

    if (userResponse.statusCode != 200) {
      throw UsersRequestFailure();
    }

    final loginJson =
        userResponse.body.isNotEmpty && userResponse.body != 'null'
            ? (jsonDecode(
                userResponse.body,
              )) as Map<String, dynamic>
            : <String, dynamic>{};

    if (loginJson.isEmpty || loginJson["idToken"] == null) {
      throw UsersNotFoundFailure();
    }
    return loginJson["idToken"];
  }

  @override
  Future<User> updateUser(
      int id, String name, String email, String imagePath, String about) async {
    final userRequest = Uri.https(
      _baseUrl,
      '/users/$id.json',
    );
    final userResponse = await _httpClient.patch(
      userRequest,
      body: jsonEncode({
        "name": name,
        "email": email,
        "imagePath": imagePath,
        "about": about,
      }),
    );

    if (userResponse.statusCode != 200) {
      throw UsersRequestFailure();
    }
    return await getUserByEmail(email);
  }
}
