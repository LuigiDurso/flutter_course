import 'package:branches_presences_7/app/view/home/home_page.dart';
import 'package:branches_presences_7/branches/domain/models/branch.dart';
import 'package:branches_presences_7/branches/view/branches_detail/branches_detail_page.dart';
import 'package:branches_presences_7/users/view/login/login_page.dart';
import 'package:branches_presences_7/users/view/view.dart';
import 'package:flutter/material.dart';

import '../../branches/view/branches_overview/branches_overview_page.dart';
import '../../presences/view/branch_presences/branch_presences_page.dart';
import '../bloc/navigation/navigation_cubit.dart';
import 'navigator_observer.dart';

class RouteSettingsData {
  final dynamic data;
  final ScreenOrientation rotation;

  RouteSettingsData({this.data, required this.rotation});
}

RouteSettings rotationSettings(
    RouteSettings settings, ScreenOrientation rotation) {
  return settings.copyWith(
      arguments:
          RouteSettingsData(rotation: rotation, data: settings.arguments));
}

Route? onGenerateRoute(RouteSettings routeSettings) {
  var args = routeSettings.arguments;
  switch (routeSettings.name) {
    case HomePage.homeRoute:
      return MaterialPageRoute(
        builder: (_) => const HomePage(),
        settings: rotationSettings(routeSettings, ScreenOrientation.portraitOnly),
      );
    case LoginPage.loginRoute:
      return MaterialPageRoute(
        builder: (_) => const LoginPage(),
        settings:
        rotationSettings(routeSettings, ScreenOrientation.portraitOnly),
      );
    case UserDetailPage.userDetailRoute:
      return MaterialPageRoute(
        builder: (_) => const UserDetailPage(),
        settings:
            rotationSettings(routeSettings, ScreenOrientation.portraitOnly),
      );
    case EditUserDetailPage.userDetailRoute:
      return MaterialPageRoute(
        builder: (_) => const EditUserDetailPage(),
        settings:
        rotationSettings(routeSettings, ScreenOrientation.portraitOnly),
      );
    case BranchPresencesPage.branchPresencesRoute:
      return MaterialPageRoute(
        builder: (_) => BranchPresencesPage(
          selectedBranch: args as Branch,
        ),
        settings:
            rotationSettings(routeSettings, ScreenOrientation.portraitOnly),
      );
    case BranchesDetailPage.branchesDetailRoute:
      return MaterialPageRoute(
        builder: (_) => BranchesDetailPage(
          selectedBranch: args as Branch,
        ),
        settings:
        rotationSettings(routeSettings, ScreenOrientation.portraitOnly),
      );
  }
  return null;
}

Widget getPageByNavBarItem(BuildContext context, NavigationState state) {
  switch( state.navbarItem ) {
    case NavbarItem.home:
      return const HomePage();
    case NavbarItem.branches:
      return const BranchesPage();
    case NavbarItem.profile:
      return const UserDetailPage();
    default:
      return const HomePage();
  }
}
