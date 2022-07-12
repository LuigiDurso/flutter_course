import 'package:branches_presences_5/users/domain/data/users/users_data_provider.dart';

import '../../models/user.dart';

class LocalUsers implements UsersDataProvider {
  final List<User> _users = [
    const User(
      id: 1,
      name: 'Luigi',
      lastname: 'Durso',
      branchId: 3,
      email: 'luigi.durso@si2001.it',
      password: 'password',
      imagePath: 'https://picsum.photos/id/10/500/500',
      about: 'La mia descrizione, addio!',
    ),
    const User(
      id: 2,
      name: 'Test',
      lastname: 'Test',
      branchId: 1,
      email: 'test.test@si2001.it',
      password: 'password',
      imagePath: 'https://picsum.photos/id/11/500/500',
      about: 'La mia descrizione test, addio!',
    ),
    const User(
      id: 3,
      name: 'Test Due',
      lastname: 'Test Due',
      branchId: 2,
      email: 'test.due@si2001.it',
      password: 'password',
      imagePath: 'https://picsum.photos/id/12/500/500',
      about: 'La mia descrizione test due, addio!',
    ),
    const User(
      id: 4,
      name: 'Test Tre',
      lastname: 'Test Tre',
      branchId: 4,
      email: 'test.tre@si2001.it',
      password: 'password',
      imagePath: 'https://picsum.photos/id/13/500/500',
      about: 'La mia descrizione test tre, addio!',
    ),
    const User(
      id: 5,
      name: 'Test Quattro',
      lastname: 'Test  Quattro',
      branchId: 5,
      email: 'test.quattro@si2001.it',
      password: 'password',
      imagePath: 'https://picsum.photos/id/14/500/500',
      about: 'La mia descrizione test quattro, addio!',
    )
  ];

  @override
  User? getUserByEmailAndPassword(String email, String password) {
    List<User> foundUser = _users
        .where((User u) => u.email == email && u.password == password)
        .toList();
    if (foundUser.isNotEmpty && foundUser.length == 1) {
      return foundUser.first;
    }
    return null;
  }

  @override
  User? updateUser(
    int id,
    String name,
    String email,
    String imagePath,
    String about
  ) {
    int foundIndex = _users.indexWhere((User u) => id == u.id);
    if (foundIndex < 0) {
      return null;
    }
    _users[foundIndex] = _users[foundIndex].copyWith(
        name: name, email: email, imagePath: imagePath, about: about
    );
    return _users[foundIndex];
  }
}
