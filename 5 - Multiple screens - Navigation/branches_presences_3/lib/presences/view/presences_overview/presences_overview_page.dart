import 'package:flutter/material.dart';

import '../../domain/data/presences/local_presences.dart';
import '../../domain/repository/presences/presences_repository.dart';
import 'presences_overview.dart';

class PresencesPage extends StatelessWidget {
  final _userBranch = {
    'id': 3,
    'name': 'Battipaglia',
    'address': 'xxx',
    'imagePath': 'https://picsum.photos/id/3/500/500'
  };
  final PresencesRepository presencesRepository = PresencesRepository(
      presencesDataProvider: LocalPresences()
  );

  PresencesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Image.asset(
            'assets/images/si2001-logo-bianco.png',
          ),
        ),
        body: PresencesOverview(
          branchId: _userBranch['id'] as int,
          branchImagePath: _userBranch['imagePath'] as String,
          branchName: _userBranch['name'] as String,
          currentPresences: presencesRepository.getPresencesByBranchIdAndDateAfter(
              _userBranch['id'] as int,
              DateTime.now()
          ),
        ),
      ),
    );
  }
}
