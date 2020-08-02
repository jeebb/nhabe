import 'package:flutter/material.dart';
import 'package:month_picker_strip/month_picker_strip.dart';
import 'package:nhabe/nhabe.dart';

class CustomCalendarHeader extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CustomCalendarHeaderState();
}

class _CustomCalendarHeaderState extends State<CustomCalendarHeader> {
  MonthAndYear selectedMonthAndYear = MonthAndYear.fromDateTime(DateTime.now());

  @override
  Widget build(_) => Scaffold(
        appBar: AppBar(
          title: Text('Custom Calendar Header'),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              MonthStrip(
                format: 'MMM yyyy',
                from: DateTime.now().subtract(Duration(days: 365 * 2)),
                to: DateTime.now().add(Duration(days: 365 * 2)),
                initialMonth: selectedMonthAndYear.toDateTime(),
                height: 48.0,
                viewportFraction: 0.25,
                onMonthChanged: (dateTime) {
                  setState(() {
                    selectedMonthAndYear = MonthAndYear.fromDateTime(dateTime);
                  });
                },
              ),
              NBCalendar(
                showHeader: false,
                selectedMonthAndYear: selectedMonthAndYear,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text.rich(
                  TextSpan(
                    children: <InlineSpan>[
                      TextSpan(text: '(Hide default header & integate with '),
                      TextSpan(
                        text: 'https://pub.dev/packages/month_picker_strip',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(text: '). Select a month to see the changes.'),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      );
}
