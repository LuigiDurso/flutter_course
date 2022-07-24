part of 'edit_user_detail_form_bloc.dart';

enum EditUserDetailFormStatus {
  submissionInProgress,
  submissionSuccess,
  submissionFailed,
  initial,
}

class EditUserDetailFormState extends Equatable {
  final String name;
  final String lastname;
  final String email;
  final String about;
  final String imagePath;
  final XFile? imageFile;

  final EditUserDetailFormStatus status;

  const EditUserDetailFormState({
    required this.name,
    required this.lastname,
    required this.email,
    required this.about,
    required this.imagePath,
    this.imageFile,
    required this.status,
  });

  factory EditUserDetailFormState.initial() {
    return const EditUserDetailFormState(
      name: '',
      lastname: '',
      email: '',
      about: '',
      imagePath: '',
      status: EditUserDetailFormStatus.initial,
    );
  }

  factory EditUserDetailFormState.fromUser(User user) {
    return EditUserDetailFormState(
      name: user.name,
      lastname: user.lastname,
      email: user.email,
      about: user.about,
      imagePath: user.imagePath,
      status: EditUserDetailFormStatus.initial,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EditUserDetailFormState &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          lastname == other.lastname &&
          email == other.email &&
          about == other.about &&
          imagePath == other.imagePath &&
          status == other.status);

  @override
  int get hashCode =>
      name.hashCode ^
      lastname.hashCode ^
      email.hashCode ^
      about.hashCode ^
      imagePath.hashCode ^
      status.hashCode;

  @override
  String toString() {
    return 'EditUserDetailFormState{'
        ' name: $name,'
        ' lastname: $lastname,'
        ' email: $email,'
        ' about: $about,'
        ' imagePath: $imagePath,'
        ' status: $status,'
        '}';
  }

  EditUserDetailFormState copyWith({
    String? name,
    String? lastname,
    String? email,
    String? about,
    String? imagePath,
    XFile? imageFile,
    EditUserDetailFormStatus? status,
  }) {
    return EditUserDetailFormState(
      name: name ?? this.name,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      about: about ?? this.about,
      imagePath: imagePath ?? this.imagePath,
      imageFile: imageFile ?? this.imageFile,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'lastname': lastname,
      'email': email,
      'about': about,
      'imagePath': imagePath,
      'status': status,
    };
  }

  factory EditUserDetailFormState.fromMap(Map<String, dynamic> map) {
    return EditUserDetailFormState(
      name: map['name'] as String,
      lastname: map['lastname'] as String,
      email: map['email'] as String,
      about: map['about'] as String,
      imagePath: map['imagePath'] as String,
      status: map['status'] as EditUserDetailFormStatus,
    );
  }

  @override
  List<Object> get props => [
    name,
    lastname,
    email,
    about,
    imagePath,
    status,
  ];
}
