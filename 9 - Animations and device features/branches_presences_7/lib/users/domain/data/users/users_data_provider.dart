import '../../models/user.dart';

class AuthenticationResponse {
  final String token;
  final String refreshToken;
  final String email;

  AuthenticationResponse({
    required this.token,
    required this.refreshToken,
    required this.email,
  });

  factory AuthenticationResponse.empty() {
    return AuthenticationResponse( token: '', refreshToken: '', email: '');
  }
}

abstract class UsersDataProvider {
  Future<User> getUserByEmail(String email);
  Future<AuthenticationResponse> authenticate(String email, String password);
  Future<User> updateUser(
    int id,
    String name,
    String email,
    String imagePath,
    String about,
  );
}
