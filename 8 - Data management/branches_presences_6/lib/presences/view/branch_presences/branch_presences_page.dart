import 'package:branches_presences_6/app/utils/spinner_dialog.dart';
import 'package:branches_presences_6/app/view/home_view.dart';
import 'package:branches_presences_6/branches/branches.dart';
import 'package:branches_presences_6/presences/bloc/presences/presences_cubit.dart';
import 'package:branches_presences_6/presences/bloc/presences_form/presences_form_cubit.dart';
import 'package:branches_presences_6/presences/domain/repository/presences/presences_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/bloc/app_bloc.dart';
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
    User currentUser = context.watch<AppBloc>().state.user;
    context.read<PresencesCubit>().fetchPresencesByBranchId(selectedBranch.id);
    return SafeArea(
      child: BlocProvider(
        create: (context) => PresencesFormCubit(
          branchId: selectedBranch.id,
          username: currentUser.email,
          presencesRepository: context.read<PresencesRepository>(),
        ),
        child: Builder(builder: (context) {
          return BlocConsumer<PresencesFormCubit, PresencesFormState>(
            listenWhen: (previous, current) => previous.status != current.status,
            listener: (context, state) {
              if (state.status == PresencesFormStatus.submissionFailed) {
                navigator.pop();
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                showDialog<void>(
                  context: context,
                  builder: (_) => const ConfirmMessageDialog(
                    message: 'Errore di immissione',
                  ),
                );
              }
              if (state.status == PresencesFormStatus.submissionInProgress) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                SpinnerDialog.buildShowDialog(context);
              }
              if (state.status == PresencesFormStatus.submissionSuccess) {
                navigator.pop();
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                context.read<PresencesCubit>().fetchPresencesByBranchId(selectedBranch.id);
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(content: Text('Operazione effettuata!')),
                  );
                context
                    .read<PresencesFormCubit>()
                    .selectDate(state.selectedDate);
              }
            },
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () => navigator.pushReplacementNamed(HomeView.homeRoute),
                    icon: const Icon(Icons.home),
                  ),
                  title: Text("Presenze ${selectedBranch.name}"),
                  actions: [
                    if (state.status == PresencesFormStatus.initial )
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
                    if (state.status ==
                        PresencesFormStatus.alreadyExists)
                      IconButton(
                        onPressed: () => context
                            .read<PresencesFormCubit>()
                            .onFormSubmitted(true),
                        icon: const Icon(Icons.clear),
                      ),
                  ],
                  centerTitle: true,
                ),
                body: BranchPresencesView(
                  presences: context.watch<PresencesCubit>().state.presences,
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
