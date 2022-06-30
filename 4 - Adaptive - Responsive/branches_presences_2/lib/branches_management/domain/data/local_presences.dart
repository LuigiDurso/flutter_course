import '../models/branch.dart';

class LocalBranches {
  final _branches = [
    {
      'id': 1,
      'name': 'Treviolo',
      'address': 'xxx',
      'imagePath': 'https://picsum.photos/id/1/500/500'
    },
    {
      'id': 2,
      'name': 'Milano',
      'address': 'yyy',
      'imagePath': 'https://picsum.photos/id/2/500/500'
    },
    {
      'id': 3,
      'name': 'Battipaglia',
      'address': 'xxx',
      'imagePath': 'https://picsum.photos/id/3/500/500'
    },
    {
      'id': 4,
      'name': 'Palermo',
      'address': 'xxx',
      'imagePath': 'https://picsum.photos/id/4/500/500'
    },
    {
      'id': 5,
      'name': 'Messina',
      'address': 'xxx',
      'imagePath': 'https://picsum.photos/id/5/500/500'
    },
    {
      'id': 6,
      'name': 'Pescara',
      'address': 'xxx',
      'imagePath': 'https://picsum.photos/id/6/500/500'
    },
    {
      'id': 7,
      'name': 'Roma',
      'address': 'xxx',
      'imagePath': 'https://picsum.photos/id/7/500/500'
    }
  ];

  List<Branch> get branches {
    return _branches.map((e) => Branch.fromMap(e)).toList();
  }
}
