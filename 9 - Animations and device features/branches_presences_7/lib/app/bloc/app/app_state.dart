part of 'app_bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
}

extension AppStatusDeserializer on AppStatus {
  static AppStatus fromString (status) =>
      AppStatus.values.firstWhere((e) => e.toString() == status);
}

class AppState extends Equatable {
  final AppStatus status;
  final User user;
  final Branch userBranch;
  final String token;

  const AppState._({
    required this.status,
    this.user = const User.empty(),
    this.userBranch = const Branch.empty(),
    this.token = '',
  });

  const AppState.authenticated(User user, Branch userBranch, String token)
      : this._(
    status: AppStatus.authenticated,
    user: user,
    userBranch: userBranch,
    token: token,
  );

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          user == other.user &&
          token == other.token &&
          userBranch == other.userBranch);

  @override
  int get hashCode => status.hashCode ^
  user.hashCode ^
  token.hashCode ^
  userBranch.hashCode;

  @override
  String toString() {
    return 'AppState{'
        ' status: $status,'
        ' user: $user,'
        ' token: $token,'
        ' userBranch: $userBranch,'
        '}';
  }

  AppState copyWith({
    AppStatus? status,
    User? user,
    Branch? userBranch,
    String? token,
  }) {
    return AppState._(
      status: status ?? this.status,
      user: user ?? this.user,
      token: token ?? this.token,
      userBranch: userBranch ?? this.userBranch,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status.toString(),
      'user': user.toMap(),
      'userBranch': userBranch.toMap(),
      'token': token,
    };
  }

  factory AppState.fromMap(Map<String, dynamic> map) {
    return AppState._(
      status: AppStatusDeserializer.fromString(map['status']),
      user: User.fromMap(map['user']),
      userBranch: Branch.fromMap(map['userBranch']),
      token: map['token'] as String,
    );
  }

  @override
  List<Object> get props => [ status, user, userBranch, token ];
}