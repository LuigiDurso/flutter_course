import '../../data/presences/presences_data_provider.dart';
import '../../models/presence.dart';

class PresencesRepository {
  
  final PresencesDataProvider presencesDataProvider;

  PresencesRepository({
    required this.presencesDataProvider
  });

  List<Presence> getPresencesByBranchId(int branchId) {
    return presencesDataProvider.getPresencesByBranchId(branchId);
  }

  List<Presence> getPresencesByBranchIdAndDateAfter(int branchId, DateTime dateTime) {
    return presencesDataProvider.getPresencesByBranchIdAndDateAfter(branchId, dateTime);
  }

  void addPresence(Presence presence) {
    presencesDataProvider.addPresence(presence);
  }

  void removePresence(Presence presence) {
    presencesDataProvider.removePresence(presence);
  }

  bool isPresenceExists(Presence presence) {
    return presencesDataProvider.isPresenceExists(presence);
  }
}