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
        ..._branches.map((e) => Row(
          children: [
            Expanded(
              child: Card(
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(e['name'] as String)
                ),
              ),
            )
          ],
        )).toList(),
        const Divider(),
        Expanded(
          child: ListView.builder(
              itemCount: _branches.length,
              itemBuilder: (_, index) {
                return Card(
                  child: ListTile(
                    title: Text(_branches[index]['name'] as String),
                  ),
                );
              }
          ),
        )
      ],
    );
  }
}
