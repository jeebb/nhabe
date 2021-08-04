import 'package:flutter/material.dart';
import 'package:nhabe/nhabe.dart';

class EventIndicator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EventIndicatorState();
}

class _EventIndicatorState extends State<EventIndicator> {
  @override
  Widget build(_) => Scaffold(
        appBar: AppBar(
          title: Text('Event Indicators'),
        ),
        body: SafeArea(
          child: Container(
            child: NBCalendar(
              dayEventIndicator: _indicatorData(),
            ),
          ),
        ),
      );

  Map<Date, int> _indicatorData() {
    final now = DateTime.now();

    Map<Date, int> indicators = {
      Date(year: now.year, month: now.month, day: 12): 1,
      Date(year: now.year, month: now.month, day: 17): 1,
      Date(year: now.year, month: now.month, day: 13): 1,
      Date(year: now.year, month: now.month, day: 19): 1,
      Date(year: now.year, month: now.month, day: 23): 1,
    };

    return indicators;
  }
}
