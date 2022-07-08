import 'package:branches_presences_4/branches/branches.dart';
import 'package:branches_presences_4/presences/bloc/presences_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/bloc/app_bloc.dart';
import 'branch_presences_view.dart';

class BranchPresencesPage extends StatelessWidget {
  static const String branchPresencesRoute = '/branch-presences';

  final int selectedBranch;

  const BranchPresencesPage({
    Key? key,
    required this.selectedBranch
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var navigator = Navigator.of(context);
    Branch selectedBranchObj = context.read<AppBloc>().state.userBranch;
    context.read<PresencesCubit>().fetchPresencesByBranchId(selectedBranch);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => navigator.pushReplacementNamed('/'),
            icon: const Icon(Icons.home),
          ),
          title: Text("Presenze ${selectedBranchObj.name}"),
          actions: [
            Image.asset('assets/images/si2001-logo-bianco.png',),
          ],
          centerTitle: true,
        ),
        body: BranchPresencesView(
            presences: context.watch<PresencesCubit>().state.presences,
        ),
      ),
    );
  }
}
