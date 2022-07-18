import 'package:branches_presences_7/branches/bloc/location/location_cubit.dart';
import 'package:branches_presences_7/branches/domain/data/location/openstreetmap_client.dart';
import 'package:branches_presences_7/branches/domain/repository/open_street_map/open_street_map_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

import '../../../app/utils/async_call_status.dart';
import '../../../app/utils/spinner_dialog.dart';
import '../../../app/widget/confirm_message_dialog.dart';
import '../../domain/models/branch.dart';
import '../../widget/animated_map_controller.dart';

class BranchesDetailView extends StatelessWidget {

  final Branch selectedBranch;

  const BranchesDetailView({
    Key? key,
    required this.selectedBranch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var navigator = Navigator.of(context);

    return Column(
      children: [
        Flexible(
          child: SizedBox(
            width: double.infinity,
            height: 200,
            child: Stack(
              clipBehavior: Clip.none,
              fit: StackFit.expand,
              children: [
                Hero(
                  tag: selectedBranch.name,
                  child: ClipRect(
                    child: FadeInImage.assetNetwork(
                      image: selectedBranch.imagePath,
                      fit: BoxFit.cover,
                      height: 70,
                      placeholder: 'assets/images/branch-placeholder.png',
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  height: 70,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedBranch.name,
                            style:
                            theme.textTheme.headline5!.copyWith(
                                color: Colors.white),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            selectedBranch.address,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Posizione",
                  style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Expanded(
          child: Card(
            elevation: 10,
            child: RepositoryProvider(
              create: (context) =>
                  OpenStreetMapRepository(
                      locationDataProvider: OpenStreetMapClient()
                  ),
              child: BlocProvider(
                create: (context) => LocationCubit(
                    openStreetMapRepository: context.read<OpenStreetMapRepository>(),
                ),
                child: Builder(
                  builder: (context) {
                    return BlocListener<LocationCubit, LocationState>(
                      listener: (context, state) {
                        if (state.status == AsyncCallStatus.failure) {
                          SpinnerDialog.closeSpinnerDialog(navigator);
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          showDialog<void>(
                            context: context,
                            builder: (_) => const ConfirmMessageDialog(
                              message: 'Errore di caricamento',
                            ),
                          );
                        }
                        if (state.status == AsyncCallStatus.loading) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          SpinnerDialog.buildShowDialog(context);
                        }
                        if (state.status == AsyncCallStatus.success) {
                          SpinnerDialog.closeSpinnerDialog(navigator);
                        }
                      },
                      child: Builder(
                        builder: (context) {
                          context.read<LocationCubit>().getCoordinatesByAddress(
                             selectedBranch.address,
                             selectedBranch.name,
                          );
                          return const AnimatedMap();
                        },
                      ),
                    );
                  }
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
