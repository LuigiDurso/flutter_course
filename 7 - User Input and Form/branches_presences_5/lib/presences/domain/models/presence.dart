import 'package:branches_presences_5/app/domain/models/equatable_date_time.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Presence extends Equatable {
  final int branchId;
  final EquatableDateTime dateTime;
  final String username;

  const Presence({
    required this.branchId,
    required this.dateTime,
    required this.username,
  });

  @override
  String toString() {
    return 'Presence{ branchId: $branchId, dateTime: $dateTime, username: $username,}';
  }

  Presence copyWith({
    int? branchId,
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
      'dateTime': dateTime,
      'username': username,
    };
  }

  factory Presence.fromMap(Map<String, dynamic> map) {
    return Presence(
      branchId: map['branchId'] as int,
      dateTime: map['dateTime'] as EquatableDateTime,
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