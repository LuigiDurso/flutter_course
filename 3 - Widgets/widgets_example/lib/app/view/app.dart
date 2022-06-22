import 'package:flutter/material.dart';
import 'package:widgets_example/theme/theme.dart';

import '../../branches_management/view/branches_overview/branches_overview_page.dart';

class AppView extends StatelessWidget {
  const AppView({
    Key? key,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const BranchesPage(),
    );
  }
}