part of 'presences_form_cubit.dart';

enum PresencesFormStatus {
  submissionInProgress,
  submissionSuccess,
  submissionFailed,
  initial,
  dateSelected,
  alreadyExists,
}

class PresencesFormState extends Equatable {
  final DateTime selectedDate;
  final String username;
  final int branchId;
  final PresencesFormStatus status;

  const PresencesFormState({
    required this.selectedDate,
    required this.status,
    required this.username,
    required this.branchId,
  });

  factory PresencesFormState.initial(String username, int branchId) {
    return PresencesFormState(
      selectedDate: DateTime.now().add(const Duration(days: 1)),
      username: username,
      branchId: branchId,
      status: PresencesFormStatus.initial,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PresencesFormState &&
          runtimeType == other.runtimeType &&
          selectedDate == other.selectedDate &&
          status == other.status &&
          branchId == other.branchId &&
          username == other.username
      );

  @override
  int get hashCode => selectedDate.hashCode ^
  status.hashCode ^
  username.hashCode ^
  branchId.hashCode;

  @override
  String toString() {
    return 'PresencesFormState{'
        ' selectedDate: $selectedDate,'
        ' status: $status,'
        ' username: $username,'
        ' branchId: $branchId,'
        '}';
  }

  PresencesFormState copyWith({
    DateTime? selectedDate,
    PresencesFormStatus? status,
    String? username,
    int? branchId,
  }) {
    return PresencesFormState(
      selectedDate: selectedDate ?? this.selectedDate,
      status: status ?? this.status,
      username: username ?? this.username,
      branchId: branchId ?? this.branchId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'selectedDate': selectedDate,
      'status': status,
      'username': username,
      'branchId': branchId,
    };
  }

  factory PresencesFormState.fromMap(Map<String, dynamic> map) {
    return PresencesFormState(
      selectedDate: map['selectedDate'] as DateTime,
      status: map['status'] as PresencesFormStatus,
      username: map['username'] as String,
      branchId: map['branchId'] as int,
    );
  }

  @override
  List<Object> get props => [ selectedDate, status, username, branchId ];
}
