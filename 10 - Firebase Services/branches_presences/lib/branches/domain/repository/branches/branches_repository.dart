import '../../data/branches/branches_data_provider.dart';
import '../../models/branch.dart';

class BranchesRepository {
  
  final BranchesDataProvider branchesDataProvider;

  BranchesRepository({
    required this.branchesDataProvider
  });

  Future<List<Branch>> getAllBranches() {
    return branchesDataProvider.getBranches();
  }

  Future<Branch> findBranchById(String id) {
    return branchesDataProvider.findBranchById(id);
  }
}