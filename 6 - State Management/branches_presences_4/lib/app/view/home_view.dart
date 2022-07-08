import 'package:flutter/material.dart';

import '../../branches/view/branches_overview/branches_overview_page.dart';
import '../../presences/view/presences_overview/presences_overview_page.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (ctx) => MediaQuery.of(ctx).orientation == Orientation.portrait
          ? const BranchesPage()
          : const PresencesPage(),
    );
  }
}
