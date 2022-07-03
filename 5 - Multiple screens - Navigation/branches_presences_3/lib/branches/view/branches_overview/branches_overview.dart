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
            (_, index) => Column(
              children: [
                BranchGridItem(
                  branch: _branches[index],
                  actionFn: () {
                    _setCurrentBranch(_branches[index]);
                  },
                ),
                if (index < (_branches.length - 1))
                  SizedBox(
                    height: 20,
                    child: Center(
                      child: Container(
                        height: 2,
                        margin: const EdgeInsetsDirectional.only(
                            start: 60,
                            end: 60,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                            ),
                            border: Border.all(
                                color: Colors.transparent,
                                width: 1,
                            ),
                            color: Colors.grey,
                            gradient: LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.5),
                                  Colors.transparent,
                                ],
                            )
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            childCount: _branches.length,
          ),
        ),
      ],
    );
  }
}
