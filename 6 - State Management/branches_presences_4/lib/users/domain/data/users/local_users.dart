import 'package:branches_presences_4/users/domain/data/users/users_data_provider.dart';

import '../../models/user.dart';

class LocalUsers implements UsersDataProvider {
  final User _currentUser = const User(
    id: 1,
    name: 'Luigi',
    lastname: 'Durso',
    branchId: 3,
    email: 'luigi.durso@si2001.it',
    imagePath: 'https://picsum.photos/id/10/500/500',
    about: 'La mia descrizione, addio!'
  );

  @override
  User getCurrentUser() {
    return _currentUser;
  }

}