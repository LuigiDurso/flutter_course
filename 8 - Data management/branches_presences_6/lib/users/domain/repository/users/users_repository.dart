import 'package:branches_presences_6/users/domain/data/users/users_data_provider.dart';
import 'package:branches_presences_6/users/domain/models/user.dart';

class UsersRepository {
  final UsersDataProvider usersDataProvider;

  UsersRepository({required this.usersDataProvider});

  User? getUserByEmailAndPassword(String email, String password) {
    return usersDataProvider.getUserByEmailAndPassword(email, password);
  }

  User? updateUser(
    int id,
    String name,
    String email,
    String imagePath,
    String about,
  ) {
    return usersDataProvider.updateUser(id, name, email, imagePath, about);
  }
}
