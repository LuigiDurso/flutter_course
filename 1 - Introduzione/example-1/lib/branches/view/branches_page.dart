import 'package:example_1/branches/view/branches_overview.dart';
import 'package:flutter/material.dart';

class BranchesPage extends StatelessWidget {
  const BranchesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Si2001 Branches"),
        actions: const [
          IconButton(
            key: Key('homePage_user_iconButton'),
            icon: Icon(Icons.person),
            onPressed: null,
          ),
        ],
      ),
      body: const BranchesOverview(),
    );
  }
}
