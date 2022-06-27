import 'package:flutter/material.dart';

class MainBranchAppBar extends StatelessWidget implements PreferredSizeWidget {

  const MainBranchAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Image.asset(
        'assets/images/si2001-logo-bianco.png',
      ),
      title: const Text("Sedi Si2001"),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
