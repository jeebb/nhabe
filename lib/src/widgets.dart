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
  final int firstDayOfWeek;

  const _WeekDays({
    @required this.weekDayLabels,
    @required this.weekdayLabelStyle,
    @required this.firstDayOfWeek,
  });

  @override
  Widget build(BuildContext context) => Material(
        child: Container(
          padding: componentPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _weekDays(),
          ),
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
        ),
      );
}

/// build the calendar title based on input date time. e.g. Jan 2020
typedef String CalendarTitleBuilder(MonthAndYear monthAndYear);
