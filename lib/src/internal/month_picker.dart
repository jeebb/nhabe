part of nhabe;

class SimpleMonthPickerDialog extends StatefulWidget {
  final MonthAndYear monthAndYear;

  SimpleMonthPickerDialog({@required this.monthAndYear});

  @override
  State<StatefulWidget> createState() => _SimpleMonthPickerDialogState();
}

class _SimpleMonthPickerDialogState extends State<SimpleMonthPickerDialog> {
  int currentMonth;
  int currentYear;

  @override
  void initState() {
    super.initState();

    this.currentMonth = widget.monthAndYear.month;
    this.currentYear = widget.monthAndYear.year;
  }

  @override
  Widget build(BuildContext context) => SimpleDialog(
        contentPadding: const EdgeInsets.fromLTRB(24, 12, 14, 16),
        children: <Widget>[
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: DropdownButton(
                    isExpanded: true,
                    items: _months(),
                    value: currentMonth,
                    onChanged: (value) => setState(() {
                      currentMonth = value;
                    }),
                  ),
                ),
                Container(
                  width: 8,
                ),
                Expanded(
                  child: DropdownButton(
                    isExpanded: true,
                    items: _years(),
                    value: currentYear,
                    onChanged: (value) => setState(() {
                      currentYear = value;
                    }),
                  ),
                ),
              ],
            ),
          ),
          RaisedButton(
            onPressed: _onConfirmSelect,
            child: Text('Select'),
          )
        ],
      );

  List<DropdownMenuItem> _months() => [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ]
          .asMap()
          .entries
          .map((entry) => DropdownMenuItem(
                child: Text(
                  entry.value,
                  style: TextStyle(
                    fontWeight: currentMonth == entry.key + 1
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                value: entry.key + 1,
              ))
          .toList();

  List<DropdownMenuItem> _years() => <DropdownMenuItem>[
        for (var i = DateTime.now().year - 100;
            i <= DateTime.now().year + 100;
            i++)
          DropdownMenuItem(
            child: Text(
              '$i',
              style: TextStyle(
                fontWeight:
                    currentYear == i ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            value: i,
          )
      ];

  void _onConfirmSelect() {
    Navigator.pop(
      context,
      MonthAndYear(month: currentMonth, year: currentYear),
    );
  }
}
