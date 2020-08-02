import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nhabe/nhabe.dart';

class CustomTitleAndWeekDays extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CustomTitleAndWeekDaysState();
}

class _CustomTitleAndWeekDaysState extends State<CustomTitleAndWeekDays> {
  @override
  Widget build(_) => Scaffold(
        appBar: AppBar(
          title: Text('Custom Title & Weekdays'),
        ),
        body: SafeArea(
          child: Container(
            child: NBCalendar(
              titleBuilder: (monthAndYear) =>
                  DateFormat.yM().format(monthAndYear.toDateTime()),
              weekDayLabels: {
                DateTime.monday: 'Mon',
                DateTime.tuesday: 'Tue',
                DateTime.wednesday: 'Wed',
                DateTime.thursday: 'Thu',
                DateTime.friday: 'Fri',
                DateTime.saturday: 'Sat',
                DateTime.sunday: 'Sun',
              },
            ),
          ),
        ),
      );
}
