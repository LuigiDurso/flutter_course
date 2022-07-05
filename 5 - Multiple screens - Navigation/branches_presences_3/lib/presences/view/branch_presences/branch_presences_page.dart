import 'package:branches_presences_3/branches/branches.dart';
import 'package:flutter/material.dart';

import '../../domain/data/presences/local_presences.dart';
import '../../domain/repository/presences/presences_repository.dart';
import 'branch_presences_view.dart';

class BranchPresencesPage extends StatelessWidget {
  static const String branchPresencesRoute = '/branch-presences';

  final int selectedBranch;

  final PresencesRepository presencesRepository = PresencesRepository(
      presencesDataProvider: LocalPresences()
  );
  final BranchesRepository branchRepository = BranchesRepository(
    branchesDataProvider: LocalBranches(),
  );

  BranchPresencesPage({
    Key? key,
    required this.selectedBranch
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var navigator = Navigator.of(context);
    Branch selectedBranchObj = branchRepository.findBranchById(selectedBranch);
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
            presences: presencesRepository.getPresencesByBranchId(selectedBranch),
        ),
      ),
    );
  }
}
