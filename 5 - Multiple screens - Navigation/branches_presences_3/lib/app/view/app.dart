import 'package:flutter/material.dart';

import '../../branches/view/branches_overview/branches_overview_page.dart';
import '../../presences/view/presences_overview/presences_overview_page.dart';
import '../../theme/theme.dart';

class AppView extends StatelessWidget {
  const AppView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: Builder(
        builder: (ctx) => MediaQuery.of(ctx).orientation == Orientation.portrait
            ? const BranchesPage()
            : PresencesPage(),
      ),
    );
  }
}
