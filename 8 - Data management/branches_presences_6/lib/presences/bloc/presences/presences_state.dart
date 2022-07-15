part of 'presences_cubit.dart';

class PresencesState extends Equatable {
  final List<Presence> presences;
  final AsyncCallStatus status;

  const PresencesState({
    required this.presences,
    required this.status,
  });

  factory PresencesState.initial() {
    return const PresencesState(presences: [], status: AsyncCallStatus.initial);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PresencesState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          presences == other.presences);

  @override
  int get hashCode => presences.hashCode ^ status.hashCode;

  @override
  String toString() {
    return 'PresencesState{ presences: $presences, status: $status, }';
  }

  PresencesState copyWith({
    List<Presence>? presences,
    AsyncCallStatus? status,
  }) {
    return PresencesState(
      presences: presences ?? this.presences,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'presences': presences,
      'status': status,
    };
  }

  factory PresencesState.fromMap(Map<String, dynamic> map) {
    return PresencesState(
      presences: map['presences'] as List<Presence>,
      status: map['status'] as AsyncCallStatus,
    );
  }

  @override
  List<Object?> get props => [ presences, status ];
}