import 'package:branches_presences_5/presences/domain/models/presence.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Presence> source){
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    Presence presence = appointments![index];
    return presence.dateTime;
  }

  @override
  DateTime getEndTime(int index) {
    Presence presence = appointments![index];
    return presence.dateTime;
  }

  @override
  String getSubject(int index) {
    Presence presence = appointments![index];
    return presence.username;
  }

  @override
  bool isAllDay(int index) {
    return true;
  }
}