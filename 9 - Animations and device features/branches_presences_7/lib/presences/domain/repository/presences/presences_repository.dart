import '../../data/presences/presences_data_provider.dart';
import '../../models/presence.dart';

class PresencesRepository {
  
  final PresencesDataProvider presencesDataProvider;

  PresencesRepository({
    required this.presencesDataProvider
  });

  Future<List<Presence>> getPresencesByBranchId(int branchId) async {
    return await presencesDataProvider.getPresencesByBranchId(branchId);
  }

  Future<List<Presence>> getPresencesByBranchIdAndDateAfter(int branchId, DateTime dateTime) async {
    return await presencesDataProvider.getPresencesByBranchIdAndDateAfter(
        branchId, dateTime
    );
  }

  Future<void> addPresence(Presence presence) async {
    await presencesDataProvider.addPresence(presence);
  }

  Future<void> removePresence(Presence presence) async {
    await presencesDataProvider.removePresence(presence);
  }

  Future<bool> isPresenceExists(Presence presence) async {
    return await presencesDataProvider.isPresenceExists(presence);
  }
}