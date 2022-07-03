import 'package:branches_presences_3/app/view/home_view.dart';
import 'package:branches_presences_3/users/view/user_detail/user_detail_page.dart';
import 'package:flutter/material.dart';

Route? onGenerateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const HomeView());
    case UserDetailPage.userDetailRoute:
      return MaterialPageRoute(builder: (_) => UserDetailPage());
    default:
      return MaterialPageRoute(builder: (_) => const HomeView());
  }
}