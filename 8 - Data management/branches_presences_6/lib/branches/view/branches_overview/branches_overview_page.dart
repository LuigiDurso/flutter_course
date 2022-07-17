import 'package:branches_presences_6/app/utils/async_call_status.dart';
import 'package:branches_presences_6/app/widget/base_app_bar.dart';
import 'package:branches_presences_6/branches/bloc/branches_cubit.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/utils/spinner_dialog.dart';
import '../../../app/widget/confirm_message_dialog.dart';
import 'branches_overview.dart';

class BranchesPage extends StatelessWidget {
  const BranchesPage({Key? key}) : super(key: key);

  Future<void> _fetchBranches(BuildContext ctx) async {
    await ctx.read<BranchesCubit>().fetchAllBranches();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var navigator = Navigator.of(context);
    var theme = Theme.of(context);

    return ColorfulSafeArea(
      color: theme.primaryColor,
      child: Scaffold(
        appBar: mediaQuery.orientation == Orientation.landscape
            ? AppBar(
                leading: Image.asset(
                  'assets/images/si2001-logo-bianco.png',
                ),
              )
            : const BaseAppBar(
                title: "Sedi",
              ),
        body: BlocListener<BranchesCubit, BranchesState>(
          listener: (context, state) {
            if (state.status == AsyncCallStatus.failure) {
              SpinnerDialog.closeSpinnerDialog(navigator);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              showDialog<void>(
                context: context,
                builder: (_) => const ConfirmMessageDialog(
                  message: 'Errore di caricamento',
                ),
              );
            }
            if (state.status == AsyncCallStatus.loading) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              SpinnerDialog.buildShowDialog(context);
            }
            if (state.status == AsyncCallStatus.success) {
              SpinnerDialog.closeSpinnerDialog(navigator);
            }
          },
          child: Builder(
            builder: (context) {
              var branches = context.read<BranchesCubit>().state.branches;
              if ( branches.isEmpty) {
                _fetchBranches(context);
              }
              return RefreshIndicator(
                onRefresh: () => _fetchBranches(context),
                child: const BranchesOverview(),
              );
            }
          ),
        ),
      ),
    );
  }
}
