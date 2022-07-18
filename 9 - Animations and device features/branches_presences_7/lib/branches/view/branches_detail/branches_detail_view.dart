import 'package:flutter/material.dart';

import '../../domain/models/branch.dart';

class BranchesDetailView extends StatelessWidget {

  final Branch selectedBranch;

  const BranchesDetailView({
    Key? key,
    required this.selectedBranch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 250,
          child: Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: [
              Hero(
                tag: selectedBranch.name,
                child: ClipRect(
                  child: FadeInImage.assetNetwork(
                    image: selectedBranch.imagePath,
                    fit: BoxFit.cover,
                    height: 70,
                    placeholder: 'assets/images/branch-placeholder.png',
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                height: 70,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedBranch.name,
                          style:
                          theme.textTheme.headline5!.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          selectedBranch.address,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center( child: Text("coadci",),),
        ),
      ],
    );
  }
}
