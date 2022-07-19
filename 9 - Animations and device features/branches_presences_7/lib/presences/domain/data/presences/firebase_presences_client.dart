import 'dart:convert';

import 'package:branches_presences_7/presences/domain/data/presences/presences_data_provider.dart';
import 'package:branches_presences_7/presences/domain/models/presence.dart';
import 'package:http/http.dart' as http;

class PresencesNotFoundFailure implements Exception {}
class PresencesRequestFailure implements Exception {}

class FirebasePresencesClient implements PresencesDataProvider {
  final _baseUrl = "si-presences-default-rtdb.firebaseio.com";

  final http.Client _httpClient;

  FirebasePresencesClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  @override
  Future<void> addPresence(Presence presence) async {
    final presencesRequest = Uri.https(
      _baseUrl,
      '/presences/${presence.id}.json',
    );
    final presencesResponse = await _httpClient.put(presencesRequest, body: jsonEncode(presence.toMap()));

    if (presencesResponse.statusCode != 200) {
      throw PresencesRequestFailure();
    }
  }

  @override
  Future<List<Presence>> getAllPresences() async {
    final presencesRequest = Uri.https(
      _baseUrl,
      '/presences.json',
    );
    final presencesResponse = await _httpClient.get(presencesRequest);

    if (presencesResponse.statusCode != 200) {
      throw PresencesRequestFailure();
    }

    final presencesJson = (jsonDecode(
      presencesResponse.body,
    )) as List;

    return presencesJson
        .where((element) => element != null)
        .map((e) => Presence.fromMap(e))
        .toList();
  }

  @override
  Future<List<Presence>> getPresencesByBranchId(int branchId) async {
    final presencesRequest = Uri.https(
      _baseUrl,
      '/presences.json',
      { "orderBy": "\"branchId\"", "equalTo": "$branchId" }
    );
    final presencesResponse = await _httpClient.get(presencesRequest);

    if (presencesResponse.statusCode != 200) {
      throw PresencesRequestFailure();
    }

    final presencesJson = presencesResponse.body.isNotEmpty && presencesResponse.body != "{}" ? (jsonDecode(
      presencesResponse.body,
    )) as Map<String, dynamic> : <String, dynamic>{};

    return presencesJson.values
        .where((element) => element != null)
        .map((e) => Presence.fromMap(e))
        .toList();
  }

  @override
  Future<List<Presence>> getPresencesByBranchIdAndDateAfter(int branchId, DateTime date) async {
    List<Presence> presences = await getPresencesByBranchId(branchId);
    return presences
        .where(
            (element) => element.branchId ==
                branchId && date.isBefore(element.dateTime)
    ).toList();
  }

  @override
  Future<bool> isPresenceExists(Presence presence) async {
    final presencesRequest = Uri.https(
      _baseUrl,
      '/presences/${presence.id}.json',
    );
    final presencesResponse = await _httpClient.get(presencesRequest);

    if (presencesResponse.statusCode != 200) {
      throw PresencesRequestFailure();
    }

    final presencesJson = presencesResponse.body.isNotEmpty && presencesResponse.body != 'null' ?(jsonDecode(
      presencesResponse.body,
    )) as Map<String, dynamic> : <String, dynamic>{};

    if ( presencesJson.isEmpty ) {
      return false;
    }

    return Presence.fromMap(presencesJson).branchId > 0;
  }

  @override
  Future<void> removePresence(Presence presence) async {
    final presencesRequest = Uri.https(
      _baseUrl,
      '/presences/${presence.id}.json',
    );
    final presencesResponse = await _httpClient.delete(presencesRequest);

    if (presencesResponse.statusCode != 200) {
      throw PresencesRequestFailure();
    }
  }
}
