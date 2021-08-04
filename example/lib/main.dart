import 'package:example/examples/custom_calendar_header.dart';
import 'package:example/examples/custom_first_day_of_week.dart';
import 'package:example/examples/custom_title_and_weekdays.dart';
import 'package:example/examples/event_indicator.dart';
import 'package:example/examples/month_and_day_change_event.dart';
import 'package:example/examples/month_picker_modes.dart';
import 'package:example/examples/simple_calendar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(_) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ExampleHome(),
      );
}

class ExampleHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExampleHomeState();
}

class _ExampleHomeState extends State<ExampleHome> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('NBCalendar Usage Demos'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: <Widget>[
                ElevatedButton(
                  child: Text('Simple Usage'),
                  onPressed: () => _navigate(SimpleCalendar()),
                ),
                ElevatedButton(
                  child: Text('Custom Title & Weekdays'),
                  onPressed: () => _navigate(CustomTitleAndWeekDays()),
                ),
                ElevatedButton(
                  child: Text('Month & Day Change Event'),
                  onPressed: () => _navigate(MonthAndDayChangeEvent()),
                ),
                ElevatedButton(
                  child: Text('Custom First Day of Week'),
                  onPressed: () => _navigate(CustomFirstDayOfWeek()),
                ),
                ElevatedButton(
                  child: Text('Custom Calendar Header'),
                  onPressed: () => _navigate(CustomCalendarHeader()),
                ),
                ElevatedButton(
                  child: Text('With Event Indicators'),
                  onPressed: () => _navigate(EventIndicator()),
                ),
                ElevatedButton(
                  child: Text('Month Picker Modes'),
                  onPressed: () => _navigate(MonthPickerModes()),
                ),
              ],
            ),
          ),
        ),
      );

  _navigate(Widget target) => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => target),
      );
}
