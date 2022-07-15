import 'package:branches_presences_6/app/bloc/app_bloc.dart';
import 'package:branches_presences_6/branches/bloc/branches_cubit.dart';
import 'package:branches_presences_6/branches/branches.dart';
import 'package:branches_presences_6/presences/bloc/presences/presences_cubit.dart';
import 'package:branches_presences_6/presences/domain/data/presences/local_presences.dart';
import 'package:branches_presences_6/presences/domain/repository/presences/presences_repository.dart';
import 'package:branches_presences_6/users/domain/data/users/local_users.dart';
import 'package:branches_presences_6/users/domain/repository/users/users_repository.dart';
import 'package:branches_presences_6/users/view/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../theme/theme.dart';
import '../routes/navigator_observer.dart';
import '../routes/route.dart';
import 'home_view.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) =>
              BranchesRepository(branchesDataProvider: LocalBranches()),
        ),
        RepositoryProvider(
          create: (_) =>
              PresencesRepository(presencesDataProvider: LocalPresences()),
        ),
        RepositoryProvider(
          create: (_) => UsersRepository(usersDataProvider: LocalUsers()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (ctx) => BranchesCubit(
              branchesRepository: ctx.read<BranchesRepository>(),
            )..fetchAllBranches(),
          ),
          BlocProvider(
            create: (ctx) => PresencesCubit(
              presencesRepository: ctx.read<PresencesRepository>(),
            ),
          ),
          BlocProvider(
            create: (ctx) => AppBloc(
              branchesCubit: ctx.read<BranchesCubit>(),
            ),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({
    Key? key,
  }) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    final observer = NavigatorObserverWithOrientation();
    return MaterialApp(
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: theme,
      builder: (context, child) {
        return BlocListener<AppBloc, AppState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            switch (state.status) {
              case AppStatus.authenticated:
                _navigator.pushNamedAndRemoveUntil<void>(
                  HomeView.homeRoute,
                  (route) => false,
                );
                break;
              case AppStatus.unauthenticated:
                _navigator.pushNamedAndRemoveUntil<void>(
                  LoginPage.loginRoute,
                  (route) => false,
                );
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: onGenerateRoute,
      onUnknownRoute: (routeSettings) {
        return context.read<AppBloc>().state.status == AppStatus.authenticated
            ? MaterialPageRoute(
                builder: (_) => const HomeView(),
                settings:
                    rotationSettings(routeSettings, ScreenOrientation.rotating),
              )
            : MaterialPageRoute(
                builder: (_) => const LoginPage(),
                settings: rotationSettings(
                    routeSettings, ScreenOrientation.portraitOnly),
              );
      },
      navigatorObservers: [observer],
    );
  }
}
