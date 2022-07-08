import 'package:branches_presences_4/app/view/home_view.dart';
import 'package:branches_presences_4/users/view/user_detail/user_detail_page.dart';
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
    case '/':
      return MaterialPageRoute(
        builder: (_) => const HomeView(),
        settings: rotationSettings(routeSettings, ScreenOrientation.rotating),
      );
    case UserDetailPage.userDetailRoute:
      return MaterialPageRoute(
        builder: (_) => UserDetailPage(),
        settings:
            rotationSettings(routeSettings, ScreenOrientation.portraitOnly),
      );
    case BranchPresencesPage.branchPresencesRoute:
      return MaterialPageRoute(
        builder: (_) => BranchPresencesPage(
          selectedBranch: args as int,
        ),
        settings:
            rotationSettings(routeSettings, ScreenOrientation.portraitOnly),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const HomeView(),
        settings: rotationSettings(routeSettings, ScreenOrientation.rotating),
      );
  }
}
