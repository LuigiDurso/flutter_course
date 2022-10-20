import 'package:flutter/material.dart';

class BranchesOverview extends StatefulWidget {
  const BranchesOverview({Key? key}) : super(key: key);

  @override
  State<BranchesOverview> createState() => _BranchesOverviewState();
}

class _BranchesOverviewState extends State<BranchesOverview> {
  final _branches = [
    {
      'name': 'Treviolo',
      'address': 'xxx'
    },
    {
      'name': 'Milano',
      'address': 'yyy'
    },
    {
      'name': 'Battipaglia',
      'address': 'xxx'
    },
    {
      'name': 'Palermo',
      'address': 'xxx'
    },
    {
      'name': 'Messina',
      'address': 'xxx'
    },
    {
      'name': 'Pescara',
      'address': 'xxx'
    },
    {
      'name': 'Roma',
      'address': 'xxx'
    }
  ];

  var _currentBranch = "Nessuna sede selezionata!";

  @override
  void initState() {
    super.initState();
    print("Sono in initState");
  }

  void _setCurrentBranch(newBranch) {
    print("Hai cliccato $_currentBranch");
    if ( newBranch == null ) {
      return;
    }
    setState(() {
      _currentBranch = newBranch;
    });
  }


  @override
  void dispose() {
    super.dispose();
    print("Sono in dispose");
  }

  @override
  void didUpdateWidget(BranchesOverview oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("Sono in didUpdateWidget");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Container(
              width: double.infinity,
              height: 100,
              padding: const EdgeInsets.all(20),
              child: Center(child: Text(_currentBranch))
          ),
        ),
        const Divider(),
        ..._branches.map((e) => Card(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(e['name'] as String)
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {
                      _setCurrentBranch(e['name']);
                    },
                    icon: const Icon(Icons.remove_red_eye_outlined),
                  ),
                ),
              ],
            )
        )).toList()
      ],
    );
  }
}
