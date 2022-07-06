import 'package:branches_presences_4/app/routes/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NavigatorObserverWithOrientation extends NavigatorObserver {

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    var arguments = previousRoute != null && previousRoute.settings.arguments != null ?
    previousRoute.settings.arguments as RouteSettingsData : null;
    _setOrientation(
        arguments != null ? arguments.rotation : ScreenOrientation.rotating
    );
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    var arguments = route.settings.arguments != null ?
    route.settings.arguments as RouteSettingsData : null;
    _setOrientation(
        arguments != null ? arguments.rotation : ScreenOrientation.rotating
    );
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    var arguments = newRoute != null && newRoute.settings.arguments != null ?
    newRoute.settings.arguments as RouteSettingsData : null;
    _setOrientation(
        arguments != null ? arguments.rotation : ScreenOrientation.rotating
    );
  }
}

enum ScreenOrientation {
  portraitOnly,
  landscapeOnly,
  rotating,
}

void _setOrientation(ScreenOrientation orientation) {
  List<DeviceOrientation> orientations;
  switch (orientation) {
    case ScreenOrientation.portraitOnly:
      orientations = [
        DeviceOrientation.portraitUp,
      ];
      break;
    case ScreenOrientation.landscapeOnly:
      orientations = [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ];
      break;
    case ScreenOrientation.rotating:
      orientations = [
        DeviceOrientation.portraitUp,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ];
      break;
  }
  SystemChrome.setPreferredOrientations(orientations);
}