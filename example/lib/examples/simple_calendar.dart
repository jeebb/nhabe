import 'package:flutter/material.dart';
import 'package:nhabe/nhabe.dart';

class SimpleCalendar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SimpleCalendarState();
}

class _SimpleCalendarState extends State<SimpleCalendar> {
  @override
  Widget build(_) => Scaffold(
        appBar: AppBar(
          title: Text('Simple Calendar Demo'),
        ),
        body: SafeArea(
          child: Container(
            child: NBCalendar(),
          ),
        ),
      );
}
