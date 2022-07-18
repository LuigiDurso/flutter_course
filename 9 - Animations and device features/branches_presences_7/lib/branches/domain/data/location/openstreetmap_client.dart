import 'dart:convert';

import 'package:branches_presences_7/branches/domain/data/location/location_data_provider.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class CoordinatesRequestFailure implements Exception {}
class CoordinatesNotFoundFailure implements Exception {}

class OpenStreetMapClient implements LocationDataProvider {
  final _baseUrl = "nominatim.openstreetmap.org";

  final http.Client _httpClient;

  OpenStreetMapClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  @override
  Future<LatLng> getCoordinatesByAddress(String address) async {
    final locationRequest = Uri.https(
      _baseUrl,
      '/search',
      { 'format': 'json', 'q': address }
    );
    final locationResponse = await _httpClient.get(locationRequest,);

    final locationJson = (jsonDecode(
      locationResponse.body,
    )) as List;

    if (locationJson.isEmpty) {
      throw CoordinatesNotFoundFailure();
    }

    return LatLng(
      double.parse(locationJson[0]['lat']),
      double.parse(locationJson[0]['lon']),
    );
  }
}
