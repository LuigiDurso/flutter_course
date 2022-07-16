import 'package:branches_presences_6/app/bloc/app/app_bloc.dart';
import 'package:branches_presences_6/users/bloc/edit_user_detail_form/edit_user_detail_form_bloc.dart';
import 'package:branches_presences_6/users/domain/repository/users/users_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view.dart';

class EditUserDetailPage extends StatelessWidget {
  static const String userDetailRoute = '/edit-user-detail';

  const EditUserDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Modifica utente",
            style: theme.textTheme.titleLarge!.copyWith(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocProvider(
          create: (BuildContext context) => EditUserDetailFormBloc(
            usersRepository: context.read<UsersRepository>(),
            user: context.read<AppBloc>().state.user,
          ),
          child: EditUserDetailView(
            currentUser: context.read<AppBloc>().state.user,
          ),
        ),
      ),
    );
  }
}
