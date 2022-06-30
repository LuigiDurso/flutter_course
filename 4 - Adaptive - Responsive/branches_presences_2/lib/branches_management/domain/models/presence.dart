class Presence {
  final int branchId;
  final DateTime dateTime;
  final String username;

  const Presence({
    required this.branchId,
    required this.dateTime,
    required this.username,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Presence &&
          runtimeType == other.runtimeType &&
          branchId == other.branchId &&
          dateTime == other.dateTime &&
          username == other.username);

  @override
  int get hashCode => branchId.hashCode ^ dateTime.hashCode ^ username.hashCode;

  @override
  String toString() {
    return 'Presence{ branchId: $branchId, dateTime: $dateTime, username: $username,}';
  }

  Presence copyWith({
    int? branchId,
    DateTime? dateTime,
    String? username,
  }) {
    return Presence(
      branchId: branchId ?? this.branchId,
      dateTime: dateTime ?? this.dateTime,
      username: username ?? this.username,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'branchId': branchId,
      'dateTime': dateTime,
      'username': username,
    };
  }

  factory Presence.fromMap(Map<String, dynamic> map) {
    return Presence(
      branchId: map['branchId'] as int,
      dateTime: map['dateTime'] as DateTime,
      username: map['username'] as String,
    );
  }
}