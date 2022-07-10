import '../../models/user.dart';

abstract class UsersDataProvider {
  User getCurrentUser();

  User updateCurrentUser(
    String name,
    String email,
    String imagePath,
    String about,
  );
}
