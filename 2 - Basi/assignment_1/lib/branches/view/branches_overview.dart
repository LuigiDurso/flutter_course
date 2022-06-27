import 'package:flutter/material.dart';

import '../domain/models/branch.dart';
import 'branch_list_item.dart';

class BranchesOverview extends StatefulWidget {
  const BranchesOverview({Key? key}) : super(key: key);

  @override
  State<BranchesOverview> createState() => _BranchesOverviewState();
}

class _BranchesOverviewState extends State<BranchesOverview> {
  final _branches = [
    {'name': 'Treviolo', 'address': 'xxx'},
    {'name': 'Milano', 'address': 'yyy'},
    {'name': 'Battipaglia', 'address': 'xxx'},
    {'name': 'Palermo', 'address': 'xxx'},
    {'name': 'Messina', 'address': 'xxx'},
    {'name': 'Pescara', 'address': 'xxx'},
    {'name': 'Roma', 'address': 'xxx'}
  ];

  late String _currentBranch;

  @override
  void initState() {
    super.initState();
    _currentBranch = _branches[0]['name'] as String;
  }

  void _setCurrentBranch(newBranch) {
    if (newBranch == null) {
      return;
    }
    setState(() {
      _currentBranch = newBranch;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Card(
        child: Container(
            width: double.infinity,
            height: 100,
            padding: const EdgeInsets.all(20),
            child: Center(child: Text(_currentBranch))),
      ),
      const Divider(),
      ..._branches.map((e) => BranchListItem(
        branch: Branch.fromMap(e),
        actionFn: () {
          _setCurrentBranch(e['name'] as String);
        },
      )).toList()
    ]);
  }
}
