import 'package:branches_presences/app/domain/models/equatable_date_time.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Presence extends Equatable {
  final String branchId;
  final EquatableDateTime dateTime;
  final String username;

  const Presence({
    required this.branchId,
    required this.dateTime,
    required this.username,
  });

  factory Presence.empty() {
    return Presence(
        branchId: '',
        dateTime: EquatableDateTime.fromDateTime(DateTime.now()),
        username: ''
    );
  }

  get id {
    return '$branchId${dateTime.millisecondsSinceEpoch}${username.replaceAll(".", "")}';
  }

  bool get isNotEmpty {
    return branchId.isNotEmpty;
  }

  @override
  String toString() {
    return 'Presence{ branchId: $branchId, dateTime: $dateTime, username: $username,}';
  }

  Presence copyWith({
    String? branchId,
    EquatableDateTime? dateTime,
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
      'dateTime': dateTime.toIso8601String(),
      'username': username,
    };
  }

  factory Presence.fromMap(Map<String, dynamic> map) {
    return Presence(
      branchId: map['branchId'] as String,
      dateTime: EquatableDateTime.fromDateTime(DateTime.parse(map['dateTime'])),
      username: map['username'] as String,
    );
  }

  @override
  List<Object> get props => [
    branchId,
    dateTime,
    username
  ];
}