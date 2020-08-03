## Introduction

An elegant calendar widget for your Flutter app named after a river in Vietnam (_**Nha Be river**_).

## Features
- Navigation between the months (buttons & gesture)
- Event indicator for specific days of a month
- Specific UI customizations (weekday labels, first day of week, month picker, 3rd-party header ...)
- Wanna have a feature? Just open a ticket [here](https://github.com/jeebb/nhabe/issues)

## Getting Started
1\. Declare the dependency in **pubspec.yaml**:

```dart
dependencies: 
    nhabe: <version>
```

2\. Import the package:
```dart
import 'package:nhabe/nhabe.dart';
```

3\. Add the component to your screen by creating a new **NBCalendar** widget:
```dart
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

```
Example screenshots:

![Example Image](https://github.com/jeebb/nhabe/raw/master/example/screenshots/simple_use_case.png)

4\. More examples could be found at: [https://github.com/jeebb/nhabe/tree/master/example](https://github.com/jeebb/nhabe/tree/master/example)

![Example App](https://github.com/jeebb/nhabe/raw/master/example/screenshots/example_app.png)

## Widget Properties
| Property | Type | Description | Default Value |
| --- | --- | --- | ---|
| titleBuilder | CalendarTitleBuilder | custom builder for the header title. e.g. changing the date format | https://github.com/jeebb/nhabe/blob/c465645cb2c8070c0402bb77b5ccf67ebe985a84/lib/src/nb_calendar.dart#L231 |
| showHeader | bool | whether to show the calendar header | true |
| weekDayLabels | Map<int, String> | label for the weekdays | M, T, W, T, F, S, S|
| firstDayOfWeek | int | specify the first day of week: DateTime.monday / DateTime.tuesday / ... / DateTime.sunday | DateTime.sunday |
| monthPickerMode | MonthPickerMode | switch between two different UIs for month picker (simple view & grid view) | grid view |
| selectedMonthAndYear | MonthAndYear | selected month & year | current month |
| selectedDate | DateTime | selected date | today |
| circleSelectedDay | bool | draw a circle around the selected day | true |
| showInActiveMonthDays | bool | show the days from previous / next month | true |
| dayEventIndicator | Map<Date, int> | indicate which day contains the event | https://github.com/jeebb/nhabe/blob/c465645cb2c8070c0402bb77b5ccf67ebe985a84/lib/src/nb_calendar.dart#L67 |
| eventIndicatorColor | Color | color of the event indicator | primary theme color |
| onMonthChanged | MonthChangedCallBack | callback for month-changed event | |
| onDateSelected | OnDateSelected | callback for date-selected event | |
| swipeToNavigate | bool | wipe left / right to change the month | true |

