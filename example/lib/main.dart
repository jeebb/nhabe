import 'package:flutter/material.dart';
import 'package:nhabe/nhabe.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Calendar Demo'),
          ),
          body: SafeArea(
            child: Container(
              child: NBCalendar(),
            ),
          ),
        ),
      );
}
