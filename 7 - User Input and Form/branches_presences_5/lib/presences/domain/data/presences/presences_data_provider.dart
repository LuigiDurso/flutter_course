import '../../models/presence.dart';

abstract class PresencesDataProvider {
  List<Presence> getPresencesByBranchId(int branchId);
  List<Presence> getPresencesByBranchIdAndDateAfter(
      int branchId, DateTime date);
  List<Presence> getAllPresences();
  void addPresence(Presence presence);
  bool isPresenceExists(Presence presence);
  void removePresence(Presence presence);
}