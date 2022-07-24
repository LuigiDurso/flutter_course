import 'package:branches_presences/app/bloc/app/app_bloc.dart';
import 'package:branches_presences/users/bloc/edit_user_detail_form/edit_user_detail_form_bloc.dart';
import 'package:branches_presences/users/domain/repository/file/file_storage_repository.dart';
import 'package:branches_presences/users/domain/repository/users/users_repository.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view.dart';

class EditUserDetailPage extends StatelessWidget {
  static const String userDetailRoute = '/edit-user-detail';

  const EditUserDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return ColorfulSafeArea(
      color: theme.primaryColor,
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
            fileStorageRepository: context.read<FileStorageRepository>(),
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
