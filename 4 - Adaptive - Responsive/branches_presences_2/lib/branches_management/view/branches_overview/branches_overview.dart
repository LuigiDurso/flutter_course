import 'package:flutter/material.dart';

import '../../branches.dart';

class BranchesOverview extends StatefulWidget {
  const BranchesOverview({Key? key}) : super(key: key);

  @override
  State<BranchesOverview> createState() => _BranchesOverviewState();
}

class _BranchesOverviewState extends State<BranchesOverview> {
  final _branches = [
    {'name': 'Treviolo', 'address': 'xxx', 'imagePath': 'https://picsum.photos/id/1/500/500'},
    {'name': 'Milano', 'address': 'yyy', 'imagePath': 'https://picsum.photos/id/2/500/500'},
    {'name': 'Battipaglia', 'address': 'xxx', 'imagePath': 'https://picsum.photos/id/3/500/500'},
    {'name': 'Palermo', 'address': 'xxx', 'imagePath': 'https://picsum.photos/id/4/500/500'},
    {'name': 'Messina', 'address': 'xxx', 'imagePath': 'https://picsum.photos/id/5/500/500'},
    {'name': 'Pescara', 'address': 'xxx', 'imagePath': 'https://picsum.photos/id/6/500/500'},
    {'name': 'Roma', 'address': 'xxx', 'imagePath': 'https://picsum.photos/id/7/500/500'}
  ];

  late Branch _currentBranch;


  @override
  void initState() {
    _currentBranch = Branch.fromMap(_branches[0]);
    super.initState();
  }

  void _setCurrentBranch(Branch newBranch) {
    if (newBranch == null) {
      return;
    }
    setState(() {
      _currentBranch = newBranch;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          pinned: true,
          delegate: BranchesOverviewSliverAppBar(
              expandedHeight: 200.0,
              currentBranch: _currentBranch.name,
              branchImage: _currentBranch.imagePath,
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(top: 5)),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, index) => BranchGridItem(
              branch: Branch.fromMap(_branches[index]),
              actionFn: () {
                _setCurrentBranch(Branch.fromMap(_branches[index]));
              },
            ),
            childCount: _branches.length,
          ),
        ),
      ],
    );
  }
}
