part of nhabe;

class NBEventData {}

class MonthAndYear {
  int month;
  int year;

  MonthAndYear({@required this.month, @required this.year});

  static MonthAndYear fromDateTime(DateTime dateTime) =>
      MonthAndYear(month: dateTime.month, year: dateTime.year);

  DateTime toDateTime() => DateTime(year, month);

  @override
  String toString() => "MonthAndYear{month: $month, year: $year}";
}

class DayAndMonth {
  int day;
  int month;

  DayAndMonth({@required this.day, @required this.month});

  @override
  String toString() => "DayAndMonth{day: $day,  month: $month}";
}
