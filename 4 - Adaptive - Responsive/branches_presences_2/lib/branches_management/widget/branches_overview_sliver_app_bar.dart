import 'package:flutter/material.dart';

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
    final mediaQuery = MediaQuery.of(context);

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
            child: Container(),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          height: AppBar().preferredSize.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/si2001-logo-bianco.png',
                height: AppBar().preferredSize.height,
              ),
              Text(
                currentBranch,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 23,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        if (shrinkOffset < (expandedHeight / 2))
          Positioned(
            width: mediaQuery.size.width,
            height: 50,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              // opacity: (1 - shrinkOffset / expandedHeight),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  currentBranch,
                  style: theme.textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w700, color: Colors.white),
                ),
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
