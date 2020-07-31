part of nhabe;

class NBCalendar extends StatefulWidget {
  final CalendarTitleBuilder titleBuilder;
  final TextStyle titleStyle;

  /// current month as default
  final MonthAndYear selectedMonthAndYear;

  final MonthChangedCallBack onMonthChanged;

  final Map<int, String> weekDayLabels;
  final TextStyle weekdayLabelStyle;

  final TextStyle monthDayLabelStyle;
  final TextStyle inactiveMonthDayLabelStyle;
  final bool showInActiveMonthDays;

  /// DateTime.monday / DateTime.tuesday / ... / DateTime.sunday
  final int firstDayOfWeek;

  const NBCalendar({
    this.titleBuilder,
    this.titleStyle,
    this.selectedMonthAndYear,
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
    this.firstDayOfWeek = DateTime.monday,
    this.monthDayLabelStyle,
    this.inactiveMonthDayLabelStyle,
    this.showInActiveMonthDays = true,
  }) : assert(weekDayLabels != null && weekDayLabels.length == 7,
            'There must be configured labels for all 7 days of a week');

  @override
  State<StatefulWidget> createState() => _NBCalendarState();
}

class _NBCalendarState extends State<NBCalendar> {
  /// 'month' view
  MonthAndYear selectedMonthAndYear;
  DateTime selectedDate = DateTime.now();

  bool changingMonth = false;

  @override
  void initState() {
    super.initState();

    selectedMonthAndYear = widget.selectedMonthAndYear ??
        MonthAndYear.fromDateTime(DateTime.now());
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
              onPrevSelected: !changingMonth ? _onPrev : null,
              onNextSelected: !changingMonth ? _onNext : null,
            ),
            _WeekDays(
              weekDayLabels: widget.weekDayLabels,
              weekdayLabelStyle:
                  widget.weekdayLabelStyle ?? defaultWeekdayLabelStyle,
              firstDayOfWeek: widget.firstDayOfWeek,
            ),
            _MonthDays(
              monthAndYear: selectedMonthAndYear,
              firstDayOfWeek: widget.firstDayOfWeek,
              showInActiveMonthDays: widget.showInActiveMonthDays,
              monthDayLabelStyle:
                  widget.monthDayLabelStyle ?? defaultMonthdayLabelStyle,
              inactiveMonthDayLabelStyle: widget.inactiveMonthDayLabelStyle ??
                  defaultInactiveMonthDayLabelStyle,
              selectedDate: selectedDate,
            ),
          ],
        ),
      );

  void _onPrev() {
    setState(() {
      changingMonth = true;
    });

    final prevMonth = MonthAndYear.fromDateTime(
        DateTime(selectedMonthAndYear.year, selectedMonthAndYear.month, -1));

    setState(() {
      selectedMonthAndYear = prevMonth;
      changingMonth = false;
    });

    if (widget.onMonthChanged != null) {
      widget.onMonthChanged(prevMonth);
    }
  }

  void _onNext() {
    setState(() {
      changingMonth = true;
    });

    final nextMonth = MonthAndYear.fromDateTime(DateTime(
      selectedMonthAndYear.year,
      selectedMonthAndYear.month + 1,
    ));

    setState(() {
      selectedMonthAndYear = nextMonth;
      changingMonth = false;
    });

    if (widget.onMonthChanged != null) {
      widget.onMonthChanged(nextMonth);
    }
  }
}

/// when the current month is changed
typedef void MonthChangedCallBack(MonthAndYear monthAndYear);
