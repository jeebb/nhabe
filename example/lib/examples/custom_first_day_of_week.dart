import 'package:flutter/material.dart';
import 'package:nhabe/nhabe.dart';

class CustomFirstDayOfWeek extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CustomFirstDayOfWeekState();
}

class _CustomFirstDayOfWeekState extends State<CustomFirstDayOfWeek> {
  static final weekDays = <int, String>{
    1: 'Monday',
    2: 'Tueday',
    3: 'Wednesday',
    4: 'Thursday',
    5: 'Friday',
    6: 'Saturday',
    7: 'Sunday',
  };

  int firstDayOfWeek = DateTime.sunday;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Custom First Day of Week'),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              NBCalendar(
                firstDayOfWeek: firstDayOfWeek,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Select first day of week'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  items: weekDays.keys
                      .map(
                        (dayKey) => DropdownMenuItem(
                          child: Text(weekDays[dayKey]),
                          value: dayKey,
                        ),
                      )
                      .toList(),
                  onChanged: (value) => setState(() {
                    firstDayOfWeek = value;
                  }),
                  value: firstDayOfWeek,
                ),
              ),
            ],
          ),
        ),
      );
}
