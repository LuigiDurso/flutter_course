import '../../models/branch.dart';
import 'branches_data_provider.dart';

class LocalBranches implements BranchesDataProvider {
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
    },
    {
      'id': 8,
      'name': 'Cagliari',
      'address': 'xxx',
      'imagePath': 'https://picsum.photos/id/8/500/500'
    },
    {
      'id': 9,
      'name': 'Lugano',
      'address': 'Via G. Calgari 2 6900 Lugano',
      'imagePath': 'https://picsum.photos/id/8/500/500'
    }
  ];

  @override
  Future<List<Branch>> getBranches() async {
    return await Future.value(
        _branches.map((e) => Branch.fromMap(e)).toList()
    );
  }

  @override
  Future<Branch> findBranchById(int id) async {
    return Future.value(
        _branches.where((b) => b['id'] == id)
            .map((e) => Branch.fromMap(e))
            .first
    );
  }
}
