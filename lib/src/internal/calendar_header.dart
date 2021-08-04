part of nhabe;

class _CalendarHeader extends StatelessWidget {
  final MonthAndYear monthAndYear;
  final CalendarTitleBuilder titleBuilder;
  final MonthPickerMode monthPickerMode;
  final TextStyle titleStyle;
  final VoidCallback? onPrevSelected;
  final VoidCallback? onNextSelected;

  /// when a user taps on the header & jump to a specific month & year
  final MonthChangedCallBack onMonthChanged;

  const _CalendarHeader({
    required this.monthAndYear,
    required this.titleBuilder,
    required this.monthPickerMode,
    required this.titleStyle,
    required this.onPrevSelected,
    required this.onNextSelected,
    required this.onMonthChanged,
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
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      titleBuilder(monthAndYear),
                      style: titleStyle,
                    ),
                  ],
                ),
              ),
              onTap: () => _onTitleTapped(context),
            ),
            IconButton(
              icon: Icon(Icons.chevron_right),
              onPressed: onNextSelected,
            ),
          ],
        ),
      );

  void _onTitleTapped(BuildContext context) async {
    final monthPicker = MonthPickerMode.SIMPLE == monthPickerMode
        ? SimpleMonthPickerDialog(
            monthAndYear: monthAndYear,
          )
        : MonthPickerGrid(
            monthAndYear: monthAndYear,
          );

    final selectedMonthAndYear = await showDialog(
      context: context,
      builder: (_) => monthPicker,
    );

    if (selectedMonthAndYear != null) {
      onMonthChanged(selectedMonthAndYear);
    }
  }
}
