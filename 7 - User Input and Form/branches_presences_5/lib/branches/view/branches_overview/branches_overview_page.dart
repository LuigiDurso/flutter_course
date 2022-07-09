import 'package:branches_presences_5/app/bloc/app_bloc.dart';
import 'package:branches_presences_5/branches/bloc/branches_cubit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'branches_overview.dart';

class BranchesPage extends StatelessWidget {
  const BranchesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var branches = context.watch<BranchesCubit>().state.branches;
    var userBranch = context.watch<AppBloc>().state.userBranch;
    return SafeArea(
      child: Scaffold(
        appBar: mediaQuery.orientation == Orientation.landscape ? AppBar(
          leading: Image.asset(
            'assets/images/si2001-logo-bianco.png',
          ),
        ) : null,
        body: BranchesOverview(
          branches: branches,
          currentBranch: userBranch,
        ),
      ),
    );
  }
}