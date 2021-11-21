import 'package:flutter/material.dart';
import 'package:robot_money_collector/dimension_picker.dart';
import 'package:robot_money_collector/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Robbot Money Collector',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DimensionPicker(),
    );
  }
}
