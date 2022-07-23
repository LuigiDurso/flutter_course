import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class LocationPin extends Equatable {
  final LatLng position;
  final String name;
  final String address;

  const LocationPin({
    required this.position,
    required this.name,
    required this.address,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocationPin &&
          runtimeType == other.runtimeType &&
          position == other.position &&
          name == other.name &&
          address == other.address);

  @override
  int get hashCode => position.hashCode ^ name.hashCode ^ address.hashCode;

  @override
  String toString() {
    return 'LocationPin{ position: $position, name: $name, address: $address,}';
  }

  LocationPin copyWith({
    LatLng? position,
    String? name,
    String? address,
  }) {
    return LocationPin(
      position: position ?? this.position,
      name: name ?? this.name,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'position': this.position,
      'name': this.name,
      'address': this.address,
    };
  }

  factory LocationPin.fromMap(Map<String, dynamic> map) {
    return LocationPin(
      position: map['position'] as LatLng,
      name: map['name'] as String,
      address: map['address'] as String,
    );
  }

  @override
  List<Object> get props => [ position, name, address ];
}