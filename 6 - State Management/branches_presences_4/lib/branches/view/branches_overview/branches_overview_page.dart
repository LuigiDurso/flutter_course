import 'package:branches_presences_4/app/bloc/app_bloc.dart';
import 'package:branches_presences_4/branches/bloc/branches_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'branches_overview.dart';

class BranchesPage extends StatelessWidget {
  const BranchesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: mediaQuery.orientation == Orientation.landscape ? AppBar(
          leading: Image.asset(
            'assets/images/si2001-logo-bianco.png',
          ),
        ) : null,
        body: Builder(
          builder: (context) {
            var branches = context.watch<BranchesCubit>().state.branches;
            var userBranch = context.watch<AppBloc>().state.userBranch;
            return BranchesOverview(
              branches: branches,
              currentBranch: userBranch,
            );
          }
        ),
      ),
    );
  }
}