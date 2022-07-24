import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/models/user.dart';
import '../../domain/repository/file/file_storage_repository.dart';
import '../../domain/repository/users/users_repository.dart';

part 'edit_user_detail_form_event.dart';
part 'edit_user_detail_form_state.dart';

class EditUserDetailFormBloc extends Bloc<EditUserDetailFormEvent, EditUserDetailFormState> {

  final User? user;

  final UsersRepository usersRepository;
  final FileStorageRepository fileStorageRepository;

  EditUserDetailFormBloc({
    this.user,
    required this.usersRepository,
    required this.fileStorageRepository,
  }) : super(
      user != null ?
      EditUserDetailFormState.fromUser(user) :
      EditUserDetailFormState.initial()
  ) {
    on<NameChanged>(_onNamedChanged);
    on<LastnameChanged>(_onLastnameChanged);
    on<AboutChanged>(_onAboutChanged);
    on<ImageFileChanged>(_onUserImageChange);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onNamedChanged(NameChanged event, Emitter<EditUserDetailFormState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _onLastnameChanged(LastnameChanged event, Emitter<EditUserDetailFormState> emit) {
    emit(state.copyWith(lastname: event.lastname));
  }

  void _onAboutChanged(AboutChanged event, Emitter<EditUserDetailFormState> emit) {
    emit(state.copyWith(about: event.about));
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
    String imagePath = user!.imagePath;
    if (state.imageFile != null) {
      imagePath = await fileStorageRepository.uploadFile(
          "user-image",
          user!.uid,
          File(state.imageFile!.path)
      );
      emit(state.copyWith(imagePath: imagePath));
    }
    await usersRepository.updateUser(
        user!.uid,
        state.name,
        state.email,
        imagePath,
        state.about,
    );
    emit(state.copyWith(status: EditUserDetailFormStatus.submissionSuccess));
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
