import 'package:branches_presences_7/app/utils/spinner_dialog.dart';
import 'package:branches_presences_7/branches/branches.dart';
import 'package:branches_presences_7/presences/bloc/presences/presences_cubit.dart';
import 'package:branches_presences_7/presences/bloc/presences_form/presences_form_cubit.dart';
import 'package:branches_presences_7/presences/domain/repository/presences/presences_repository.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/bloc/app/app_bloc.dart';
import '../../../app/utils/async_call_status.dart';
import '../../../app/widget/confirm_message_dialog.dart';
import '../../../users/domain/models/user.dart';
import 'branch_presences_view.dart';

class BranchPresencesPage extends StatelessWidget {
  static const String branchPresencesRoute = '/branch-presences';

  final Branch selectedBranch;

  const BranchPresencesPage({Key? key, required this.selectedBranch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var navigator = Navigator.of(context);
    var theme = Theme.of(context);

    User currentUser = context.read<AppBloc>().state.user;

    return ColorfulSafeArea(
      color: theme.primaryColor,
      child: BlocProvider(
        create: (context) => PresencesFormCubit(
          branchId: selectedBranch.id,
          username: currentUser.email,
          presencesRepository: context.read<PresencesRepository>(),
        ),
        child: Builder(builder: (context) {
          return MultiBlocListener(
            listeners: [
              BlocListener<PresencesFormCubit, PresencesFormState>(
                listenWhen: (previous, current) =>
                    previous.status != current.status,
                listener: (context, state) {
                  if (state.status == PresencesFormStatus.submissionFailed) {
                    SpinnerDialog.closeSpinnerDialog(navigator);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    showDialog<void>(
                      context: context,
                      builder: (_) => const ConfirmMessageDialog(
                        message: 'Errore di immissione',
                      ),
                    );
                  }
                  if (state.status ==
                      PresencesFormStatus.submissionInProgress) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    SpinnerDialog.buildShowDialog(context);
                  }
                  if (state.status == PresencesFormStatus.submissionSuccess) {
                    SpinnerDialog.closeSpinnerDialog(navigator);
                    context
                        .read<PresencesCubit>()
                        .fetchPresencesByBranchId(selectedBranch.id);
                    context
                        .read<PresencesFormCubit>()
                        .selectDate(state.selectedDate);
                  }
                },
              ),
              BlocListener<PresencesCubit, PresencesState>(
                listenWhen: (previous, current) =>
                    previous.status != current.status,
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
              ),
            ],
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: AppBar().preferredSize,
                child: BlocBuilder<PresencesFormCubit, PresencesFormState>(
                  builder: (context, state) {
                    return AppBar(
                      title: Text("Presenze ${selectedBranch.name}"),
                      actions: [
                        if (state.status == PresencesFormStatus.initial)
                          Image.asset(
                            'assets/images/si2001-logo-bianco.png',
                          ),
                        if (state.status == PresencesFormStatus.dateSelected)
                          IconButton(
                            onPressed: () {
                              context
                                  .read<PresencesFormCubit>()
                                  .onFormSubmitted(false);
                            },
                            icon: const Icon(Icons.add),
                          ),
                        if (state.status == PresencesFormStatus.alreadyExists)
                          IconButton(
                            onPressed: () => context
                                .read<PresencesFormCubit>()
                                .onFormSubmitted(true),
                            icon: const Icon(Icons.clear),
                          ),
                      ],
                      centerTitle: true,
                    );
                  },
                ),
              ),
              body: BranchPresencesView(
                branchId: selectedBranch.id,
              ),
            ),
          );
        }),
      ),
    );
  }
}
