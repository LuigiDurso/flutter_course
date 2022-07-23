import 'package:branches_presences/app/widget/home_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/widget/list_divider.dart';
import '../../bloc/branches/branches_cubit.dart';
import '../../branches.dart';

class BranchesOverview extends StatelessWidget {

  const BranchesOverview({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var branches = context.watch<BranchesCubit>().state.branches;

    return ListView.builder(
        itemBuilder: (_, index) => Column(
          children: [
            BranchGridItem(
              branch: branches[index],
            ),
            if (index < (branches.length - 1))
              const ListDivider(),
          ],
        ),
      itemCount: branches.length,
    );
  }
}
