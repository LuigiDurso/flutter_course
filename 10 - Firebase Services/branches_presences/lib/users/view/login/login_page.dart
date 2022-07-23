import 'package:branches_presences/users/bloc/login_form/login_form_bloc.dart';
import 'package:branches_presences/users/domain/repository/users/users_repository.dart';
import 'package:branches_presences/users/view/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  static const String loginRoute = '/login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginFormBloc(
            usersRepository: context.read<UsersRepository>(),
        ),
        child: const LoginView(),
      ),
    );
  }
}
