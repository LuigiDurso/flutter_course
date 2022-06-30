import 'dart:math';

import 'package:branches_presences_2/branches_management/domain/data/branches/local_branches.dart';
import 'package:branches_presences_2/branches_management/domain/data/presences/local_presences.dart';
import 'package:branches_presences_2/branches_management/domain/repository/branches/branches_repository.dart';
import 'package:branches_presences_2/branches_management/domain/repository/presences/presences_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../branches.dart';

class BranchesOverview extends StatefulWidget {
  const BranchesOverview({Key? key}) : super(key: key);

  @override
  State<BranchesOverview> createState() => _BranchesOverviewState();
}

class _BranchesOverviewState extends State<BranchesOverview> {

  late List<Branch> _branches;
  late Branch _currentBranch;
  late List<Presence> _currentPresences;

  BranchesRepository branchesRepository = BranchesRepository(
      branchesDataProvider: LocalBranches()
  );
  PresencesRepository presencesRepository = PresencesRepository(
      presencesDataProvider: LocalPresences()
  );


  @override
  void initState() {
    _branches = branchesRepository.getAllBranches();
    _currentBranch = _branches[0];
    _currentPresences = presencesRepository.getPresencesByBranchIdAndDateAfter(
      _currentBranch.id,
      DateTime.now()
    );
    super.initState();
  }

  void _setCurrentBranch(Branch newBranch) {
    setState(() {
      _currentBranch = newBranch;
      _currentPresences = presencesRepository.getPresencesByBranchIdAndDateAfter(
          _currentBranch.id,
          DateTime.now()
      );
    });
  }

  Widget _buildPortraitBody(context) {
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

  Widget _buildLandscapeBody(context, MediaQueryData mediaQuery) {
    var theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Card(
            elevation: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Image.network(_currentBranch.imagePath,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Text(
                          _currentBranch.name,
                          style: theme.textTheme.titleLarge,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(2)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Text(
                          _currentBranch.address,
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: ListView.builder(
            itemBuilder: (_, index) => ListTile(
              title: Text(
                  _currentPresences[index].username
              ),
              subtitle: Text(
                  DateFormat.yMMMd().format(_currentPresences[index].dateTime)
              ),
            ),
            itemCount: _currentPresences.length,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.orientation == Orientation.portrait ?
        _buildPortraitBody(context) : _buildLandscapeBody(context, mediaQuery);
  }
}
