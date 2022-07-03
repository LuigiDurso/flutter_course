import 'package:branches_presences_3/users/domain/data/users/local_users.dart';
import 'package:branches_presences_3/users/domain/repository/users/users_repository.dart';
import 'package:flutter/material.dart';

import '../view.dart';

class UserDetailPage extends StatelessWidget {
  static const String userDetailRoute = '/user-detail';

  final UsersRepository usersRepository = UsersRepository(
      usersDataProvider: LocalUsers()
  );

  UserDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Profilo utente",
            style: theme.textTheme.titleLarge!.copyWith(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: UserDetailView(
          currentUser: usersRepository.getCurrentUser(),
        ),
      ),
    );
  }
}
