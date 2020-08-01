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
