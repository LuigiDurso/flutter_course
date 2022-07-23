import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String name;
  final String lastname;
  final String email;
  final String imagePath;
  final String about;
  final String branchId;

  const User({
    required this.uid,
    required this.name,
    required this.lastname,
    required this.email,
    required this.imagePath,
    required this.about,
    required this.branchId,
  });

  const User.empty() :
        uid = '',
        name = '',
        lastname = '',
        email = '',
        imagePath = '',
        about = '',
        branchId = '';

  bool get isNotEmpty {
    return uid.isNotEmpty;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          name == other.name &&
          lastname == other.lastname &&
          email == other.email &&
          imagePath == other.imagePath &&
          about == other.about &&
          branchId == other.branchId);

  @override
  int get hashCode =>
      uid.hashCode ^
      name.hashCode ^
      lastname.hashCode ^
      email.hashCode ^
      imagePath.hashCode ^
      about.hashCode ^
      branchId.hashCode;

  @override
  String toString() {
    return 'User{'
        ' uid: $uid,'
        ' name: $name,'
        ' lastname: $lastname,'
        ' email: $email,'
        ' imagePath: $imagePath,'
        ' about: $about,'
        ' branchId: $branchId,'
        '}';
  }

  User copyWith({
    String? uid,
    String? name,
    String? lastname,
    String? email,
    String? imagePath,
    String? about,
    String? branchId,
  }) {
    return User(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      imagePath: imagePath ?? this.imagePath,
      about: about ?? this.about,
      branchId: branchId ?? this.branchId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'lastname': lastname,
      'email': email,
      'imagePath': imagePath,
      'about': about,
      'branchId': branchId,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: (map['uid'] ?? '') as String,
      name: map['name'] as String,
      lastname: map['lastname'] as String,
      email: map['email'] as String,
      imagePath: map['imagePath'] as String,
      about: map['about'] as String,
      branchId: map['branchId'] as String,
    );
  }

  @override
  List<Object> get props => [uid, name, lastname, email, imagePath, about, branchId];
}