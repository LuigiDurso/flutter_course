import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/models/user.dart';
import '../../domain/repository/users/users_repository.dart';

part 'edit_user_detail_form_event.dart';
part 'edit_user_detail_form_state.dart';

class EditUserDetailFormBloc extends Bloc<EditUserDetailFormEvent, EditUserDetailFormState> {

  final User? user;

  final UsersRepository usersRepository;

  EditUserDetailFormBloc({
    this.user,
    required this.usersRepository,
  }) : super(
      user != null ?
      EditUserDetailFormState.fromUser(user) :
      EditUserDetailFormState.initial()
  ) {
    on<NameChanged>(_onNamedChanged);
    on<EmailChanged>(_onEmailChanged);
    on<AboutChanged>(_onAboutChanged);
    on<ImagePathChanged>(_onImagePathChanged);
    on<ImageFileChanged>(_onUserImageChange);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onNamedChanged(NameChanged event, Emitter<EditUserDetailFormState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _onEmailChanged(EmailChanged event, Emitter<EditUserDetailFormState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onAboutChanged(AboutChanged event, Emitter<EditUserDetailFormState> emit) {
    emit(state.copyWith(about: event.about));
  }

  void _onImagePathChanged(ImagePathChanged event, Emitter<EditUserDetailFormState> emit) {
    emit(state.copyWith(imagePath: event.imagePath));
  }

  void _onUserImageChange(ImageFileChanged event, Emitter<EditUserDetailFormState> emit) {
    emit(state.copyWith(imageFile: event.imageFile));
  }

  void _onFormSubmitted(FormSubmitted event, Emitter<EditUserDetailFormState> emit) async {
    emit(state.copyWith(status: EditUserDetailFormStatus.submissionInProgress));
    var form = event.form;
    var isValid = form.currentState?.validate();
    if ( isValid != null && !isValid ) {
      emit(state.copyWith(status: EditUserDetailFormStatus.submissionFailed));
      return;
    }
    usersRepository.updateUser(
        user!.id, state.name, state.email, state.imagePath, state.about
    );
    await Future<void>.delayed(const Duration(seconds: 1));
    emit(state.copyWith(status: EditUserDetailFormStatus.submissionSuccess));
  }

  @override
  Future<void> close() {
    state.nameFocusNode.dispose();
    state.emailFocusNode.dispose();
    state.aboutFocusNode.dispose();
    state.imagePathFocusNode.dispose();
    return super.close();
  }
}
