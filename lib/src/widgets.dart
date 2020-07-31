part of nhabe;

class _CalendarHeader extends StatelessWidget {
  final MonthAndYear monthAndYear;
  final CalendarTitleBuilder titleBuilder;
  final TextStyle titleStyle;
  final VoidCallback onPrevSelected;
  final VoidCallback onNextSelected;

  const _CalendarHeader({
    @required this.monthAndYear,
    @required this.titleBuilder,
    @required this.titleStyle,
    @required this.onPrevSelected,
    @required this.onNextSelected,
  });

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.chevron_left),
              onPressed: onPrevSelected,
            ),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      titleBuilder(monthAndYear),
                      style: titleStyle,
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
              onTap: () {},
            ),
            IconButton(
              icon: Icon(Icons.chevron_right),
              onPressed: onNextSelected,
            ),
          ],
        ),
      );
}

class _WeekDays extends StatelessWidget {
  final Map<int, String> weekDayLabels;
  final TextStyle weekdayLabelStyle;
  final int firstDayOfWeek;

  const _WeekDays({
    @required this.weekDayLabels,
    @required this.weekdayLabelStyle,
    @required this.firstDayOfWeek,
  });

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: internalComponentPadding,
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 7,
          childAspectRatio: 1.5,
          children: _weekDays(),
        ),
      );

  List<Widget> _weekDays() {
    final weekdays = <Widget>[
      for (var i = firstDayOfWeek; i <= DateTime.daysPerWeek; i++)
        _weekDay(weekDayLabels[i]),
    ];

    if (firstDayOfWeek > DateTime.monday) {
      weekdays.addAll(<Widget>[
        for (var i = DateTime.monday; i < firstDayOfWeek; i++)
          _weekDay(weekDayLabels[i]),
      ]);
    }

    return weekdays;
  }

  Widget _weekDay(String label) => Container(
        child: Text(
          label,
          style: weekdayLabelStyle,
          textAlign: TextAlign.center,
        ),
      );
}

class _MonthDays extends StatelessWidget {
  final MonthAndYear monthAndYear;
  final int firstDayOfWeek;
  final DateTime selectedDate;
  final TextStyle monthDayLabelStyle;
  final bool showInactiveMonthDays;
  final TextStyle inactiveMonthDayLabelStyle;

  const _MonthDays({
    @required this.monthAndYear,
    @required this.firstDayOfWeek,
    @required this.monthDayLabelStyle,
    @required this.showInactiveMonthDays,
    @required this.inactiveMonthDayLabelStyle,
    this.selectedDate,
  })  : assert(monthAndYear != null),
        assert(firstDayOfWeek != null);

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        child: GridView.count(
          padding: internalComponentPadding,
          shrinkWrap: true,
          crossAxisCount: 7,
          children: _monthDayGridItems(),
        ),
      );

  List<Widget> _monthDayGridItems() {
    final monthDays = <Widget>[];

    bool buildingWidgets = true;
    var dayToBuild = _initialWidgetDate(monthAndYear);

    // build each row of calendar month view
    while (buildingWidgets) {
      for (var i = 1; i <= DateTime.daysPerWeek; i++) {
        final isInactiveDay = dayToBuild.month != monthAndYear.month;
        monthDays.add(_monthDay(dayToBuild, isInactive: isInactiveDay));

        dayToBuild = dayToBuild.add(Duration(days: 1));
      }

      // continue to build if still in the same month or the last row is not ful-filled 100%
      buildingWidgets = dayToBuild.month <= monthAndYear.month ||
          monthDays.length % DateTime.daysPerWeek != 0;
    }

    return monthDays;
  }

  /// the first date to be displayed in the calendar widget (first cell of the month day grid)
  DateTime _initialWidgetDate(MonthAndYear inputMonth) {
    final diff = (firstDayOfWeek - inputMonth.toDateTime().weekday).abs();
    return DateTime(inputMonth.year, inputMonth.month)
        .subtract(Duration(days: diff));
  }

  Widget _monthDay(
    DateTime dateTime, {
    bool isInactive = false,
    bool isSelectedDay = false,
  }) =>
      !isInactive
          ? Container(
              child: Text(
                '${dateTime.day}',
                style: monthDayLabelStyle,
                textAlign: TextAlign.center,
              ),
            )
          : Container(
              child: showInactiveMonthDays
                  ? Text(
                      '${dateTime.day}',
                      style: inactiveMonthDayLabelStyle,
                      textAlign: TextAlign.center,
                    )
                  : Text(' ', textAlign: TextAlign.center),
            );
}

/// build the calendar title based on input date time. e.g. Jan 2020
typedef String CalendarTitleBuilder(MonthAndYear monthAndYear);
