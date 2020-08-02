part of nhabe;

class NBCalendar extends StatefulWidget {
  final CalendarTitleBuilder titleBuilder;
  final bool showHeader;

  /// current month as default
  final MonthAndYear selectedMonthAndYear;
  final DateTime selectedDate;

  /// map of: <day_of_current_month , num_of_related_items>
  final Map<Date, int> dayEventIndicator;
  final Color eventIndicatorColor;

  final MonthChangedCallBack onMonthChanged;
  final OnDateSelected onDateSelected;

  final Map<int, String> weekDayLabels;

  final bool showInActiveMonthDays;

  final bool circleSelectedDay;

  /// DateTime.monday / DateTime.tuesday / ... / DateTime.sunday
  final int firstDayOfWeek;

  final bool swipeToNavigate;

  const NBCalendar({
    this.titleBuilder,
    this.showHeader = true,
    this.selectedMonthAndYear,
    this.selectedDate,
    this.dayEventIndicator = const {},
    this.eventIndicatorColor,
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
    this.firstDayOfWeek = DateTime.sunday,
    this.showInActiveMonthDays = true,
    this.circleSelectedDay = true,
    this.swipeToNavigate = true,
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
  Widget build(BuildContext context) => widget.swipeToNavigate
      ? Dismissible(
          key: UniqueKey(),
          confirmDismiss: _onHorizonSwipe,
          movementDuration: Duration.zero,
          resizeDuration: Duration.zero,
          child: _calendar(),
        )
      : _calendar();

  Widget _calendar() => Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Visibility(
              visible: widget.showHeader,
              replacement: Container(),
              child: _CalendarHeader(
                monthAndYear: selectedMonthAndYear,
                titleBuilder: widget.titleBuilder ?? defaultTitleBuilder,
                titleStyle: defaultTitleStyle,
                onPrevSelected: !changingMonth ? _onPrev : null,
                onNextSelected: !changingMonth ? _onNext : null,
                onMonthChanged: (monthAndYear) {
                  if (!selectedMonthAndYear.equals(monthAndYear)) {
                    setState(() {
                      selectedMonthAndYear = monthAndYear;
                    });
                  }
                },
              ),
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
              circleSelectedDay: widget.circleSelectedDay,
              dayEventIndicator: widget.dayEventIndicator,
            ),
          ],
        ),
      );

  Future<bool> _onHorizonSwipe(DismissDirection direction) async {
    if (direction == DismissDirection.startToEnd) {
      _onPrev();
    } else {
      _onNext();
    }

    return true;
  }

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
    // don't fire the event multiple time on same date
    if (!_isEqualDate(dateTime, selectedDate)) {
      setState(() {
        selectedDate = dateTime;
      });

      if (widget.onDateSelected != null) {
        widget.onDateSelected(dateTime);
      }
    }
  }
}

/// build the calendar title based on input date time. e.g. Jan 2020
typedef String CalendarTitleBuilder(MonthAndYear monthAndYear);

/// when the current month is changed
typedef void MonthChangedCallBack(MonthAndYear monthAndYear);

typedef void OnDateSelected(DateTime dateTime);

final defaultTitleBuilder = (MonthAndYear selectedMonth) =>
    DateFormat.yMMM().format(selectedMonth.toDateTime());
