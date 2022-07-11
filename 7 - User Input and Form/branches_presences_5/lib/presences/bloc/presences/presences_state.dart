part of 'presences_cubit.dart';

class PresencesState extends Equatable {
  final List<Presence> presences;

  const PresencesState({
    required this.presences,
  });

  factory PresencesState.initial() {
    return const PresencesState(presences: []);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PresencesState &&
          runtimeType == other.runtimeType &&
          presences == other.presences);

  @override
  int get hashCode => presences.hashCode;

  @override
  String toString() {
    return 'PresencesState{ presences: $presences,}';
  }

  PresencesState copyWith({
    List<Presence>? presences,
  }) {
    return PresencesState(
      presences: presences ?? this.presences,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'presences': presences,
    };
  }

  factory PresencesState.fromMap(Map<String, dynamic> map) {
    return PresencesState(
      presences: map['presences'] as List<Presence>,
    );
  }

  @override
  List<Object?> get props => [ presences ];
}