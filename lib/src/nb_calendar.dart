part of nhabe;

class NBCalendar extends StatefulWidget {
  final CalendarTitleBuilder titleBuilder;

  /// current month as default
  final MonthAndYear selectedMonthAndYear;
  final DateTime selectedDate;

  final MonthChangedCallBack onMonthChanged;
  final OnDateSelected onDateSelected;

  final Map<int, String> weekDayLabels;

  final bool showInActiveMonthDays;

  /// DateTime.monday / DateTime.tuesday / ... / DateTime.sunday
  final int firstDayOfWeek;

  const NBCalendar({
    this.titleBuilder,
    this.selectedMonthAndYear,
    this.selectedDate,
    this.onMonthChanged,
    this.onDateSelected,
    this.weekDayLabels = const {
      DateTime.monday: 'M',
      DateTime.tuesday: 'T',
      DateTime.wednesday: 'W',
      DateTime.thursday: 'T',
      DateTime.friday: 'F',
      DateTime.saturday: 'S',
      DateTime.sunday: 'S',
    },
    this.firstDayOfWeek = DateTime.monday,
    this.showInActiveMonthDays = true,
  }) : assert(weekDayLabels != null && weekDayLabels.length == 7,
            'There must be configured labels for all 7 days of a week');

  @override
  State<StatefulWidget> createState() => _NBCalendarState();
}

class _NBCalendarState extends State<NBCalendar> {
  /// 'month' view
  MonthAndYear selectedMonthAndYear;
  DateTime selectedDate;

  bool changingMonth = false;

  @override
  void initState() {
    super.initState();

    selectedMonthAndYear = widget.selectedMonthAndYear ??
        MonthAndYear.fromDateTime(DateTime.now());

    selectedDate = widget.selectedDate ?? DateTime.now();
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
              titleStyle: defaultTitleStyle,
              onPrevSelected: !changingMonth ? _onPrev : null,
              onNextSelected: !changingMonth ? _onNext : null,
            ),
            _WeekDays(
              weekDayLabels: widget.weekDayLabels,
              weekdayLabelStyle: defaultWeekdayLabelStyle,
              firstDayOfWeek: widget.firstDayOfWeek,
            ),
            _MonthDays(
              monthAndYear: selectedMonthAndYear,
              firstDayOfWeek: widget.firstDayOfWeek,
              showInActiveMonthDays: widget.showInActiveMonthDays,
              monthDayLabelStyle: defaultMonthdayLabelStyle,
              inactiveMonthDayLabelStyle: defaultInactiveMonthDayLabelStyle,
              selectedDate: selectedDate,
              onDateSelected: _onDateSelected,
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

  void _onDateSelected(DateTime dateTime) {
    setState(() {
      selectedDate = dateTime;
    });

    if (widget.onDateSelected != null) {
      widget.onDateSelected(dateTime);
    }
  }
}

/// when the current month is changed
typedef void MonthChangedCallBack(MonthAndYear monthAndYear);

typedef void OnDateSelected(DateTime dateTime);
