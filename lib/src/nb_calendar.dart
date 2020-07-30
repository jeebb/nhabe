part of nhabe;

class NBCalendar extends StatefulWidget {
  final CalendarTitleBuilder titleBuilder;
  final TextStyle titleStyle;
  final MonthAndYear initialMonthAndYear;
  final MonthChangedCallBack onMonthChanged;

  const NBCalendar({
    this.titleBuilder,
    this.titleStyle,
    this.initialMonthAndYear,
    this.onMonthChanged,
  });

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
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        titleBuilder(monthAndYear),
                        style: titleStyle,
                      ),
                      const SizedBox(width: 8.0),
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

/// build the calendar title based on input date time. e.g. Jan 2020
typedef String CalendarTitleBuilder(MonthAndYear monthAndYear);

/// when the current month is changed
typedef void MonthChangedCallBack(MonthAndYear monthAndYear);
