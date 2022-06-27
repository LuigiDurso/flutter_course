import 'package:flutter/material.dart';

class SelectedBranchCard extends StatelessWidget {
  final String currentBranch;
  final String branchImage;

  const SelectedBranchCard({
    Key? key,
    required this.currentBranch,
    required this.branchImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.headline5!.copyWith(color: Colors.white);

    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(branchImage),
        ),
      ),
      child: Container(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            currentBranch,
            style: titleStyle,
          ),
        ),
      ),
    );
  }
}