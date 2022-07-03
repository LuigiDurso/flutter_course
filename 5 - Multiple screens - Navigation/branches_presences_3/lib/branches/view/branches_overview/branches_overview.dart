import 'package:flutter/material.dart';

import '../../branches.dart';
import '../../domain/data/branches/local_branches.dart';
import '../../domain/repository/branches/branches_repository.dart';

class BranchesOverview extends StatefulWidget {
  const BranchesOverview({Key? key}) : super(key: key);

  @override
  State<BranchesOverview> createState() => _BranchesOverviewState();
}

class _BranchesOverviewState extends State<BranchesOverview> {
  late List<Branch> _branches;
  late Branch _currentBranch;

  BranchesRepository branchesRepository =
      BranchesRepository(branchesDataProvider: LocalBranches());

  @override
  void initState() {
    _branches = branchesRepository.getAllBranches();
    _currentBranch = _branches[0];
    super.initState();
  }

  void _setCurrentBranch(Branch newBranch) {
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
              branch: _branches[index],
              actionFn: () {
                _setCurrentBranch(_branches[index]);
              },
            ),
            childCount: _branches.length,
          ),
        ),
      ],
    );
  }
}
