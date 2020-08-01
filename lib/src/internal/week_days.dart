part of nhabe;

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
          physics: NeverScrollableScrollPhysics(),
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

  Widget _weekDay(String label) => Center(
        child: Container(
          child: Text(
            label,
            style: weekdayLabelStyle,
            textAlign: TextAlign.center,
          ),
        ),
      );
}
