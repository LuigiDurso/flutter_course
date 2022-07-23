import 'package:equatable/equatable.dart';

class Branch extends Equatable {
  final String uid;
  final String name;
  final String address;
  final String imagePath;
  final bool isCoWorking;

  const Branch({
    required this.uid,
    required this.name,
    required this.address,
    required this.imagePath,
    required this.isCoWorking,
  });

  const Branch.empty() :
        uid = '', name = '', address = '', imagePath = '', isCoWorking = false;

  get isNotEmpty {
    return uid.isNotEmpty;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Branch &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          name == other.name &&
          address == other.address &&
          imagePath == other.imagePath &&
          isCoWorking == other.isCoWorking);

  @override
  int get hashCode =>
      uid.hashCode ^
      name.hashCode ^
      address.hashCode ^
      imagePath.hashCode ^
      isCoWorking.hashCode;

  Branch copyWith({
    String? uid,
    String? name,
    String? address,
    String? imagePath,
    bool? isCoWorking,
  }) {
    return Branch(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      address: address ?? this.address,
      imagePath: imagePath ?? this.imagePath,
      isCoWorking: isCoWorking ?? this.isCoWorking,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'address': address,
      'imagePath': imagePath,
      'isCoWorking': isCoWorking,
    };
  }

  factory Branch.fromMap(Map<String, dynamic> map) {
    return Branch(
      uid: (map['uid'] ?? '') as String,
      name: map['name'] as String,
      address: map['address'] as String,
      imagePath: map['imagePath'] as String,
      isCoWorking: (map['isCoWorking'] ?? false) as bool,
    );
  }

  @override
  String toString() {
    return 'Branch{ uid: $uid, name: $name, address: $address, imagePath: $imagePath, isCoWorking: $isCoWorking,}';
  }

  @override
  List<Object> get props => [uid, name, address, imagePath, isCoWorking];
}
