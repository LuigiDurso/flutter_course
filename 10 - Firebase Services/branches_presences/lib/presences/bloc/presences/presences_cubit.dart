import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../app/utils/async_call_status.dart';
import '../../domain/models/presence.dart';
import '../../domain/repository/presences/presences_repository.dart';

part 'presences_state.dart';

class PresencesCubit extends Cubit<PresencesState> {
  final PresencesRepository presencesRepository;
  
  PresencesCubit({
    required this.presencesRepository
  }) : super(PresencesState.initial());
  
  Future<void> fetchPresencesByBranchId(int branchId) async {
    print('fetchPresencesByBranchId $branchId');
    try {
      emit(state.copyWith(status: AsyncCallStatus.loading));
      emit(
          state.copyWith(
              presences: await presencesRepository.getPresencesByBranchId(
                  branchId
              ),
            status: AsyncCallStatus.success,
          )
      );
    } on Exception catch(e) {
      emit(state.copyWith(status: AsyncCallStatus.failure));
    }
  }

  Future<void> fetchPresencesByBranchIdAndDateAfter(int branchId, DateTime date) async {
    try {
      emit(state.copyWith(status: AsyncCallStatus.loading));
      emit(
          state.copyWith(
              presences: await presencesRepository.getPresencesByBranchIdAndDateAfter(
                  branchId,
                  date
              ),
            status: AsyncCallStatus.success,
          )
      );
    } on Exception {
      emit(state.copyWith(status: AsyncCallStatus.failure));
    }
  }
}
