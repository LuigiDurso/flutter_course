import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/navigation/navigation_cubit.dart';
import '../../routes/route.dart';

class RootPage extends StatelessWidget {
  static const String rootRoute = '/';

  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: BottomNavigationBar(
              backgroundColor: theme.primaryColor,
              currentIndex: state.index,
              selectedItemColor: Colors.white,
              showUnselectedLabels: false,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_work,
                    color: Colors.white,
                  ),
                  label: 'Sedi',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  label: 'Profilo',
                ),
              ],
              onTap: (index) {
                switch (index) {
                  case 0:
                    BlocProvider.of<NavigationCubit>(context)
                        .getNavBarItem(NavbarItem.home);
                    break;
                  case 1:
                    BlocProvider.of<NavigationCubit>(context)
                        .getNavBarItem(NavbarItem.branches);
                    break;
                  case 2:
                    BlocProvider.of<NavigationCubit>(context)
                        .getNavBarItem(NavbarItem.profile);
                    break;
                }
              },
            ),
          );
        },
      ),
      body: const BlocBuilder<NavigationCubit, NavigationState>(
          builder: getPageByNavBarItem),
    );
  }
}
