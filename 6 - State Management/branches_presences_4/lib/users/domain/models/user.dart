import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String lastname;
  final String email;
  final String imagePath;
  final String about;
  final int branchId;

  const User({
    required this.id,
    required this.name,
    required this.lastname,
    required this.email,
    required this.imagePath,
    required this.about,
    required this.branchId,
  });

  const User.empty() :
        id = -1,
        name = '',
        lastname = '',
        email = '',
        imagePath = '',
        about = '',
        branchId = -1;

  bool get isNotEmpty {
    return id > 0;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          lastname == other.lastname &&
          email == other.email &&
          imagePath == other.imagePath &&
          about == other.about &&
          branchId == other.branchId);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      lastname.hashCode ^
      email.hashCode ^
      imagePath.hashCode ^
      about.hashCode ^
      branchId.hashCode;

  @override
  String toString() {
    return 'User{ id: $id, name: $name, lastname: $lastname, email: $email, imagePath: $imagePath, about: $about, branchId: $branchId,}';
  }

  User copyWith({
    int? id,
    String? name,
    String? lastname,
    String? email,
    String? imagePath,
    String? about,
    int? branchId,
  }) {
    return User(
      id: id ?? this.id,
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
      'id': id,
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
      id: map['id'] as int,
      name: map['name'] as String,
      lastname: map['lastname'] as String,
      email: map['email'] as String,
      imagePath: map['imagePath'] as String,
      about: map['about'] as String,
      branchId: map['branchId'] as int,
    );
  }

  @override
  List<Object> get props => [id, name, lastname, email, imagePath, about, branchId];
}