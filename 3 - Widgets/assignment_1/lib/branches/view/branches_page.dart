import 'package:flutter/material.dart';

import 'branches_overview.dart';

class BranchesPage extends StatelessWidget {
  const BranchesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: const <Widget>[
          IconButton(
            key: Key('homePage_user_iconButton'),
            icon: Icon(Icons.person),
            onPressed: null,
          )
        ],
      ),
      body: BranchesOverview(),
    );
  }
}