import 'package:flutter/material.dart';

import 'branches/view/branches_page.dart';

void main() {
  runApp(const AppView());
}

class AppView extends StatelessWidget {
  const AppView({
    Key? key,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BranchesPage(),
    );
  }
}