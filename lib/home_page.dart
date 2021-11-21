import 'package:flutter/material.dart';
import 'package:robot_money_collector/table_top.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double widthTable = MediaQuery.of(context).size.width;
    double heightTable = MediaQuery.of(context).size.height / 2.0;
    double dimensionx = 6;
    double dimensiony = 6;
    double robotx = 3, roboty = 1;
    int direction = 0;
    bool move;

    int totalMove = 15;

    return Scaffold(
      appBar: AppBar(
        title: Text('Robot Money Collector'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(35),
              child: Center(
                child: Text(
                  "Robot Money Collector",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: Text(
                "Total Move: 10",
                style: TextStyle(fontSize: 10),
              ),
            ),
            Container(
              height: heightTable,
              color: Colors.red,
              child: Container(
                child: CustomPaint(
                  painter: TableTop(
                    width: widthTable,
                    height: heightTable,
                    dimensionx: dimensionx,
                    dimensiony: dimensiony,
                    robotx: robotx,
                    roboty: roboty,
                    direction: direction,
                    move: false,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                color: Colors.blue,
                padding: EdgeInsets.all(85),
                child: Center(child: Text('button')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
