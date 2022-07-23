import '../../models/user.dart';

abstract class UsersDataProvider {
  Future<User> getUserByEmail(String email);
  Future<void> authenticate(String email, String password);
  Future<void> signUp(String email, String password);
  Future<void> logOut();
  Future<User> updateUser(
    String id,
    String name,
    String email,
    String imagePath,
    String about,
  );
}
