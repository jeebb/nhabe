import 'package:flutter/material.dart';
import 'package:nhabe/nhabe.dart';

class MonthPickerModes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MonthPickerModesState();
}

class _MonthPickerModesState extends State<MonthPickerModes> {
  @override
  Widget build(_) => Scaffold(
        appBar: AppBar(
          title: Text('Month Picker Modes'),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              NBCalendar(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Text('(Tap on current month to select a specific month)'),
              )
            ],
          ),
        ),
      );
}
