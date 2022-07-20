import 'dart:async';

import 'package:branches_presences_7/branches/branches.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../users/domain/models/user.dart';
import '../../../users/domain/repository/users/users_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends HydratedBloc<AppEvent, AppState> {

  final BranchesRepository branchesRepository;
  final UsersRepository usersRepository;
  final FlutterSecureStorage secureStorage;

  AppBloc({
    required this.branchesRepository,
    required this.usersRepository,
    required this.secureStorage,
  }) : super(const AppState.unauthenticated()) {

    on<AppUserChanged>(_onAppUserChanged);
    on<UserLoggedIn>(_onUserLoggedIn);
    on<LogoutRequested>(_onLogoutRequested);
  }

  void _onLogoutRequested(LogoutRequested event, Emitter<AppState> emit) async {
    await secureStorage.deleteAll();
    emit(const AppState.unauthenticated());
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

  void _onUserLoggedIn(UserLoggedIn event, Emitter<AppState> emit) async {
    await secureStorage.write(key: "apiToken", value: event.token);
    await secureStorage.write(key: "refreshApiToken", value: event.refreshToken);
    var currentUser = await usersRepository.getUserByEmail(event.email);
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
