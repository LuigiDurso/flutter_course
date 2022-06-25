import 'package:flutter/material.dart';

import '../domain/domain.dart';

class BranchGridItem extends StatelessWidget {
  final Branch branch;
  final VoidCallback? actionFn;

  const BranchGridItem({
    Key? key,
    required this.branch,
    this.actionFn
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: ListTile(
        title: Text(branch.name),
        trailing: IconButton(
          onPressed: actionFn ?? () {},
          icon: const Icon(Icons.remove_red_eye_outlined),
        ),
      ),
    );
  }
}
