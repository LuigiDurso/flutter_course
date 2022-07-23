import 'package:branches_presences/app/view/home/home_view.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presences/bloc/presences/presences_cubit.dart';
import '../../bloc/app/app_bloc.dart';

class HomePage extends StatelessWidget {
  static const String homeRoute = '/home';

  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var userBranch = context.read<AppBloc>().state.userBranch;
    context.read<PresencesCubit>().fetchPresencesByBranchId(userBranch.uid);

    return ColorfulSafeArea(
      color: theme.primaryColor,
      child: const Scaffold(
        body: HomeView(),
      ),
    );
  }
}