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
        Container(
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
        Container(
          alignment: Alignment.topCenter,
          child: Opacity(
            opacity: 1 - ( shrinkOffset / expandedHeight ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipOval(
                child: Material(
                  color: Colors.transparent,
                  child: Ink.image(
                    image: NetworkImage(user.imagePath,),
                    fit: BoxFit.cover,
                    width: 125,
                    height: 125,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: shrinkOffset > (expandedHeight / 1.25) ?
          Alignment.center : Alignment.bottomCenter,
          height: AppBar().preferredSize.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('${user.name} ${user.lastname}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 23,
                  ),
                ),
              ],
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
