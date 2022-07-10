import 'package:branches_presences_5/users/domain/data/users/users_data_provider.dart';
import 'package:branches_presences_5/users/domain/models/user.dart';

class UsersRepository {
  final UsersDataProvider usersDataProvider;

  UsersRepository({required this.usersDataProvider});

  User getCurrentUser() {
    return usersDataProvider.getCurrentUser();
  }

  User updateCurrentUser(
    String name,
    String email,
    String imagePath,
    String about,
  ) {
    return usersDataProvider.updateCurrentUser(name, email, imagePath, about);
  }
}