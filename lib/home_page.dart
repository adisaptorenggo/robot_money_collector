import 'dart:math';

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
  int _robotx = 0, _roboty = 0;
  int _direction = 1;
  int _xVal = 0, _yVal = 0;
  int _totalMoney = 4;
  List<int> _xMoney = [];
  List<int> _yMoney = [];
  var _posMoney;

  List<String> _movementHistories = [];
  double _totalMoneyAvailable;
  double _totalMoneyFound;
  double _totalMoneyEarn = 0;
  int _interestRate;

  int _totalMove = 15;

  @override
  void initState() {
    _generateMoney();
    _generateInterest();
    super.initState();
  }

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
            onPressed: () {
              _setPlace();
            },
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
                "Total Move: $_totalMove",
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
                    robotx: _robotx.toDouble(),
                    roboty: _roboty.toDouble(),
                    direction: _direction,
                    xMoney: _xMoney,
                    yMoney: _yMoney,
                    posMoney: _posMoney,
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
                                    _totalMove--;
                                    _movementHistories.add('Array[$_robotx][$_robotx]');
                                    if (_posMoney[_robotx][_roboty] != null) {
                                      _posMoney[_robotx][_roboty] = null;
                                      _totalMoney--;
                                    }
                                  }
                                  break;
                                case east:
                                  if (_robotx >= 0 && _robotx < widget.dimensionx - 1) {
                                    _robotx += 1;
                                    _totalMove--;
                                    _movementHistories.add('Array[$_robotx][$_robotx]');
                                    if (_posMoney[_robotx][_roboty] != null) {
                                      _posMoney[_robotx][_roboty] = null;
                                      _totalMoney--;
                                    }
                                  }
                                  break;
                                case south:
                                  if (_roboty >= 0 && _roboty < widget.dimensiony - 1) {
                                    _roboty += 1;
                                    _totalMove--;
                                    _movementHistories.add('Array[$_robotx][$_robotx]');
                                    if (_posMoney[_robotx][_roboty] != null) {
                                      _posMoney[_robotx][_roboty] = null;
                                      _totalMoney--;
                                    }
                                  }
                                  break;
                                case west:
                                  if (_robotx > 0 && _robotx <= widget.dimensionx) {
                                    _robotx -= 1;
                                    _totalMove--;
                                    _movementHistories.add('Array[$_robotx][$_robotx]');
                                    if (_posMoney[_robotx][_roboty] != null) {
                                      _posMoney[_robotx][_roboty] = null;
                                      _totalMoney--;
                                    }
                                  }
                                  break;
                                default:
                              }
                              if (_totalMove == 0 || _totalMoney == 0) {
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

  void _generateMoney() {
    _xMoney = List.generate(widget.dimensionx, (int index) => index);
    _xMoney.shuffle();
    for (int i = 0; i < widget.dimensionx - _totalMoney; i++) {
      _xMoney.removeLast();
    }
    _yMoney = List.generate(widget.dimensiony, (int index) => index);
    _yMoney.shuffle();
    for (int i = 0; i < widget.dimensiony - _totalMoney; i++) {
      _yMoney.removeLast();
    }
    _posMoney = List.generate(widget.dimensionx, (_) => List(widget.dimensiony));
    var _random = Random();
    var _numbers;
    _totalMoneyAvailable = 0;
    for (var i = 0; i < _totalMoney; i++) {
      _numbers = _random.nextInt(20000 - 500) + 500;
      _posMoney[_xMoney[i]][_yMoney[i]] = _numbers;
      _totalMoneyAvailable += _numbers;
    }
    _totalMoneyFound = 0;
  }

  void _generateInterest() {
    var _numbers = Random();
    _interestRate = _numbers.nextInt(20) + 5;
  }

  void _setPlace() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("PLACE"),
        content: Container(
          height: MediaQuery.of(context).size.height / 4,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "X:     ",
                    style: TextStyle(fontSize: 20),
                  ),
                  CounterButton(
                    loading: false,
                    onChange: (int val) {
                      setState(() {
                        _xVal = val;
                      });
                    },
                    count: _xVal,
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Y:     ",
                      style: TextStyle(fontSize: 20),
                    ),
                    CounterButton(
                      loading: false,
                      onChange: (int val) {
                        setState(() {
                          _yVal = val;
                        });
                      },
                      count: _yVal,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Direction: ",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          MaterialButton(
            child: Text(
              "Set Place",
            ),
            onPressed: () {
              setState(() {
                _totalMove = 15;
                _totalMoney = 4;
                _robotx = 0;
                _roboty = 0;
                _direction = east;
                _generateMoney();
                _generateInterest();
                Navigator.pop(context);
              });
            },
          )
        ],
      ),
    );
  }

  void _gameOver() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Game Over"),
        content: Container(
          height: MediaQuery.of(context).size.height / 2,
        ),
        actions: <Widget>[
          MaterialButton(
            child: Text(
              "Restart",
            ),
            onPressed: () {
              setState(() {
                _totalMove = 15;
                _totalMoney = 4;
                _robotx = 0;
                _roboty = 0;
                _direction = east;
                _generateMoney();
                _generateInterest();
                Navigator.pop(context);
              });
            },
          )
        ],
      ),
    );
  }
}
