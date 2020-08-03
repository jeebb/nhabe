part of nhabe;

class NBCalendar extends StatefulWidget {
  /// custom builder for the header title. e.g. changing the date format
  /// default: yMMM format
  final CalendarTitleBuilder titleBuilder;

  /// whether to show the calendar header
  /// default: true
  final bool showHeader;

  /// label for the weekdays
  /// default: M, T, W, T, F, S, S
  final Map<int, String> weekDayLabels;

  /// specify the first day of week: DateTime.monday / DateTime.tuesday / ... / DateTime.sunday
  /// default: DateTime.sunday
  final int firstDayOfWeek;

  /// switch between two different UIs for month picker (simple view & grid view)
  /// default: grid view
  final MonthPickerMode monthPickerMode;

  /// current month & year
  /// default: current month
  final MonthAndYear selectedMonthAndYear;

  /// selected date
  /// default: today
  final DateTime selectedDate;

  /// draw a circle around the selected day
  /// default: true
  final bool circleSelectedDay;

  /// show the days from previous / next month
  /// default: true
  final bool showInActiveMonthDays;

  /// map of: <day_of_current_month , num_of_related_items>
  final Map<Date, int> dayEventIndicator;

  /// color of the event indicator.
  /// default: primary theme color
  final Color eventIndicatorColor;

  /// callback for month-changed event
  final MonthChangedCallBack onMonthChanged;

  /// callback for date-selected event
  final OnDateSelected onDateSelected;

  /// swipe left / right to change the month
  /// default: true
  final bool swipeToNavigate;

  const NBCalendar({
    this.titleBuilder,
    this.showHeader = true,
    this.monthPickerMode = MonthPickerMode.GRID,
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
  MonthAndYear _selectedMonthAndYear;
  DateTime _selectedDate;

  bool _changingMonth = false;

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
                monthPickerMode: widget.monthPickerMode,
                titleStyle: defaultTitleStyle,
                onPrevSelected: !_changingMonth ? _onPrev : null,
                onNextSelected: !_changingMonth ? _onNext : null,
                onMonthChanged: (monthAndYear) {
                  if (!selectedMonthAndYear.equals(monthAndYear)) {
                    setState(() {
                      _selectedMonthAndYear = monthAndYear;
                    });

                    if (widget.onMonthChanged != null) {
                      widget.onMonthChanged(monthAndYear);
                    }
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

  MonthAndYear get selectedMonthAndYear =>
      _selectedMonthAndYear ??
      (widget.selectedMonthAndYear ??
          MonthAndYear.fromDateTime(DateTime.now()));

  DateTime get selectedDate =>
      _selectedDate ?? (widget.selectedDate ?? DateTime.now());

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
      _changingMonth = true;
    });

    final prevMonth = MonthAndYear.fromDateTime(
        DateTime(selectedMonthAndYear.year, selectedMonthAndYear.month, -1));

    setState(() {
      _selectedMonthAndYear = prevMonth;
      _changingMonth = false;
    });

    if (widget.onMonthChanged != null) {
      widget.onMonthChanged(prevMonth);
    }
  }

  void _onNext() {
    setState(() {
      _changingMonth = true;
    });

    final nextMonth = MonthAndYear.fromDateTime(DateTime(
      selectedMonthAndYear.year,
      selectedMonthAndYear.month + 1,
    ));

    setState(() {
      _selectedMonthAndYear = nextMonth;
      _changingMonth = false;
    });

    if (widget.onMonthChanged != null) {
      widget.onMonthChanged(nextMonth);
    }
  }

  void _onDateSelected(DateTime dateTime) {
    // don't fire the event multiple time on same date
    if (!_isEqualDate(dateTime, _selectedDate)) {
      setState(() {
        _selectedDate = dateTime;
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
