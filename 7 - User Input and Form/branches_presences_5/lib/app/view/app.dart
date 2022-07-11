import 'package:branches_presences_5/app/bloc/app_bloc.dart';
import 'package:branches_presences_5/branches/bloc/branches_cubit.dart';
import 'package:branches_presences_5/branches/branches.dart';
import 'package:branches_presences_5/presences/bloc/presences/presences_cubit.dart';
import 'package:branches_presences_5/presences/domain/data/presences/local_presences.dart';
import 'package:branches_presences_5/presences/domain/repository/presences/presences_repository.dart';
import 'package:branches_presences_5/users/domain/data/users/local_users.dart';
import 'package:branches_presences_5/users/domain/repository/users/users_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../theme/theme.dart';
import '../routes/navigator_observer.dart';
import '../routes/route.dart';
import 'home_view.dart';

class AppView extends StatelessWidget {
  const AppView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final observer = NavigatorObserverWithOrientation();
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
            create: (_) => BranchesRepository(
                branchesDataProvider: LocalBranches()
            ),
        ),
        RepositoryProvider(
          create: (_) => PresencesRepository(
              presencesDataProvider: LocalPresences()
          ),
        ),
        RepositoryProvider(
          create: (_) => UsersRepository(
              usersDataProvider: LocalUsers()
          ),
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
              usersRepository: ctx.read<UsersRepository>(),
            )..add(const FetchAppUser(),),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: const HomeView(),
          onGenerateRoute: onGenerateRoute,
          navigatorObservers: [observer],
        ),
      ),
    );
  }
}
