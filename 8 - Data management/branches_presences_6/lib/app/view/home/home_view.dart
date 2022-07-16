import 'package:branches_presences_6/app/bloc/app/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../branches/domain/models/branch.dart';
import '../../../presences/bloc/presences/presences_cubit.dart';
import '../../../presences/view/branch_presences/branch_presences_page.dart';
import '../../../presences/widget/bar_chart_presences.dart';
import '../../bloc/navigation/navigation_cubit.dart';
import '../../widget/home_sliver_app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var navigator = Navigator.of(context);
    var userBranch = context.read<AppBloc>().state.userBranch;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverPersistentHeader(
          pinned: true,
          delegate: HomeSliverAppBar(
            expandedHeight: 200.0,
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(top: 5)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                _buildHeader(
                    context,
                    theme,
                    "La tua sede",
                    "Vedi tutte",
                        () {
                      BlocProvider.of<NavigationCubit>(context)
                          .getNavBarItem(NavbarItem.branches);
                    }
                ),
                const SizedBox(
                  height: 25,
                ),
                _buildUserBranchRecap(context, theme, userBranch),
                const SizedBox(
                  height: 25,
                ),
                _buildHeader(
                    context,
                    theme,
                    "Presenze",
                    "Inserisci",
                        () {
                      navigator.pushNamed(
                          BranchPresencesPage.branchPresencesRoute,
                          arguments: userBranch
                      );
                    }
                ),
                const SizedBox(
                  height: 25,
                ),
                _buildLatestPresencesGraph(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, ThemeData theme, String headerText,
      String actionText, VoidCallback actionCallback) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          headerText,
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: actionCallback,
          child: Text(
            actionText,
            style: TextStyle(
              color: theme.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildUserBranchRecap(
    BuildContext context,
    ThemeData theme,
    Branch userBranch,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 150,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              userBranch.imagePath,
              fit: BoxFit.cover,
              height: 70,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            height: 50,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  userBranch.name,
                  style:
                      theme.textTheme.headline5!.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLatestPresencesGraph(
    BuildContext context,
  ) {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: const Color(0xff2c4260),
        child: BarChartPresences(
          currentPresences:
              context.watch<PresencesCubit>().state.presences,
        ),
      ),
    );
  }
}
