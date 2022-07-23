import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/branch.dart';
import 'branches_data_provider.dart';

class BranchNotFoundFailure implements Exception {}
class BranchRequestFailure implements Exception {}

class FirebaseBranchesClient implements BranchesDataProvider {
  final FirebaseFirestore _firestore;

  FirebaseBranchesClient({
    FirebaseFirestore? firestore
  })  : _firestore = firestore ?? FirebaseFirestore.instance;

  Branch _fromFirestoreBranchConverter(DocumentSnapshot<Map<String, dynamic>> branchMap, SnapshotOptions? options) {
    return branchMap.data() != null ?
    Branch.fromMap(branchMap.data()!).copyWith(uid: branchMap.id) : const Branch.empty();
  }

  Map<String, dynamic> _toFirestoreBranchConverter(Branch branch, SetOptions? options) {
    return branch.isNotEmpty ? branch.toMap() : {};
  }

  @override
  Future<List<Branch>> getBranches() async {
    var result = await _firestore.collection("/branches")
        .withConverter<Branch>(
        fromFirestore:  _fromFirestoreBranchConverter,
        toFirestore: _toFirestoreBranchConverter
    ).get();
    if ( result.docs.isEmpty ) {
      throw BranchNotFoundFailure();
    }
    return result.docs.map((e) => e.data()).toList();
  }

  @override
  Future<Branch> findBranchById(String id) async {
    var result = await _firestore.collection("/branches").doc(id)
        .withConverter<Branch>(
        fromFirestore:  _fromFirestoreBranchConverter,
        toFirestore: _toFirestoreBranchConverter
    ).get();
    if ( result.data() == null ) {
      throw BranchNotFoundFailure();
    }
    return result.data()!;
  }
}
