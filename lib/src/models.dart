part of nhabe;

class NBEventData {}

class MonthAndYear {
  int month;
  int year;

  MonthAndYear({required this.month, required this.year});

  static MonthAndYear fromDateTime(DateTime dateTime) =>
      MonthAndYear(month: dateTime.month, year: dateTime.year);

  DateTime toDateTime() => DateTime(year, month);

  @override
  String toString() => "MonthAndYear{month: $month, year: $year}";

  bool equals(MonthAndYear input) => month == input.month && year == input.year;
}

class Date {
  final int year;
  final int month;
  final int day;

  Date({required this.year, required this.month, required this.day});

  static Date fromDateTime(DateTime dt) =>
      Date(year: dt.year, month: dt.month, day: dt.day);

  @override
  bool operator ==(other) {
    if (other is Date) {
      return other.year == year && other.month == month && other.day == day;
    }

    return false;
  }

  @override
  int get hashCode {
    int result = 1;

    result = 17 * result + year.hashCode;
    result = 17 * result + month.hashCode;
    result = 17 * result + day.hashCode;

    return result;
  }
}
