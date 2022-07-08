import 'package:flutter/material.dart';

import '../../branches.dart';

class BranchesOverview extends StatelessWidget {
  final List<Branch> branches;
  final Branch currentBranch;

  const BranchesOverview({Key? key,
    required this.branches,
    required this.currentBranch
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          pinned: true,
          delegate: BranchesOverviewSliverAppBar(
            expandedHeight: 200.0,
            currentBranch: currentBranch.name,
            branchImage: currentBranch.imagePath,
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(top: 5)),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, index) => Column(
              children: [
                BranchGridItem(
                  branch: branches[index],
                ),
                if (index < (branches.length - 1))
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
            childCount: branches.length,
          ),
        ),
      ],
    );
  }
}
