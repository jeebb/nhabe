import 'package:example/examples/SimpleCalendar.dart';
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
                RaisedButton(
                  child: Text('Simple Usage'),
                  onPressed: () => _navigate(SimpleCalendar()),
                ),
                RaisedButton(
                  child: Text('Custom Title & Weekdays'),
                  onPressed: () {},
                ),
                RaisedButton(
                  child: Text('Month & Day Change Event'),
                  onPressed: () {},
                ),
                RaisedButton(
                  child: Text('Custom First Day of Week'),
                  onPressed: () {},
                ),
                RaisedButton(
                  child: Text('Custom Calendar Header'),
                  onPressed: () {},
                ),
                RaisedButton(
                  child: Text('With Event Indicators'),
                  onPressed: () {},
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
