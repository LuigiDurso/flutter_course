import 'package:latlong2/latlong.dart';

abstract class LocationDataProvider {
  Future<LatLng> getCoordinatesByAddress(String address);
}