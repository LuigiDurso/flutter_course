part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class FetchAppUser extends AppEvent {

  const FetchAppUser();

  @override
  List<Object> get props => [];
}

class UserBranchChanged extends AppEvent {
  final Branch branch;

  const UserBranchChanged(this.branch);

  @override
  List<Object> get props => [branch];
}