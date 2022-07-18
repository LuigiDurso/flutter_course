import 'package:branches_presences_7/branches/domain/data/location/location_data_provider.dart';
import 'package:latlong2/latlong.dart';

class OpenStreetMapRepository {
  
  final LocationDataProvider locationDataProvider;

  OpenStreetMapRepository({
    required this.locationDataProvider
  });

  Future<LatLng> getCoordinatesByAddress(String address) {
    return locationDataProvider.getCoordinatesByAddress(address);
  }
}