import 'package:flutter/material.dart';
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
      onLongPress: (arg) {
        print(arg.date);
      },
      view: CalendarView.month,
      firstDayOfWeek: 1,
      monthViewSettings: const MonthViewSettings(showAgenda: true),
      dataSource: MeetingDataSource(presences),
    );
  }
}
