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

class UserLoggedIn extends AppEvent {

  final String token;
  final String refreshToken;
  final String email;

  const UserLoggedIn({
    required this.token,
    required this.refreshToken,
    required this.email
  });

  @override
  List<Object> get props => [ token, refreshToken, email ];
}

class LogoutRequested extends AppEvent {
}