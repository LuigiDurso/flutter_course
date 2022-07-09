import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../domain/models/presence.dart';
import '../domain/repository/presences/presences_repository.dart';

part 'presences_state.dart';

class PresencesCubit extends Cubit<PresencesState> {
  final PresencesRepository presencesRepository;
  
  PresencesCubit({
    required this.presencesRepository
  }) : super(PresencesState.initial());
  
  void fetchPresencesByBranchId(int branchId) {
    emit(
        state.copyWith(
            presences: presencesRepository.getPresencesByBranchId(branchId)
        )
    );
  }

  void fetchPresencesByBranchIdAndDateAfter(int branchId, DateTime date) {
    emit(
        state.copyWith(
            presences: presencesRepository.getPresencesByBranchIdAndDateAfter(
                branchId,
                date
            )
        )
    );
  }
}
