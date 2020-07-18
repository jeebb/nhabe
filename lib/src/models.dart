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
