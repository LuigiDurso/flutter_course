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

  final String? token;
  final String? refreshToken;

  const LoginFormState({
    this.token,
    this.refreshToken,
    this.error,
    required this.email,
    required this.password,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.status,
  });

  factory LoginFormState.initial() {
    return LoginFormState(
      token: '',
      refreshToken: '',
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
          token == other.token &&
          refreshToken == other.refreshToken &&
          passwordFocusNode == other.passwordFocusNode);

  @override
  int get hashCode =>
      status.hashCode ^
      email.hashCode ^
      password.hashCode ^
      emailFocusNode.hashCode ^
      error.hashCode ^
      token.hashCode ^
      refreshToken.hashCode ^
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
        ' token: $token,'
        ' refreshToken: $refreshToken,'
        '}';
  }

  LoginFormState copyWith({
    LoginFormStatus? status,
    String? email,
    String? password,
    String? error,
    FocusNode? emailFocusNode,
    FocusNode? passwordFocusNode,
    String? token,
    String? refreshToken,
  }) {
    return LoginFormState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      emailFocusNode: emailFocusNode ?? this.emailFocusNode,
      passwordFocusNode: passwordFocusNode ?? this.passwordFocusNode,
      error: error ?? this.error,
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
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
      'token': token,
      'refreshToken': refreshToken,
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
      token: map['token'] as String,
      refreshToken: map['refreshToken'] as String,
    );
  }
}
