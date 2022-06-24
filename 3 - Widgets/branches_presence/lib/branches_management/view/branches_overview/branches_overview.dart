import 'package:flutter/material.dart';

import '../../branches.dart';

class BranchesOverview extends StatefulWidget {
  const BranchesOverview({Key? key}) : super(key: key);

  @override
  State<BranchesOverview> createState() => _BranchesOverviewState();
}

class _BranchesOverviewState extends State<BranchesOverview> {
  final _branches = [
    {'name': 'Treviolo', 'address': 'xxx', 'imagePath': 'https://picsum.photos/500/500'},
    {'name': 'Milano', 'address': 'yyy', 'imagePath': 'https://picsum.photos/500/500'},
    {'name': 'Battipaglia', 'address': 'xxx', 'imagePath': 'https://picsum.photos/500/500'},
    {'name': 'Palermo', 'address': 'xxx', 'imagePath': 'https://picsum.photos/500/500'},
    {'name': 'Messina', 'address': 'xxx', 'imagePath': 'https://picsum.photos/500/500'},
    {'name': 'Pescara', 'address': 'xxx', 'imagePath': 'https://picsum.photos/500/500'},
    {'name': 'Roma', 'address': 'xxx', 'imagePath': 'https://picsum.photos/500/500'}
  ];

  late Branch _currentBranch;


  @override
  void initState() {
    _currentBranch = Branch.fromMap(_branches[0]);
    super.initState();
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
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, index) => BranchListItem(
              branch: Branch.fromMap(_branches[index]),
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

class BranchesOverviewSliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final String currentBranch;
  final String branchImage;

  BranchesOverviewSliverAppBar({
    required this.expandedHeight,
    required this.currentBranch,
    required this.branchImage,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.headline5!.copyWith(color: Colors.white);

    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Container(
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            image: DecorationImage(
              opacity: 1 - (shrinkOffset / expandedHeight),
              fit: BoxFit.cover,
              image: NetworkImage(branchImage),
            ),
          ),
          child: Container(
            color:
                theme.primaryColor.withOpacity(shrinkOffset / expandedHeight),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                    'assets/images/si2001-logo-bianco.png',
                    color: Colors.white.withOpacity(shrinkOffset / expandedHeight),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.person,
                    color: Colors.white.withOpacity(shrinkOffset / expandedHeight),
                  ),
                )
              ],
            ),
          ),
        ),
        Center(
          child: Opacity(
            opacity: shrinkOffset / expandedHeight,
            child: Text(
              currentBranch,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 23,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Text(
              currentBranch,
              style: titleStyle,
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
