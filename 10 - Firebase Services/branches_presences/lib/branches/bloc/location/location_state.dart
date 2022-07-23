part of 'location_cubit.dart';

class LocationState extends Equatable {

  final LocationPin pin;
  final AsyncCallStatus status;

  factory LocationState.initial() {
    return LocationState(
      pin: LocationPin(position: LatLng(50.0, 50.0), name: '', address: ''),
      status: AsyncCallStatus.initial,
    );
  }

  const LocationState({
    required this.pin,
    required this.status,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocationState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          pin == other.pin);

  @override
  int get hashCode => pin.hashCode ^ status.hashCode;

  @override
  String toString() {
    return 'LocationState{ pin: $pin, status: $status,}';
  }

  LocationState copyWith({
    LocationPin? pin,
    AsyncCallStatus? status,
  }) {
    return LocationState(
      pin: pin ?? this.pin,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pin': pin,
      'status': status,
    };
  }

  factory LocationState.fromMap(Map<String, dynamic> map) {
    return LocationState(
      pin: map['pin'] as LocationPin,
      status: map['status'] as AsyncCallStatus,
    );
  }

  @override
  List<Object> get props => [ pin, status ];
}
