import 'package:branches_presences_5/app/view/home_view.dart';
import 'package:branches_presences_5/branches/domain/models/branch.dart';
import 'package:branches_presences_5/users/view/login/login_page.dart';
import 'package:branches_presences_5/users/view/view.dart';
import 'package:flutter/material.dart';

import '../../presences/view/branch_presences/branch_presences_page.dart';
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
    case HomeView.homeRoute:
      return MaterialPageRoute(
        builder: (_) => const HomeView(),
        settings: rotationSettings(routeSettings, ScreenOrientation.rotating),
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
  }
  return null;
}
