import 'dart:async';

import 'package:branches_presences_7/branches/branches.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../users/domain/models/user.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends HydratedBloc<AppEvent, AppState> {

  final BranchesRepository branchesRepository;

  AppBloc({
    required this.branchesRepository,
  }) : super(const AppState.unauthenticated()) {

    on<AppUserChanged>(_onAppUserChanged);
  }

  void _onAppUserChanged(AppUserChanged event, Emitter<AppState> emit) async {
    var currentUser = event.user;
    var userBranch = await _getUserBranch(currentUser);
    emit(
      currentUser.isNotEmpty
          ? AppState.authenticated(
          currentUser,
          userBranch,
      ) : const AppState.unauthenticated(),
    );
  }

  Future<Branch> _getUserBranch(User user) async {
    if ( user.branchId <= 0 ) {
      return const Branch.empty();
    }
    return await branchesRepository.findBranchById(user.branchId);
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
    return super.close();
  }
}
