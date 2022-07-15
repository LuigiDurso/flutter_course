import 'package:branches_presences_6/app/bloc/app_bloc.dart';
import 'package:branches_presences_6/branches/bloc/branches_cubit.dart';
import 'package:branches_presences_6/branches/branches.dart';
import 'package:branches_presences_6/presences/bloc/presences/presences_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../users/domain/models/user.dart';
import 'presences_overview.dart';

class PresencesPage extends StatelessWidget {

  const PresencesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User currentUser = context.read<AppBloc>().state.user;
    Branch userBranch = context.read<AppBloc>().state.userBranch;
    context.read<PresencesCubit>().fetchPresencesByBranchIdAndDateAfter(
      currentUser.branchId, DateTime.now()
    );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Image.asset(
            'assets/images/si2001-logo-bianco.png',
          ),
        ),
        body: PresencesOverview(
          branchId: currentUser.branchId,
          branchImagePath: userBranch.imagePath,
          branchName: userBranch.name,
          currentPresences: context.watch<PresencesCubit>().state.presences,
        ),
      ),
    );
  }
}
