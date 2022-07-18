enum AsyncCallStatus { initial, loading, success, failure }

extension AsyncCallStatusX on AsyncCallStatus {
  bool get isInitial => this == AsyncCallStatus.initial;
  bool get isLoading => this == AsyncCallStatus.loading;
  bool get isSuccess => this == AsyncCallStatus.success;
  bool get isFailure => this == AsyncCallStatus.failure;
}