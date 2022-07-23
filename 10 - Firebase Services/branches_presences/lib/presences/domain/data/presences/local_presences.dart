import 'package:branches_presences/presences/domain/data/presences/presences_data_provider.dart';

import '../../../../app/domain/models/equatable_date_time.dart';
import '../../models/presence.dart';

class LocalPresences implements PresencesDataProvider {
  late final List<Presence> _presences;

  LocalPresences() {
    var now = DateTime.now();
    _presences = [
      Presence(
        branchId: 2,
        dateTime: EquatableDateTime(now.year, now.month, now.day),
        username: "luigi.durso@si2001.it",
      ),
      Presence(
        branchId: 3,
        dateTime: EquatableDateTime(now.year, now.month, now.day),
        username: "test.test@si2001.it",
      ),
      Presence(
        branchId: 1,
        dateTime: EquatableDateTime(now.year, now.month, now.day),
        username: "test2.test2@si2001.it",
      ),
      Presence(
          branchId: 1,
          dateTime: EquatableDateTime.fromDateTime(
              DateTime(now.year, now.month, now.day)
                  .add(const Duration(days: 1))),
          username: "luigi.durso@si2001.it"),
      Presence(
          branchId: 4,
          dateTime: EquatableDateTime.fromDateTime(
              DateTime(now.year, now.month, now.day)
                  .add(const Duration(days: 1))),
          username: "test.test@si2001.it"),
      Presence(
          branchId: 2,
          dateTime: EquatableDateTime.fromDateTime(
              DateTime(now.year, now.month, now.day)
                  .add(const Duration(days: 2))),
          username: "luigi.durso@si2001.it"),
      Presence(
          branchId: 1,
          dateTime: EquatableDateTime.fromDateTime(
              DateTime(now.year, now.month, now.day)
                  .add(const Duration(days: 2))),
          username: "test.test@si2001.it"),
      Presence(
          branchId: 1,
          dateTime: EquatableDateTime.fromDateTime(
              DateTime(now.year, now.month, now.day)
                  .add(const Duration(days: 2))),
          username: "test2.test2@si2001.it"),
      Presence(
          branchId: 1,
          dateTime: EquatableDateTime.fromDateTime(
              DateTime(now.year, now.month, now.day)
                  .add(const Duration(days: 2))),
          username: "test3.test3@si2001.it"),
      Presence(
          branchId: 1,
          dateTime: EquatableDateTime.fromDateTime(
              DateTime(now.year, now.month, now.day)
                  .add(const Duration(days: 2))),
          username: "test4.test4@si2001.it"),
      Presence(
          branchId: 3,
          dateTime: EquatableDateTime.fromDateTime(
              DateTime(now.year, now.month, now.day)
                  .add(const Duration(days: 3))),
          username: "luigi.durso@si2001.it"),
      Presence(
          branchId: 1,
          dateTime: EquatableDateTime.fromDateTime(
              DateTime(now.year, now.month, now.day)
                  .add(const Duration(days: 4))),
          username: "test.test@si2001.it"),
      Presence(
          branchId: 1,
          dateTime: EquatableDateTime.fromDateTime(
              DateTime(now.year, now.month, now.day)
                  .add(const Duration(days: 5))),
          username: "luigi.durso@si2001.it"),
      Presence(
          branchId: 1,
          dateTime: EquatableDateTime.fromDateTime(
              DateTime(now.year, now.month, now.day)
                  .add(const Duration(days: 10))),
          username: "luigi.durso@si2001.it"),
    ];
  }

  @override
  Future<List<Presence>> getPresencesByBranchId(int branchId) async {
    return await Future.value(
        _presences
            .where((element) => element.branchId == branchId)
            .toList()
    );
  }

  @override
  Future<List<Presence>> getPresencesByBranchIdAndDateAfter(
    int branchId,
    DateTime date,
  ) async {
    return await Future.value(
        _presences
            .where((element) =>
        element.branchId == branchId && date.isBefore(element.dateTime))
            .toList()
    );
  }

  @override
  Future<List<Presence>> getAllPresences() async {
    return await Future.value(
        [..._presences]
    );
  }

  @override
  Future<void> addPresence(Presence presence) async {
    bool presenceExists =
        _presences.where((Presence p) => p == presence).isNotEmpty;
    if (!presenceExists) {
      _presences.add(presence);
    }
  }

  @override
  Future<bool> isPresenceExists(Presence presence) async {
    return await Future.value(
        _presences.where((Presence p) {
          return p == presence;
        }).isNotEmpty
    );
  }

  @override
  Future<void> removePresence(Presence presence) async {
    await Future.value(_presences.remove(presence));
  }
}
