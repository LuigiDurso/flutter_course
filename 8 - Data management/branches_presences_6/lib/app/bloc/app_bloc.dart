import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../branches/bloc/branches_cubit.dart';
import '../../branches/domain/models/branch.dart';
import '../../users/domain/models/user.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends HydratedBloc<AppEvent, AppState> {

  late StreamSubscription branchesSubscription;
  
  final BranchesCubit branchesCubit;

  AppBloc({
    required this.branchesCubit,
  }) : super(const AppState.unauthenticated()) {

    branchesSubscription = branchesCubit.stream.listen((BranchesState branchesState) {
      _onBranchesChanged(branchesState);
    });

    on<AppUserChanged>(_onAppUserChanged);
    on<UserBranchChanged>(_onUserBranchChanged);
  }

  void _onAppUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    var currentUser = event.user;
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
  AppState? fromJson(Map<String, dynamic> json) {
    return AppState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(AppState state) {
    return state.toMap();
  }

  @override
  Future<void> close() {
    branchesSubscription.cancel();
    return super.close();
  }
}
