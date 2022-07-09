part of 'branches_cubit.dart';

class BranchesState extends Equatable {
  final List<Branch> branches;

  const BranchesState({
    required this.branches,
  });

  factory BranchesState.initial() {
    return const BranchesState(branches: []);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BranchesState &&
          runtimeType == other.runtimeType &&
          branches == other.branches);

  @override
  int get hashCode => branches.hashCode;

  @override
  String toString() {
    return 'BranchesState{ branches: $branches,}';
  }

  BranchesState copyWith({
    List<Branch>? branches,
  }) {
    return BranchesState(
      branches: branches ?? this.branches,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'branches': branches,
    };
  }

  factory BranchesState.fromMap(Map<String, dynamic> map) {
    return BranchesState(
      branches: map['branches'] as List<Branch>,
    );
  }

  @override
  List<Object?> get props => [ branches ];
}
