import 'package:flutter/material.dart';

import '../domain/domain.dart';

class BranchGridItem extends StatelessWidget {
  final Branch branch;
  final VoidCallback? actionFn;

  const BranchGridItem({Key? key, required this.branch, this.actionFn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  branch.imagePath,
                  fit: BoxFit.cover,
                  height: 70,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      branch.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      branch.address,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(
              flex: 1,
              child: Icon(
                  Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
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
