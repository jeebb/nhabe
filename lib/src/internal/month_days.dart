part of nhabe;

class _MonthDays extends StatelessWidget {
  final MonthAndYear monthAndYear;
  final int firstDayOfWeek;
  final DateTime selectedDate;
  final TextStyle monthDayLabelStyle;
  final bool showInActiveMonthDays;
  final TextStyle inactiveMonthDayLabelStyle;
  final bool circleSelectedDay;

  final OnDateSelected onDateSelected;

  const _MonthDays({
    @required this.monthAndYear,
    @required this.firstDayOfWeek,
    @required this.monthDayLabelStyle,
    @required this.showInActiveMonthDays,
    @required this.inactiveMonthDayLabelStyle,
    this.circleSelectedDay,
    this.selectedDate,
    this.onDateSelected,
  })  : assert(monthAndYear != null),
        assert(firstDayOfWeek != null);

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          padding: internalComponentPadding,
          shrinkWrap: true,
          crossAxisCount: 7,
          children: _monthDayGridItems(),
        ),
      );

  List<Widget> _monthDayGridItems() {
    final monthDays = <Widget>[];

    var dayToBuild = _initialWidgetDate(monthAndYear);

    var lastDayOfMonth = DateTime(monthAndYear.year, monthAndYear.month + 1)
        .subtract(Duration(days: 1));

    while (!dayToBuild.isAfter(lastDayOfMonth)) {
      final isInactiveDay = dayToBuild.month != monthAndYear.month;

      monthDays.add(_monthDay(
        dayToBuild,
        isInactive: isInactiveDay,
        isSelectedDay:
            selectedDate != null && _isEqualDate(selectedDate, dayToBuild),
      ));

      dayToBuild = dayToBuild.add(Duration(days: 1));
    }

    // fulfill the remaining cells for the days next month (if required)
    while (monthDays.length % DateTime.daysPerWeek != 0) {
      monthDays.add(_monthDay(
        dayToBuild,
        isInactive: true,
      ));

      dayToBuild = dayToBuild.add(Duration(days: 1));
    }

    return monthDays;
  }

  /// the first date to be displayed in the calendar widget (first cell of the month day grid)
  DateTime _initialWidgetDate(MonthAndYear inputMonth) {
    final firstDateOfMonth = inputMonth.toDateTime();

    var diff = (firstDayOfWeek - firstDateOfMonth.weekday).abs();
    if (firstDayOfWeek > firstDateOfMonth.weekday) {
      diff = DateTime.daysPerWeek - diff;
    }

    return DateTime(inputMonth.year, inputMonth.month)
        .subtract(Duration(days: diff));
  }

  Widget _monthDay(
    DateTime dateTime, {
    bool isInactive = false,
    bool isSelectedDay = false,
  }) =>
      Container(
        decoration: _dayDecoration(isSelectedDay),
        margin: const EdgeInsets.all(5),
        child: InkWell(
          onTap: () => _onDayTapped(dateTime),
          borderRadius: BorderRadius.circular(400),
          child: !isInactive
              ? Center(
                  child: Text(
                    '${dateTime.day}',
                    style: _dayStyle(isSelectedDay),
                    textAlign: TextAlign.center,
                  ),
                )
              : Center(
                  child: showInActiveMonthDays
                      ? Text(
                          '${dateTime.day}',
                          style: _inActiveDayStyle(isSelectedDay),
                          textAlign: TextAlign.center,
                        )
                      : Text(
                          ' ',
                          textAlign: TextAlign.center,
                        ),
                ),
        ),
      );

  BoxDecoration _dayDecoration(bool isSelected) =>
      isSelected && circleSelectedDay
          ? BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(400),
            )
          : null;

  TextStyle _dayStyle(bool isSelected) => isSelected
      ? monthDayLabelStyle.copyWith(fontWeight: FontWeight.w800)
      : monthDayLabelStyle;

  TextStyle _inActiveDayStyle(bool isSelected) => isSelected
      ? inactiveMonthDayLabelStyle.copyWith(fontWeight: FontWeight.w800)
      : inactiveMonthDayLabelStyle;

  void _onDayTapped(DateTime dateTime) {
    if (onDateSelected != null) {
      onDateSelected(dateTime);
    }
  }
}
