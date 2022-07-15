import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/models/user.dart';
import '../../domain/repository/users/users_repository.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {

  final UsersRepository usersRepository;

  LoginFormBloc({
    required this.usersRepository
  }) : super(LoginFormState.initial()) {

    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginFormState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginFormState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _onFormSubmitted(FormSubmitted event, Emitter<LoginFormState> emit) async {
    emit(state.copyWith(status: LoginFormStatus.submissionInProgress));
    var form = event.form;
    var isValid = form.currentState?.validate();
    if ( isValid != null && !isValid ) {
      emit(
          state.copyWith(
            status: LoginFormStatus.submissionFailed,
            error: 'Errore di immissione!',
          ),
      );
      return;
    }
    var loggedUser = usersRepository.getUserByEmailAndPassword(
        state.email, state.password
    );
    if ( loggedUser == null ) {
      emit(
        state.copyWith(
          status: LoginFormStatus.submissionFailed,
          error: 'Credenziali errate!',
        ),
      );
      return;
    }
    await Future<void>.delayed(const Duration(seconds: 1));
    emit(
        state.copyWith(
          status: LoginFormStatus.submissionSuccess,
          error: '',
          loggedUser: loggedUser,
        )
    );
  }

  @override
  Future<void> close() {
    state.emailFocusNode.dispose();
    state.passwordFocusNode.dispose();
    return super.close();
  }
}
