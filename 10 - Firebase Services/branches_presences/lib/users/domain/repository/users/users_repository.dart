import 'package:branches_presences/users/domain/data/users/users_data_provider.dart';
import 'package:branches_presences/users/domain/models/user.dart';

class UsersRepository {
  final UsersDataProvider usersDataProvider;

  UsersRepository({required this.usersDataProvider});

  Future<void> authenticate(String email, String password) async {
    await usersDataProvider.authenticate(email, password);
  }

  Future<void> logOut() async {
    await usersDataProvider.logOut();
  }

  Future<User> updateUser(
    String id,
    String name,
    String email,
    String imagePath,
    String about,
  ) {
    return usersDataProvider.updateUser(id, name, email, imagePath, about);
  }

  Future<User> getUserByEmail(String email) {
    return usersDataProvider.getUserByEmail(email);
  }
}
