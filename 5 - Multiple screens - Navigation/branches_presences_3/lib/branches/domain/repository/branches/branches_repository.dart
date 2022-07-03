import '../../data/branches/branches_data_provider.dart';
import '../../models/branch.dart';

class BranchesRepository {
  
  final BranchesDataProvider branchesDataProvider;

  BranchesRepository({
    required this.branchesDataProvider
  });

  List<Branch> getAllBranches() {
    return branchesDataProvider.getBranches();
  }
}