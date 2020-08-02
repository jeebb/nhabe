import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nhabe/nhabe.dart';

class MonthAndDayChangeEvent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MonthAndDayChangeEventState();
}

class _MonthAndDayChangeEventState extends State<MonthAndDayChangeEvent> {
  String message;

  @override
  Widget build(_) => Scaffold(
        appBar: AppBar(
          title: Text('Month & Day Change Event'),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              NBCalendar(
                onMonthChanged: (monthAndYear) => setState(() {
                  message =
                      'Selected month: ${monthAndYear.month} / ${monthAndYear.year}';
                }),
                onDateSelected: (dateTime) => setState(() {
                  message =
                      'Selected date: ${DateFormat.yMMMEd().format(dateTime)}';
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(message ?? '(Change the month or select a day)'),
              ),
            ],
          ),
        ),
      );
}
