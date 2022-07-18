import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

import '../../../app/utils/async_call_status.dart';
import '../../domain/models/location_pin.dart';
import '../../domain/repository/open_street_map/open_street_map_repository.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {

  final OpenStreetMapRepository openStreetMapRepository;

  LocationCubit({
    required this.openStreetMapRepository
  }) : super(LocationState.initial());

  Future<void> getCoordinatesByAddress(String address, String name) async {
    try {
      emit(state.copyWith(status: AsyncCallStatus.loading));
      var coordinates = await openStreetMapRepository
          .getCoordinatesByAddress(address);
      emit(
          state.copyWith(
            pin: LocationPin(position: coordinates, name: name, address: address),
            status: AsyncCallStatus.success,
          )
      );
    } on Exception catch (e) {
      print('$e');
      emit(state.copyWith(status: AsyncCallStatus.failure));
    }
  }
}
