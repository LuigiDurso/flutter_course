import 'package:branches_presences_4/users/domain/data/users/users_data_provider.dart';
import 'package:branches_presences_4/users/domain/models/user.dart';

class UsersRepository {
  final UsersDataProvider usersDataProvider;

  UsersRepository({
    required this.usersDataProvider
  });

  User getCurrentUser() {
    return usersDataProvider.getCurrentUser();
  }
}