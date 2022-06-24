import 'package:flutter/material.dart';

import '../../branches_management/view/branches_overview/branches_overview_page.dart';
import '../../theme/theme.dart';

class AppView extends StatelessWidget {
  const AppView({
    Key? key,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const BranchesPage(),
    );
  }
}