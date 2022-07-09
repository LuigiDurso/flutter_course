import 'package:branches_presences_5/app/bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view.dart';

class UserDetailPage extends StatelessWidget {
  static const String userDetailRoute = '/user-detail';

  const UserDetailPage({Key? key}) : super(key: key);

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
          currentUser: context.read<AppBloc>().state.user
        ),
      ),
    );
  }
}
