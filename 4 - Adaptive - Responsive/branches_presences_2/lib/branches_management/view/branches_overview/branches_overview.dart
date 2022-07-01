import 'dart:math';

import 'package:branches_presences_2/branches_management/domain/data/branches/local_branches.dart';
import 'package:branches_presences_2/branches_management/domain/data/presences/local_presences.dart';
import 'package:branches_presences_2/branches_management/domain/repository/branches/branches_repository.dart';
import 'package:branches_presences_2/branches_management/domain/repository/presences/presences_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../branches.dart';
import '../../widget/bar_chart_presences.dart';

class BranchesOverview extends StatefulWidget {
  const BranchesOverview({Key? key}) : super(key: key);

  @override
  State<BranchesOverview> createState() => _BranchesOverviewState();
}

class _BranchesOverviewState extends State<BranchesOverview> {
  late List<Branch> _branches;
  late Branch _currentBranch;
  late List<Presence> _currentPresences;

  BranchesRepository branchesRepository =
      BranchesRepository(branchesDataProvider: LocalBranches());
  PresencesRepository presencesRepository =
      PresencesRepository(presencesDataProvider: LocalPresences());

  @override
  void initState() {
    _branches = branchesRepository.getAllBranches();
    _currentBranch = _branches[0];
    _currentPresences = presencesRepository.getPresencesByBranchIdAndDateAfter(
        _currentBranch.id, DateTime.now());
    super.initState();
  }

  void _setCurrentBranch(Branch newBranch) {
    setState(() {
      _currentBranch = newBranch;
      _currentPresences =
          presencesRepository.getPresencesByBranchIdAndDateAfter(
              _currentBranch.id, DateTime.now());
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: LayoutBuilder(
                  builder: (_, constraints) => Stack(
                    children: [
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            _currentBranch.imagePath,
                            fit: BoxFit.cover,
                            width: constraints.maxWidth,
                            height: constraints.maxHeight,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 3,
                        right: 3,
                        left: 3,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _currentBranch.name,
                              style: theme.textTheme.headline5!.copyWith(
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 2,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  color: const Color(0xff2c4260),
                  child: BarChartPresences(currentPresences: _currentPresences,),
                ),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: ListView.builder(
            itemBuilder: (_, index) => Card(
              child: ListTile(
                title: Text(_currentPresences[index].username),
                subtitle: Text(DateFormat.yMMMd()
                    .format(_currentPresences[index].dateTime)),
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
    return mediaQuery.orientation == Orientation.portrait
        ? _buildPortraitBody(context)
        : _buildLandscapeBody(context, mediaQuery);
  }
}
