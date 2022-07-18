import 'package:branches_presences_7/app/widget/base_app_bar.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';

import '../../domain/models/branch.dart';
import 'branches_detail_view.dart';

class BranchesDetailPage extends StatelessWidget {
  static const String branchesDetailRoute = "/branches-detail";

  final Branch selectedBranch;

  const BranchesDetailPage({
    Key? key,
    required this.selectedBranch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return ColorfulSafeArea(
      color: theme.primaryColor,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Dettaglio sede"),
          centerTitle: true,
        ),
        body: BranchesDetailView(selectedBranch: selectedBranch,),
      ),
    );
  }
}
