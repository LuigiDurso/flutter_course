import 'package:branches_presences_3/app/view/home_view.dart';
import 'package:branches_presences_3/users/view/user_detail/user_detail_page.dart';
import 'package:flutter/material.dart';

import '../../presences/view/branch_presences/branch_presences_page.dart';

Route? onGenerateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const HomeView());
    case UserDetailPage.userDetailRoute:
      return MaterialPageRoute(builder: (_) => UserDetailPage());
    case BranchPresencesPage.branchPresencesRoute:
      return MaterialPageRoute(builder: (_) => BranchPresencesPage());
    default:
      return MaterialPageRoute(builder: (_) => const HomeView());
  }
}

// TODO: impedire cambio orientamento dispositivo in alcune pagine