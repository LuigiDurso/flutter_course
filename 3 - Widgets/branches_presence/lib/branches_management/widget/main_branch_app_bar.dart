import 'package:flutter/material.dart';

import '../domain/domain.dart';

class MainBranchAppBar extends StatelessWidget {
  final Branch branch;

  const MainBranchAppBar({
    Key? key,
    required this.branch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(branch.name),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.remove_red_eye_outlined),
        ),
      ),
    );
  }
}
