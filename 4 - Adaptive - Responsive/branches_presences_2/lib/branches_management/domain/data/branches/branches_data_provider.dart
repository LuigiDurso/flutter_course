import '../../models/branch.dart';

abstract class BranchesDataProvider {
  List<Branch> getBranches();
}