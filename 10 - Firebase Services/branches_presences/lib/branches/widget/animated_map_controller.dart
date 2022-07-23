import 'package:branches_presences/app/theme/theme.dart';
import 'package:branches_presences/branches/bloc/location/location_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class AnimatedMap extends StatefulWidget {
  const AnimatedMap({
    Key? key,
  }) : super(key: key);

  @override
  AnimatedMapPageState createState() {
    return AnimatedMapPageState();
  }
}

class AnimatedMapPageState extends State<AnimatedMap>
    with TickerProviderStateMixin {
  late final MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    final latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);

    var controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationCubit, LocationState>(
      listener: (context, state) {
        _animatedMapMove(state.pin.position, 10.0);
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    OutlinedButton(
                      onPressed: () {
                        _animatedMapMove(state.pin.position, 10.0);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.pin_drop_outlined,
                            color: theme.primaryColor,
                          ),
                          Text(state.pin.name),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: FlutterMap(
                  mapController: mapController,
                  options: MapOptions(zoom: 5.0, maxZoom: 10.0, minZoom: 3.0),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                    ),
                    MarkerLayerOptions(markers: [
                      Marker(
                        width: 25.0,
                        height: 25.0,
                        point: state.pin.position,
                        builder: (ctx) => Container(
                          key: Key(state.pin.name),
                          child: Icon(
                            Icons.pin_drop_outlined,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      )
                    ])
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
