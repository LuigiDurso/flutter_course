import '../../models/user.dart';

abstract class UsersDataProvider {
  User? getUserByEmailAndPassword(String email, String password);

  User? updateUser(
    int id,
    String name,
    String email,
    String imagePath,
    String about,
  );
}
