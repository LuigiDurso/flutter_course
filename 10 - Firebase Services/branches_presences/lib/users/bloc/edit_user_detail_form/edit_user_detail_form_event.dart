part of 'edit_user_detail_form_bloc.dart';

abstract class EditUserDetailFormEvent extends Equatable {
  const EditUserDetailFormEvent();
}

class NameChanged extends EditUserDetailFormEvent {
  final String name;

  const NameChanged({required this.name});

  @override
  List<Object> get props => [name];
}

class LastnameChanged extends EditUserDetailFormEvent {
  final String lastname;

  const LastnameChanged({required this.lastname});

  @override
  List<Object> get props => [lastname];
}

class AboutChanged extends EditUserDetailFormEvent {
  final String about;

  const AboutChanged({required this.about});

  @override
  List<Object> get props => [about];
}

class ImageFileChanged extends EditUserDetailFormEvent {
  final XFile imageFile;

  const ImageFileChanged({ required this.imageFile });

  @override
  List<Object> get props => [ imageFile ];
}

class FormSubmitted extends EditUserDetailFormEvent {
  final GlobalKey<FormState> form;

  const FormSubmitted({ required this.form });

  @override
  List<Object> get props => [ form ];
}
