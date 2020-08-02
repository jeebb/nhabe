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

class Date {
  final int year;
  final int month;
  final int day;

  Date(this.year, this.month, this.day)
      : assert(year != null && month != null && day != null);

  static Date fromDateTime(DateTime dt) => Date(dt.year, dt.month, dt.day);

  @override
  bool operator ==(other) =>
      other.year == year && other.month == month && other.day == day;

  @override
  int get hashCode {
    int result = 1;

    result = 17 * result + year.hashCode;
    result = 17 * result + month.hashCode;
    result = 17 * result + day.hashCode;

    return result;
  }
}
