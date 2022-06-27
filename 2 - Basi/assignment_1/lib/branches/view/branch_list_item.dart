import 'package:flutter/material.dart';

import '../domain/models/branch.dart';

class BranchListItem extends StatelessWidget {
  final Branch branch;
  final VoidCallback? actionFn;

  const BranchListItem({
    Key? key,
    required this.branch,
    this.actionFn
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(branch.name)
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: actionFn ?? () {},
                icon: const Icon(Icons.remove_red_eye_outlined),
              ),
            )
          ],
        )
    );
  }
}
