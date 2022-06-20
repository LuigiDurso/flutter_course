import 'package:flutter/material.dart';

class BranchesList extends StatelessWidget {
  BranchesList({Key? key}) : super(key: key);

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


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ..._branches.map((e) => Expanded(
          child: Card(
            child: Text(e['name'] as String),
          ),
        )).toList()
      ],
    );
  }
}
