part of nhabe;

class NBEventData {}

class MonthAndYear {
  int month;
  int year;

  MonthAndYear({@required this.month, @required this.year})
      : assert(month != null),
        assert(year != null);

  static MonthAndYear fromDateTime(DateTime dateTime) =>
      MonthAndYear(month: dateTime.month, year: dateTime.year);

  DateTime toDateTime() => DateTime(year, month);

  @override
  String toString() => "MonthAndYear{month: $month, year: $year}";

  bool equals(MonthAndYear input) {
    assert(input != null, 'Input param cannot be null');

    return month == input.month && year == input.year;
  }
}
