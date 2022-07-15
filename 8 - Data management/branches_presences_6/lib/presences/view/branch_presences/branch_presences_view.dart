import 'package:branches_presences_6/presences/bloc/presences_form/presences_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../domain/data/presences/calendar_presences.dart';
import '../../domain/models/presence.dart';

class BranchPresencesView extends StatelessWidget {

  final List<Presence> presences;

  const BranchPresencesView({
    Key? key,
    required this.presences
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      onSelectionChanged: (selection) {
        if (selection.date != null) {
          context.read<PresencesFormCubit>().selectDate(selection.date!);
        }
      },
      view: CalendarView.month,
      firstDayOfWeek: 1,
      monthViewSettings: const MonthViewSettings(showAgenda: true),
      dataSource: MeetingDataSource(presences),
    );
  }
}
