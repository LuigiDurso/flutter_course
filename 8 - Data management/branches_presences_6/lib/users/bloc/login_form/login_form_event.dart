part of 'login_form_bloc.dart';

abstract class LoginFormEvent extends Equatable {
  const LoginFormEvent();
}

class EmailChanged extends LoginFormEvent {
  final String email;

  const EmailChanged({ required this.email });

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends LoginFormEvent {
  final String password;

  const PasswordChanged({ required this.password });

  @override
  List<Object> get props => [password];
}

class FormSubmitted extends LoginFormEvent {
  final GlobalKey<FormState> form;

  const FormSubmitted({ required this.form });

  @override
  List<Object> get props => [ form ];
}
