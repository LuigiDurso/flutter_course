import 'package:flutter/material.dart';

import '../../domain/data/presences/local_presences.dart';
import '../../domain/repository/presences/presences_repository.dart';

class BranchPresencesPage extends StatelessWidget {
  static const String branchPresencesRoute = '/branch-presences';

  final PresencesRepository presencesRepository = PresencesRepository(
      presencesDataProvider: LocalPresences()
  );

  BranchPresencesPage({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var navigator = Navigator.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () => navigator.pushReplacementNamed('/'),
            child: Image.asset(
              'assets/images/si2001-logo-bianco.png',
            ),
          ),
          title: const Text("Presenze in sede"),
          centerTitle: true,
        ),
        body: const Center( child: Text("Presenze")),
      ),
    );
  }
}
