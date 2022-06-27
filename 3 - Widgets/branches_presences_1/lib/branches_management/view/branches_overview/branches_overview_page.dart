import 'package:flutter/material.dart';

import '../../../theme/widget/main_branch_app_bar.dart';
import 'branches_overview.dart';

class BranchesPage extends StatelessWidget {
  const BranchesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: MainBranchAppBar(),
        body: BranchesOverview(),
      ),
    );
  }
}