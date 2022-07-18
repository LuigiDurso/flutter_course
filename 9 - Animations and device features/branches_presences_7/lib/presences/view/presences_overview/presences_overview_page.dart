import 'package:branches_presences_7/app/bloc/app/app_bloc.dart';
import 'package:branches_presences_7/branches/bloc/branches/branches_cubit.dart';
import 'package:branches_presences_7/branches/branches.dart';
import 'package:branches_presences_7/presences/bloc/presences/presences_cubit.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/utils/async_call_status.dart';
import '../../../app/utils/spinner_dialog.dart';
import '../../../app/widget/confirm_message_dialog.dart';
import '../../../users/domain/models/user.dart';
import 'presences_overview.dart';

class PresencesPage extends StatelessWidget {
  const PresencesPage({Key? key}) : super(key: key);

  Future<void> _fetchPresencesByBranchIdAndDateAfter(
    BuildContext context,
    int branchId,
    DateTime dateTime,
  ) async {
    await context.read<PresencesCubit>().fetchPresencesByBranchIdAndDateAfter(
          branchId,
          dateTime,
        );
  }

  @override
  Widget build(BuildContext context) {
    var navigator = Navigator.of(context);
    var theme = Theme.of(context);

    User currentUser = context.read<AppBloc>().state.user;
    Branch userBranch = context.read<AppBloc>().state.userBranch;

    return ColorfulSafeArea(
      color: theme.primaryColor,
      child: Scaffold(
        appBar: AppBar(
          leading: Image.asset(
            'assets/images/si2001-logo-bianco.png',
          ),
        ),
        body: BlocConsumer<PresencesCubit, PresencesState>(
          listenWhen: (previous, current) => previous.status != current.status,
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
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () => _fetchPresencesByBranchIdAndDateAfter(
                context,
                currentUser.branchId,
                DateTime.now(),
              ),
              child: PresencesOverview(
                branchId: currentUser.branchId,
                branchImagePath: userBranch.imagePath,
                branchName: userBranch.name,
                currentPresences:
                    context.select((PresencesCubit value) => value.state.presences),
              ),
            );
          },
        ),
      ),
    );
  }
}
