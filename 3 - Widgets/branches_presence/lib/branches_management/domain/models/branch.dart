class Branch {
  final String name;
  final String address;
  final String imagePath;
  final bool isCoWorking;

  const Branch({
    required this.name,
    required this.address,
    required this.imagePath,
    required this.isCoWorking,
  });

  Branch.ownBranch(this.name, this.address, this.imagePath) :
        isCoWorking = false;

  Branch copyWith({
    String? name,
    String? address,
    String? imagePath,
    bool? isCoWorking,
  }) {
    return Branch(
      name: name ?? this.name,
      address: address ?? this.address,
      imagePath: imagePath ?? this.imagePath,
      isCoWorking: isCoWorking ?? this.isCoWorking,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'imagePath': imagePath,
      'isCoWorking': isCoWorking,
    };
  }

  factory Branch.fromMap(Map<String, dynamic> map) {
    return Branch(
      name: map['name'] as String,
      address: map['address'] as String,
      imagePath: map['imagePath'] as String,
      isCoWorking: (map['isCoWorking'] ?? false) as bool,
    );
  }

  @override
  String toString() {
    return 'Branch{name: $name,'
        ' address: $address,'
        ' imagePath: $imagePath,'
        ' isCoWorking: $isCoWorking}';
  }
}