import 'package:flutter/material.dart';

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
        body: const BranchesOverview(),
      ),
    );
  }
}