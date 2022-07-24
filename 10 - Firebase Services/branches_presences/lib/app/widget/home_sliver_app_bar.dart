import 'package:branches_presences/app/bloc/app/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../users/domain/models/user.dart';
import '../../users/widget/image_profile.dart';

class HomeSliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  HomeSliverAppBar({
    required this.expandedHeight,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final theme = Theme.of(context);
    User user = context.read<AppBloc>().state.user;

    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: Container(
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              color: theme.primaryColor,
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/si2001-logo-bianco.png',
                    height: AppBar().preferredSize.height,
                  ),
                ),
              ],
            ),
          ),
        ),
        if ( shrinkOffset < (expandedHeight / 2) )
          Positioned(
            bottom: 25,
            left: 10,
            right: 10,
            child: Opacity(
              opacity: 1 - (shrinkOffset / expandedHeight),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Ciao ${user.name}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Bentornato in Presenze Si',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 23,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        Opacity(
          opacity: shrinkOffset / expandedHeight,
          child: Container(
            alignment: Alignment.center,
            height: AppBar().preferredSize.height,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text('Presenze Si2001',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 23,
                    ),
                  ),
                ],
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
