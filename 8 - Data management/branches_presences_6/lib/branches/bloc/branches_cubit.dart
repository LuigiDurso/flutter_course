import 'package:bloc/bloc.dart';
import 'package:branches_presences_6/branches/branches.dart';
import 'package:equatable/equatable.dart';

import '../../app/utils/async_call_status.dart';

part 'branches_state.dart';

class BranchesCubit extends Cubit<BranchesState> {
  final BranchesRepository branchesRepository;

  BranchesCubit({
    required this.branchesRepository
  }) : super(BranchesState.initial());

  Future<void> fetchAllBranches() async {
    try {
      emit(state.copyWith(status: AsyncCallStatus.loading));
      emit(
          state.copyWith(
            branches: await branchesRepository.getAllBranches(),
            status: AsyncCallStatus.success,
          )
      );
    } on Exception catch (e) {
      emit(state.copyWith(status: AsyncCallStatus.failure));
    }
  }
}
