part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppUserChanged extends AppEvent {

  final User user;

  const AppUserChanged({ required this.user });

  @override
  List<Object> get props => [];
}