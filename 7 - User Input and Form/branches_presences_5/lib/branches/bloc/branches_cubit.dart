import 'package:bloc/bloc.dart';
import 'package:branches_presences_5/branches/branches.dart';
import 'package:equatable/equatable.dart';

part 'branches_state.dart';

class BranchesCubit extends Cubit<BranchesState> {
  final BranchesRepository branchesRepository;

  BranchesCubit({
    required this.branchesRepository
  }) : super(BranchesState.initial());

  void fetchAllBranches() {
    emit(state.copyWith(branches: branchesRepository.getAllBranches()));
  }
}
