import 'package:branches_presences/app/bloc/app/app_bloc.dart';
import 'package:branches_presences/app/bloc/navigation/navigation_cubit.dart';
import 'package:branches_presences/branches/bloc/branches/branches_cubit.dart';
import 'package:branches_presences/branches/branches.dart';
import 'package:branches_presences/branches/domain/data/branches/firebase_branches_client.dart';
import 'package:branches_presences/presences/bloc/presences/presences_cubit.dart';
import 'package:branches_presences/presences/domain/repository/presences/presences_repository.dart';
import 'package:branches_presences/users/domain/data/users/firebase_users_client.dart';
import 'package:branches_presences/users/domain/repository/users/users_repository.dart';
import 'package:branches_presences/users/view/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presences/domain/data/presences/firebase_presences_client.dart';
import '../theme/theme.dart';
import '../routes/navigator_observer.dart';
import '../routes/route.dart';
import 'root/root_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) =>
              BranchesRepository(
                  branchesDataProvider: FirebaseBranchesClient(),
              ),
        ),
        RepositoryProvider(
          create: (_) =>
              PresencesRepository(
                  presencesDataProvider: FirebasePresencesClient(),
              ),
        ),
        RepositoryProvider(
          create: (_) => UsersRepository(
              usersDataProvider: FirebaseUsersClient(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (ctx) => BranchesCubit(
              branchesRepository: ctx.read<BranchesRepository>(),
            ),
          ),
          BlocProvider(
            create: (ctx) => PresencesCubit(
              presencesRepository: ctx.read<PresencesRepository>(),
            ),
          ),
          BlocProvider(
            create: (ctx) => AppBloc(
              branchesRepository: ctx.read<BranchesRepository>(),
              usersRepository: ctx.read<UsersRepository>(),
            ),
          ),
          BlocProvider(
            create: (ctx) => NavigationCubit(),
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
                  RootPage.rootRoute,
                  (route) => false,
                );
                break;
              case AppStatus.unauthenticated:
                _navigator.pushNamedAndRemoveUntil<void>(
                  LoginPage.loginRoute,
                  (route) => false,
                );
                context.read<AppBloc>().clear();
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
                builder: (_) => const RootPage(),
                settings:
                    rotationSettings(routeSettings, ScreenOrientation.portraitOnly),
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
