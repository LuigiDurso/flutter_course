import '../../models/presence.dart';

abstract class PresencesDataProvider {
  Future<List<Presence>> getPresencesByBranchId(String branchId);
  Future<List<Presence>> getPresencesByBranchIdAndDateAfter(
      String branchId, DateTime date);
  Future<List<Presence>> getAllPresences();
  Future<void> addPresence(Presence presence);
  Future<bool> isPresenceExists(Presence presence);
  Future<void> removePresence(Presence presence);
}