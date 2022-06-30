import 'dart:math';

class Branch {
  final int id;
  final String name;
  final String address;
  final String imagePath;
  final bool isCoWorking;

  const Branch({
    required this.id,
    required this.name,
    required this.address,
    required this.imagePath,
    required this.isCoWorking,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Branch &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          address == other.address &&
          imagePath == other.imagePath &&
          isCoWorking == other.isCoWorking);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      address.hashCode ^
      imagePath.hashCode ^
      isCoWorking.hashCode;

  Branch copyWith({
    int? id,
    String? name,
    String? address,
    String? imagePath,
    bool? isCoWorking,
  }) {
    return Branch(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      imagePath: imagePath ?? this.imagePath,
      isCoWorking: isCoWorking ?? this.isCoWorking,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'imagePath': imagePath,
      'isCoWorking': isCoWorking,
    };
  }

  factory Branch.fromMap(Map<String, dynamic> map) {
    return Branch(
      id: (map['id'] ?? -1) as int,
      name: map['name'] as String,
      address: map['address'] as String,
      imagePath: map['imagePath'] as String,
      isCoWorking: (map['isCoWorking'] ?? false) as bool,
    );
  }

  @override
  String toString() {
    return 'Branch{ id: $id, name: $name, address: $address, imagePath: $imagePath, isCoWorking: $isCoWorking,}';
  }
}
