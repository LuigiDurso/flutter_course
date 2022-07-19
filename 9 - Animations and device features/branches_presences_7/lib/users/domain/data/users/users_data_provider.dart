import '../../models/user.dart';

abstract class UsersDataProvider {
  Future<User> getUserByEmail(String email);
  Future<String> authenticate(String email, String password);
  Future<User> updateUser(
    int id,
    String name,
    String email,
    String imagePath,
    String about,
  );
}
