import 'package:branches_presences/app/utils/async_call_status.dart';
import 'package:branches_presences/presences/bloc/presences_form/presences_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../bloc/presences/presences_cubit.dart';
import '../../domain/data/presences/calendar_presences.dart';

class BranchPresencesView extends StatelessWidget {

  final String branchId;

  const BranchPresencesView({
    Key? key,
    required this.branchId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PresencesCubit>().fetchPresencesByBranchId(branchId);
    return BlocBuilder<PresencesCubit, PresencesState>(
      builder: (context, state) {
        print('presences ${state.presences}');
        return SfCalendar(
          onSelectionChanged: (selection) {
            if (selection.date != null) {
              context.read<PresencesFormCubit>().selectDate(selection.date!);
            }
          },
          view: CalendarView.month,
          firstDayOfWeek: 1,
          monthViewSettings: const MonthViewSettings(showAgenda: true),
          dataSource: MeetingDataSource(
              state.presences
          ),
        );
      },
    );
  }
}
