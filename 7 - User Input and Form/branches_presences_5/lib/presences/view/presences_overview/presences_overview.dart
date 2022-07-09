import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../domain/models/presence.dart';
import '../../widget/bar_chart_presences.dart';

class PresencesOverview extends StatelessWidget {
  final int branchId;
  final String branchName;
  final String branchImagePath;
  final List<Presence> currentPresences;


  const PresencesOverview({
    Key? key,
    required this.branchId,
    required this.branchName,
    required this.branchImagePath,
    required this.currentPresences
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: LayoutBuilder(
                    builder: (_, constraints) => Stack(
                      children: [
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              branchImagePath,
                              fit: BoxFit.cover,
                              width: constraints.maxWidth,
                              height: constraints.maxHeight,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 3,
                          right: 3,
                          left: 3,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                branchName,
                                style: theme.textTheme.headline5!.copyWith(
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 2,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  color: const Color(0xff2c4260),
                  child: BarChartPresences(currentPresences: currentPresences,),
                ),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, index) => Card(
              child: ListTile(
                title: Text(currentPresences[index].username),
                subtitle: Text(DateFormat.yMMMd()
                    .format(currentPresences[index].dateTime)),
              ),
            ),
            itemCount: currentPresences.length,
          ),
        )
      ],
    );
  }
}
