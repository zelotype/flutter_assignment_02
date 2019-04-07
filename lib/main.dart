import 'package:flutter/material.dart';
import 'package:flutter_assignment_02/UI/NewSubject.dart';
import 'UI/M_Page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => main_page(),
        "/newsubject": (context) => NewSubject()
      },
    );
  }
}