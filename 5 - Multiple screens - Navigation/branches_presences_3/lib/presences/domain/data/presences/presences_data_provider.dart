import '../../models/presence.dart';

abstract class PresencesDataProvider {
  List<Presence> getPresencesByBranchId(int branchId);
  List<Presence> getPresencesByBranchIdAndDateAfter(
      int branchId, DateTime date);
}