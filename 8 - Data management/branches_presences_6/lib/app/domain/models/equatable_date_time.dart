import 'package:equatable/equatable.dart';

class EquatableDateTime extends DateTime with EquatableMixin {
  EquatableDateTime(
      int year, [
        int month = 1,
        int day = 1,
        int hour = 0,
        int minute = 0,
        int second = 0,
        int millisecond = 0,
        int microsecond = 0,
      ]) : super(year, month, day, hour, minute, second, millisecond, microsecond);

  EquatableDateTime.fromDateTime(DateTime dateTime) : super(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
      dateTime.second,
      dateTime.millisecond,
      dateTime.microsecond
  );

  @override
  List<Object> get props {
    return [year, month, day, hour, minute, second, millisecond, microsecond];
  }
}