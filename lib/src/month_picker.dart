part of nhabe;

enum MonthPickerMode { GRID, SIMPLE }

final _monthLabels = <String>[
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
  'Dec',
];

class SimpleMonthPickerDialog extends StatefulWidget {
  final MonthAndYear monthAndYear;

  SimpleMonthPickerDialog({required this.monthAndYear});

  @override
  State<StatefulWidget> createState() => _SimpleMonthPickerDialogState();
}

class _SimpleMonthPickerDialogState extends State<SimpleMonthPickerDialog> {
  int? currentMonth;
  int? currentYear;

  @override
  void initState() {
    super.initState();

    this.currentMonth = widget.monthAndYear.month;
    this.currentYear = widget.monthAndYear.year;
  }

  @override
  Widget build(BuildContext context) => SimpleDialog(
        contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
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
                    onChanged: (dynamic value) => setState(() {
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
                    onChanged: (dynamic value) => setState(() {
                      currentYear = value;
                    }),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _onConfirmSelect,
            child: Text('Select'),
          )
        ],
      );

  List<DropdownMenuItem> _months() => _monthLabels
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
      MonthAndYear(month: currentMonth!, year: currentYear!),
    );
  }
}

class MonthPickerGrid extends StatefulWidget {
  final MonthAndYear monthAndYear;

  MonthPickerGrid({required this.monthAndYear});

  @override
  State<StatefulWidget> createState() => _MonthPickerGridState();
}

class _MonthPickerGridState extends State<MonthPickerGrid> {
  late int currentMonth;
  late int currentYear;

  @override
  void initState() {
    super.initState();

    currentMonth = widget.monthAndYear.month;
    currentYear = widget.monthAndYear.year;
  }

  @override
  Widget build(_) => SimpleDialog(
        contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.chevron_left),
                onPressed: () => setState(() {
                  currentYear -= 1;
                }),
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        '$currentYear',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                onTap: () => () {},
              ),
              IconButton(
                icon: Icon(Icons.chevron_right),
                onPressed: () => setState(() {
                  currentYear += 1;
                }),
              ),
            ],
          ),
          Container(
            width: double.maxFinite,
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              childAspectRatio: 1.7,
              primary: true,
              shrinkWrap: true,
              children: _monthLabels
                  .asMap()
                  .entries
                  .map((entry) => _month(entry.key + 1, entry.value))
                  .toList(),
            ),
          ),
        ],
      );

  Widget _month(int month, String label) => InkWell(
        onTap: () => _onSelectMonth(month),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight:
                  month == currentMonth ? FontWeight.w700 : FontWeight.normal,
            ),
          ),
        ),
      );

  void _onSelectMonth(int month) {
    Navigator.pop(
      context,
      MonthAndYear(month: month, year: currentYear),
    );
  }
}
