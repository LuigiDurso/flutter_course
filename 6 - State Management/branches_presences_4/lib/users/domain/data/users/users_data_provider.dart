import '../../models/user.dart';

abstract class UsersDataProvider {
  User getCurrentUser();
}