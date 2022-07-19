import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/branch.dart';
import 'branches_data_provider.dart';

class BranchNotFoundFailure implements Exception {}
class BranchRequestFailure implements Exception {}

class FirebaseBranchesClient implements BranchesDataProvider {
  final _baseUrl = "si-presences-default-rtdb.firebaseio.com";

  final http.Client _httpClient;

  FirebaseBranchesClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  @override
  Future<List<Branch>> getBranches() async {
    final branchesRequest = Uri.https(
      _baseUrl,
      '/branches.json',
    );
    final branchesResponse = await _httpClient.get(branchesRequest);

    if (branchesResponse.statusCode != 200) {
      throw BranchRequestFailure();
    }

    final branchesJson = (jsonDecode(
      branchesResponse.body,
    )) as List;

    if (branchesJson.isEmpty) {
      throw BranchNotFoundFailure();
    }

    return branchesJson.where((element) => element != null).map((e) => Branch.fromMap(e)).toList();
  }

  @override
  Future<Branch> findBranchById(int id) async {
    final branchesRequest = Uri.https(
      _baseUrl,
      '/branches/$id.json',
    );
    final branchesResponse = await _httpClient.get(branchesRequest);

    if (branchesResponse.statusCode != 200) {
      throw BranchRequestFailure();
    }

    final branchJson = (jsonDecode(
      branchesResponse.body,
    )) as Map<String, dynamic>;

    if (branchJson.isEmpty) {
      throw BranchNotFoundFailure();
    }

    return Branch.fromMap(branchJson);
  }
}
