import 'dart:convert';

import 'package:branches_presences/presences/domain/data/presences/presences_data_provider.dart';
import 'package:branches_presences/presences/domain/models/presence.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PresencesNotFoundFailure implements Exception {}
class PresencesRequestFailure implements Exception {}

class FirebasePresencesClient implements PresencesDataProvider {
  final FirebaseFirestore _firestore;

  FirebasePresencesClient({
    FirebaseFirestore? firestore
  })  : _firestore = firestore ?? FirebaseFirestore.instance;

  Presence _fromFirestorePresenceConverter(DocumentSnapshot<Map<String, dynamic>> presenceMap, SnapshotOptions? options) {
    return presenceMap.data() != null ?
    Presence.fromMap(presenceMap.data()!) : Presence.empty();
  }

  Map<String, dynamic> _toFirestorePresenceConverter(Presence presence, SetOptions? options) {
    return presence.isNotEmpty ? presence.toMap() : {};
  }

  @override
  Future<void> addPresence(Presence presence) async {
    await _firestore.collection("/presences")
        .doc(presence.id)
        .set(presence.toMap());
  }

  @override
  Future<List<Presence>> getAllPresences() async {
    var result = await _firestore.collection("/presences")
        .withConverter<Presence>(
        fromFirestore:  _fromFirestorePresenceConverter,
        toFirestore: _toFirestorePresenceConverter
    ).get();
    if ( result.docs.isEmpty ) {
      throw PresencesNotFoundFailure();
    }
    return result.docs.map((e) => e.data()).toList();
  }

  @override
  Future<List<Presence>> getPresencesByBranchId(String branchId) async {
    var result = await _firestore.collection("/presences")
        .where("branchId", isEqualTo: branchId)
        .withConverter<Presence>(
        fromFirestore:  _fromFirestorePresenceConverter,
        toFirestore: _toFirestorePresenceConverter
    ).get();
    if ( result.docs.isEmpty ) {
      return [];
    }
    return result.docs.map((e) => e.data()).toList();
  }

  @override
  Future<List<Presence>> getPresencesByBranchIdAndDateAfter(String branchId, DateTime date) async {
    List<Presence> presences = await getPresencesByBranchId(branchId);
    return presences
        .where(
            (element) => element.branchId ==
                branchId && date.isBefore(element.dateTime)
    ).toList();
  }

  @override
  Future<bool> isPresenceExists(Presence presence) async {
    var result = await _firestore.collection("/presences").doc(presence.id)
        .withConverter<Presence>(
        fromFirestore:  _fromFirestorePresenceConverter,
        toFirestore: _toFirestorePresenceConverter
    ).get();
    if ( result.data() == null ) {
      return false;
    }
    return result.data()!.isNotEmpty;
  }

  @override
  Future<void> removePresence(Presence presence) async {
    await _firestore.collection("/presences").doc(presence.id).delete();
  }
}
