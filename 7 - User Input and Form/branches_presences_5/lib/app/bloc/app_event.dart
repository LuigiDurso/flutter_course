part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppUserChanged extends AppEvent {
  final User user;

  const AppUserChanged(this.user);

  @override
  List<Object> get props => [user];
}

class UserBranchChanged extends AppEvent {
  final Branch branch;

  const UserBranchChanged(this.branch);

  @override
  List<Object> get props => [branch];
}