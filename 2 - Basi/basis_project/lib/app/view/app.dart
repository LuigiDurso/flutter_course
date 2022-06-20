import 'package:flutter/material.dart';

import '../../branches/view/branches_page.dart';
import '../theme/theme.dart';

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