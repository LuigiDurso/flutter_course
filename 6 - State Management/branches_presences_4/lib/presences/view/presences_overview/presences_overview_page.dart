import 'package:branches_presences_4/branches/branches.dart';
import 'package:branches_presences_4/users/domain/data/users/local_users.dart';
import 'package:branches_presences_4/users/domain/repository/users/users_repository.dart';
import 'package:flutter/material.dart';

import '../../../users/domain/models/user.dart';
import '../../domain/data/presences/local_presences.dart';
import '../../domain/repository/presences/presences_repository.dart';
import 'presences_overview.dart';

class PresencesPage extends StatelessWidget {

  final PresencesRepository presencesRepository = PresencesRepository(
      presencesDataProvider: LocalPresences()
  );
  final UsersRepository usersRepository = UsersRepository(
      usersDataProvider: LocalUsers()
  );
  final BranchesRepository branchesRepository = BranchesRepository(
    branchesDataProvider: LocalBranches()
  );

  PresencesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User currentUser = usersRepository.getCurrentUser();
    Branch userBranch = branchesRepository.findBranchById(currentUser.branchId);
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
          currentPresences: presencesRepository.getPresencesByBranchIdAndDateAfter(
              currentUser.branchId,
              DateTime.now()
          ),
        ),
      ),
    );
  }
}
