import 'package:branches_presences_4/app/view/home_view.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../routes/navigator_observer.dart';
import '../routes/route.dart';

class AppView extends StatelessWidget {
  const AppView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final observer = NavigatorObserverWithOrientation();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const HomeView(),
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
      navigatorObservers: [observer],
    );
  }
}
