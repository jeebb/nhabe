part of nhabe;

class NBCalendar extends StatefulWidget {
  final CalendarTitleBuilder titleBuilder;
  final TextStyle titleStyle;
  final MonthAndYear initialMonthAndYear;
  final MonthChangedCallBack onMonthChanged;

  final Map<int, String> weekDayLabels;
  final TextStyle weekdayLabelStyle;

  const NBCalendar({
    this.titleBuilder,
    this.titleStyle,
    this.initialMonthAndYear,
    this.onMonthChanged,
    this.weekDayLabels = const {
      DateTime.monday: 'M',
      DateTime.tuesday: 'T',
      DateTime.wednesday: 'W',
      DateTime.thursday: 'T',
      DateTime.friday: 'F',
      DateTime.saturday: 'S',
      DateTime.sunday: 'S',
    },
    this.weekdayLabelStyle,
  }) : assert(weekDayLabels != null && weekDayLabels.length == 7,
            'There must be configured labels for all 7 days of a week');

  @override
  State<StatefulWidget> createState() => _NBCalendarState();
}

class _NBCalendarState extends State<NBCalendar> {
  /// 'month' view
  MonthAndYear selectedMonthAndYear;

  @override
  void initState() {
    super.initState();

    selectedMonthAndYear =
        widget.initialMonthAndYear ?? MonthAndYear.fromDateTime(DateTime.now());
  }

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _CalendarHeader(
              monthAndYear: selectedMonthAndYear,
              titleBuilder: widget.titleBuilder ?? defaultTitleBuilder,
              titleStyle: widget.titleStyle ?? defaultTitleStyle,
              onPrevSelected: () {},
              onNextSelected: () {},
            ),
            _WeekDays(
              weekDayLabels: widget.weekDayLabels,
              weekdayLabelStyle: widget.weekdayLabelStyle,
            ),
          ],
        ),
      );
}

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
  Widget build(BuildContext context) => Material(
        child: Container(
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
        ),
      );
}

class _WeekDays extends StatelessWidget {
  final Map<int, String> weekDayLabels;
  final TextStyle weekdayLabelStyle;

  const _WeekDays({
    @required this.weekDayLabels,
    @required this.weekdayLabelStyle,
  });

  @override
  Widget build(BuildContext context) => Material(
        child: Container(
          padding: componentPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: weekDayLabels.keys
                .map(
                  (dayIndex) => Container(
                    child: Text(
                      weekDayLabels[dayIndex],
                      style: weekdayLabelStyle ?? defaultWeekdayLabelStyle,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      );
}

/// build the calendar title based on input date time. e.g. Jan 2020
typedef String CalendarTitleBuilder(MonthAndYear monthAndYear);

/// when the current month is changed
typedef void MonthChangedCallBack(MonthAndYear monthAndYear);
