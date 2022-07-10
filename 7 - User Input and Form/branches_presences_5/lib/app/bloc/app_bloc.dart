import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../branches/bloc/branches_cubit.dart';
import '../../branches/domain/models/branch.dart';
import '../../users/domain/models/user.dart';
import '../../users/domain/repository/users/users_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {

  late StreamSubscription branchesSubscription;
  
  final BranchesCubit branchesCubit;
  final UsersRepository usersRepository;

  AppBloc({
    required this.branchesCubit,
    required this.usersRepository,
  }) : super(const AppState.unauthenticated()) {

    branchesSubscription = branchesCubit.stream.listen((BranchesState branchesState) {
      _onBranchesChanged(branchesState);
    });

    on<FetchAppUser>(_onFetchAppUser);
    on<UserBranchChanged>(_onUserBranchChanged);
  }

  void _onFetchAppUser(FetchAppUser event, Emitter<AppState> emit) {
    var currentUser = usersRepository.getCurrentUser();
    emit(
      currentUser.isNotEmpty
          ? AppState.authenticated(
          currentUser,
          _getUserBranch(branchesCubit.state.branches, currentUser),
      ) : const AppState.unauthenticated(),
    );
  }

  void _onUserBranchChanged(UserBranchChanged event, Emitter<AppState> emit) {
    emit(state.copyWith(userBranch: event.branch));
  }
  
  void _onBranchesChanged(BranchesState branchesState) {
    add(UserBranchChanged(_getUserBranch(branchesState.branches, state.user)));
  }

  Branch _getUserBranch(List<Branch> branches, User user) {
    if ( branches.isEmpty || user.branchId <= 0 ) {
      return const Branch.empty();
    }
    return branches
        .firstWhere((Branch element) => element.id == user.branchId);
  }

  @override
  Future<void> close() {
    branchesSubscription.cancel();
    return super.close();
  }
}
