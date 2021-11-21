import 'package:counter_button/counter_button.dart';
import 'package:flutter/material.dart';
import 'package:robot_money_collector/constants.dart';
import 'package:robot_money_collector/table_top.dart';

class HomePage extends StatefulWidget {
  HomePage({this.dimensionx, this.dimensiony});
  final int dimensionx;
  final int dimensiony;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _robotx = 0, _roboty = 0;
  int _direction = 1;
  int _xVal = 0, _yVal = 0;
  // bool move;

  int totalMove = 15;

  @override
  Widget build(BuildContext context) {
    double widthTable = MediaQuery.of(context).size.width;
    double heightTable = MediaQuery.of(context).size.height / 2.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Robot Money Collector'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.place),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(25),
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
                "Total Move: $totalMove",
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
                    dimensionx: widget.dimensionx,
                    dimensiony: widget.dimensiony,
                    robotx: _robotx,
                    roboty: _roboty,
                    direction: _direction,
                    move: false,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _direction = west;
                        });
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 12,
                          height: MediaQuery.of(context).size.height / 12,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _direction = north;
                            });
                          },
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              // alignment: Alignment.bottomCenter,
                              // color: Colors.yellow,
                              width: MediaQuery.of(context).size.width / 12,
                              height: MediaQuery.of(context).size.height / 10,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              switch (_direction) {
                                case north:
                                  if (_roboty > 0 && _roboty <= widget.dimensiony) {
                                    _roboty -= 1;
                                    totalMove--;
                                  }
                                  break;
                                case east:
                                  if (_robotx >= 0 && _robotx < widget.dimensionx - 1) {
                                    _robotx += 1;
                                    totalMove--;
                                  }
                                  break;
                                case south:
                                  if (_roboty >= 0 && _roboty < widget.dimensiony - 1) {
                                    _roboty += 1;
                                    totalMove--;
                                  }
                                  break;
                                case west:
                                  if (_robotx > 0 && _robotx <= widget.dimensionx) {
                                    _robotx -= 1;
                                    totalMove--;
                                  }
                                  break;
                                default:
                              }
                              if (totalMove == 0) {
                                _gameOver();
                              }
                            });
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              // color: Colors.green,
                              margin: EdgeInsets.only(right: 15, left: 15),
                              width: MediaQuery.of(context).size.width / 6,
                              height: MediaQuery.of(context).size.height / 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                              child: Center(child: Text('Move')),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _direction = south;
                            });
                          },
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              // color: Colors.blue,
                              width: MediaQuery.of(context).size.width / 12,
                              height: MediaQuery.of(context).size.height / 10,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _direction = east;
                        });
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 12,
                          height: MediaQuery.of(context).size.height / 12,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _setPlace() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("PLACE"),
        content: Container(
          child: Column(
            children: [
              CounterButton(
                loading: false,
                onChange: (int val) {
                  setState(() {
                    _xVal = val;
                  });
                },
                count: _xVal,
              ),
              CounterButton(
                loading: false,
                onChange: (int val) {
                  setState(() {
                    _yVal = val;
                  });
                },
                count: _yVal,
              )
            ],
          ),
        ),
        actions: <Widget>[
          Expanded(
              child: MaterialButton(
            child: Text(
              "Set Place",
            ),
            onPressed: () {
              totalMove = 15;
              Navigator.pop(context);
            },
          ))
        ],
      ),
    );
  }

  void _gameOver() {
    totalMove = 15;
  }
}
