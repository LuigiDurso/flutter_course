import 'package:branches_presences_3/app/view/home_view.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../routes/route.dart';

class AppView extends StatelessWidget {
  const AppView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const HomeView(),
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
    );
  }
}
