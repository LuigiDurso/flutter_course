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

class EmailChanged extends EditUserDetailFormEvent {
  final String email;

  const EmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}

class AboutChanged extends EditUserDetailFormEvent {
  final String about;

  const AboutChanged({required this.about});

  @override
  List<Object> get props => [about];
}

class ImagePathChanged extends EditUserDetailFormEvent {
  final String imagePath;

  const ImagePathChanged({required this.imagePath});

  @override
  List<Object> get props => [imagePath];
}

class FormSubmitted extends EditUserDetailFormEvent {
  final GlobalKey<FormState> form;

  const FormSubmitted({ required this.form });

  @override
  List<Object> get props => [ form ];
}
