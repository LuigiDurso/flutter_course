part of 'app_bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
}

class AppState extends Equatable {
  final AppStatus status;
  final User user;
  final Branch userBranch;

  const AppState._({
    required this.status,
    this.user = const User.empty(),
    this.userBranch = const Branch.empty()
  });

  const AppState.authenticated(User user, Branch userBranch)
      : this._(
      status: AppStatus.authenticated, user: user, userBranch: userBranch
  );

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          user == other.user &&
          userBranch == other.userBranch);

  @override
  int get hashCode => status.hashCode ^ user.hashCode ^ userBranch.hashCode;

  @override
  String toString() {
    return 'AppState{ status: $status, user: $user, userBranch: $userBranch,}';
  }

  AppState copyWith({
    AppStatus? status,
    User? user,
    Branch? userBranch,
  }) {
    return AppState._(
      status: status ?? this.status,
      user: user ?? this.user,
      userBranch: userBranch ?? this.userBranch,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'user': user,
      'userBranch': userBranch,
    };
  }

  factory AppState.fromMap(Map<String, dynamic> map) {
    return AppState._(
      status: map['status'] as AppStatus,
      user: map['user'] as User,
      userBranch: map['userBranch'] as Branch,
    );
  }

  @override
  List<Object> get props => [ status, user, userBranch ];
}