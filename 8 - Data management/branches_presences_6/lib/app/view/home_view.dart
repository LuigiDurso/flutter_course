import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../branches/view/branches_overview/branches_overview_page.dart';
import '../../presences/bloc/presences/presences_cubit.dart';
import '../../presences/view/presences_overview/presences_overview_page.dart';
import '../../users/domain/models/user.dart';
import '../bloc/app_bloc.dart';

class HomeView extends StatelessWidget {
  static const String homeRoute = '/home';

  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (ctx) => MediaQuery.of(ctx).orientation == Orientation.portrait
          ? const BranchesPage()
          : _buildLandscapeWidget(ctx),
    );
  }

  Widget _buildLandscapeWidget(BuildContext context) {
    User currentUser = context.read<AppBloc>().state.user;
    context.read<PresencesCubit>().fetchPresencesByBranchIdAndDateAfter(
      currentUser.branchId,
      DateTime.now(),
    );
    return const PresencesPage();
  }
}
