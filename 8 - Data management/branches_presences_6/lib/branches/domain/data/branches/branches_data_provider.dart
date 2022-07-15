import '../../models/branch.dart';

abstract class BranchesDataProvider {
  Future<List<Branch>> getBranches();
  Future<Branch> findBranchById(int id);
}