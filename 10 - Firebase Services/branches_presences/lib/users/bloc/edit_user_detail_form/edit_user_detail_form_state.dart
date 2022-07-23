part of 'edit_user_detail_form_bloc.dart';

enum EditUserDetailFormStatus {
  submissionInProgress,
  submissionSuccess,
  submissionFailed,
  initial,
}

class EditUserDetailFormState extends Equatable {
  final String name;
  final String email;
  final String about;
  final String imagePath;
  final XFile? imageFile;

  final FocusNode nameFocusNode;
  final FocusNode emailFocusNode;
  final FocusNode aboutFocusNode;
  final FocusNode imagePathFocusNode;

  final EditUserDetailFormStatus status;

  const EditUserDetailFormState({
    required this.name,
    required this.email,
    required this.about,
    required this.imagePath,
    this.imageFile,
    required this.nameFocusNode,
    required this.emailFocusNode,
    required this.aboutFocusNode,
    required this.imagePathFocusNode,
    required this.status,
  });

  factory EditUserDetailFormState.initial() {
    return EditUserDetailFormState(
      name: '',
      email: '',
      about: '',
      imagePath: '',
      nameFocusNode: FocusNode(),
      emailFocusNode: FocusNode(),
      aboutFocusNode: FocusNode(),
      imagePathFocusNode: FocusNode(),
      status: EditUserDetailFormStatus.initial,
    );
  }

  factory EditUserDetailFormState.fromUser(User user) {
    return EditUserDetailFormState(
      name: user.name,
      email: user.email,
      about: user.about,
      imagePath: user.imagePath,
      nameFocusNode: FocusNode(),
      emailFocusNode: FocusNode(),
      aboutFocusNode: FocusNode(),
      imagePathFocusNode: FocusNode(),
      status: EditUserDetailFormStatus.initial,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EditUserDetailFormState &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          email == other.email &&
          about == other.about &&
          imagePath == other.imagePath &&
          nameFocusNode == other.nameFocusNode &&
          emailFocusNode == other.emailFocusNode &&
          aboutFocusNode == other.aboutFocusNode &&
          imagePathFocusNode == other.imagePathFocusNode &&
          status == other.status);

  @override
  int get hashCode =>
      name.hashCode ^
      email.hashCode ^
      about.hashCode ^
      imagePath.hashCode ^
      nameFocusNode.hashCode ^
      emailFocusNode.hashCode ^
      aboutFocusNode.hashCode ^
      imagePathFocusNode.hashCode ^
      status.hashCode;

  @override
  String toString() {
    return 'EditUserDetailFormState{'
        ' name: $name,'
        ' email: $email,'
        ' about: $about,'
        ' imagePath: $imagePath,'
        ' nameFocusNode: $nameFocusNode,'
        ' emailFocusNode: $emailFocusNode,'
        ' aboutFocusNode: $aboutFocusNode,'
        ' imagePathFocusNode: $imagePathFocusNode,'
        ' status: $status,'
        '}';
  }

  EditUserDetailFormState copyWith({
    String? name,
    String? email,
    String? about,
    String? imagePath,
    XFile? imageFile,
    FocusNode? nameFocusNode,
    FocusNode? emailFocusNode,
    FocusNode? aboutFocusNode,
    FocusNode? imagePathFocusNode,
    EditUserDetailFormStatus? status,
  }) {
    return EditUserDetailFormState(
      name: name ?? this.name,
      email: email ?? this.email,
      about: about ?? this.about,
      imagePath: imagePath ?? this.imagePath,
      imageFile: imageFile ?? this.imageFile,
      nameFocusNode: nameFocusNode ?? this.nameFocusNode,
      emailFocusNode: emailFocusNode ?? this.emailFocusNode,
      aboutFocusNode: aboutFocusNode ?? this.aboutFocusNode,
      imagePathFocusNode: imagePathFocusNode ?? this.imagePathFocusNode,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'about': about,
      'imagePath': imagePath,
      'nameFocusNode': nameFocusNode,
      'emailFocusNode': emailFocusNode,
      'aboutFocusNode': aboutFocusNode,
      'imagePathFocusNode': imagePathFocusNode,
      'status': status,
    };
  }

  factory EditUserDetailFormState.fromMap(Map<String, dynamic> map) {
    return EditUserDetailFormState(
      name: map['name'] as String,
      email: map['email'] as String,
      about: map['about'] as String,
      imagePath: map['imagePath'] as String,
      nameFocusNode: map['nameFocusNode'] as FocusNode,
      emailFocusNode: map['emailFocusNode'] as FocusNode,
      aboutFocusNode: map['aboutFocusNode'] as FocusNode,
      imagePathFocusNode: map['imagePathFocusNode'] as FocusNode,
      status: map['status'] as EditUserDetailFormStatus,
    );
  }

  @override
  List<Object> get props => [
    name,
    email,
    about,
    imagePath,
    nameFocusNode,
    emailFocusNode,
    aboutFocusNode,
    imagePathFocusNode,
    status,
  ];
}
