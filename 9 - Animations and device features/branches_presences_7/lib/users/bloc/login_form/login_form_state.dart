part of 'login_form_bloc.dart';

enum LoginFormStatus {
  submissionInProgress,
  submissionSuccess,
  submissionFailed,
  initial,
}

class LoginFormState {

  final String email;
  final String password;

  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;

  final String? error;

  final LoginFormStatus status;

  final User? loggedUser;

  const LoginFormState({
    this.loggedUser,
    this.error,
    required this.email,
    required this.password,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.status,
  });

  factory LoginFormState.initial() {
    return LoginFormState(
      loggedUser: const User.empty(),
      error: '',
      email: '',
      password: '',
      emailFocusNode: FocusNode(),
      passwordFocusNode: FocusNode(),
      status: LoginFormStatus.initial,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoginFormState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          email == other.email &&
          password == other.password &&
          emailFocusNode == other.emailFocusNode &&
          error == other.error &&
          loggedUser == other.loggedUser &&
          passwordFocusNode == other.passwordFocusNode);

  @override
  int get hashCode =>
      status.hashCode ^
      email.hashCode ^
      password.hashCode ^
      emailFocusNode.hashCode ^
      error.hashCode ^
      loggedUser.hashCode ^
      passwordFocusNode.hashCode;

  @override
  String toString() {
    return 'LoginFormState{'
        ' status: $status,'
        ' email: $email,'
        ' password: $password,'
        ' emailFocusNode: $emailFocusNode,'
        ' passwordFocusNode: $passwordFocusNode,'
        ' error: $error,'
        ' loggedUser: $loggedUser,'
        '}';
  }

  LoginFormState copyWith({
    LoginFormStatus? status,
    String? email,
    String? password,
    String? error,
    FocusNode? emailFocusNode,
    FocusNode? passwordFocusNode,
    User? loggedUser,
  }) {
    return LoginFormState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      emailFocusNode: emailFocusNode ?? this.emailFocusNode,
      passwordFocusNode: passwordFocusNode ?? this.passwordFocusNode,
      error: error ?? this.error,
      loggedUser: loggedUser ?? this.loggedUser,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'email': email,
      'password': password,
      'emailFocusNode': emailFocusNode,
      'passwordFocusNode': passwordFocusNode,
      'error': error,
      'loggedUser': loggedUser,
    };
  }

  factory LoginFormState.fromMap(Map<String, dynamic> map) {
    return LoginFormState(
      status: map['status'] as LoginFormStatus,
      email: map['email'] as String,
      password: map['password'] as String,
      error: map['error'] as String,
      emailFocusNode: map['emailFocusNode'] as FocusNode,
      passwordFocusNode: map['passwordFocusNode'] as FocusNode,
      loggedUser: map['loggedUser'] as User,
    );
  }
}
