class Branch {
  final String name;
  final String address;
  final bool isCoWorking;

  const Branch({
    required this.name,
    required this.address,
    required this.isCoWorking,
  });

  Branch.ownBranch(this.name, this.address) :
        isCoWorking = false;

  Branch copyWith({
    String? name,
    String? address,
    bool? isCoWorking,
  }) {
    return Branch(
      name: name ?? this.name,
      address: address ?? this.address,
      isCoWorking: isCoWorking ?? this.isCoWorking,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'isCoWorking': isCoWorking,
    };
  }

  factory Branch.fromMap(Map<String, dynamic> map) {
    return Branch(
      name: map['name'] as String,
      address: map['address'] as String,
      isCoWorking: (map['isCoWorking'] ?? false) as bool,
    );
  }

  @override
  String toString() {
    return 'Branch{name: $name, address: $address, isCoWorking: $isCoWorking}';
  }
}