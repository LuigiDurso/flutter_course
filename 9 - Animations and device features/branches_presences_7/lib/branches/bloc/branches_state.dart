part of 'branches_cubit.dart';

class BranchesState extends Equatable {
  final List<Branch> branches;
  final AsyncCallStatus status;

  const BranchesState({
    required this.branches,
    required this.status,
  });

  factory BranchesState.initial() {
    return const BranchesState(branches: [], status: AsyncCallStatus.initial,);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BranchesState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          branches == other.branches);

  @override
  int get hashCode => branches.hashCode ^ status.hashCode;

  @override
  String toString() {
    return 'BranchesState{ branches: $branches, status: $status,}';
  }

  BranchesState copyWith({
    List<Branch>? branches,
    AsyncCallStatus? status,
  }) {
    return BranchesState(
      branches: branches ?? this.branches,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'branches': branches,
      'status': status,
    };
  }

  factory BranchesState.fromMap(Map<String, dynamic> map) {
    return BranchesState(
      branches: map['branches'] as List<Branch>,
      status: map['status'] as AsyncCallStatus,
    );
  }

  @override
  List<Object?> get props => [ branches, status ];
}
