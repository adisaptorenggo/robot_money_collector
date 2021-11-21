import 'dart:math';

import 'package:counter_button/counter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robot_money_collector/bloc/send_to_server_bloc.dart';
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
  String dropdownValue = 'East';

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

    return BlocListener<SendToServerBloc, SendToServerState>(
      listener: (context, state) {
        if (state is SendToServerLoading) {
          _loadingDialog(context);
        } else if (state is SendToServerError) {
          Navigator.pop(context);
        } else if (state is SendToServerSuccess) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
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
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blueGrey),
                            child: Icon(Icons.keyboard_arrow_left),
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
                                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blueGrey),
                                child: Icon(Icons.keyboard_arrow_up),
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
                                      _totalMoneyEarn = _totalMoneyEarn + _totalMoneyEarn * (_interestRate / 100);
                                      _movementHistories.add('Array[$_robotx][$_robotx]');
                                      if (_posMoney[_robotx][_roboty] != null) {
                                        _totalMoneyAvailable -= _posMoney[_robotx][_roboty];
                                        _totalMoneyFound += _posMoney[_robotx][_roboty];
                                        _totalMoneyEarn += _posMoney[_robotx][_roboty];
                                        // print('$_totalMoneyAvailable');
                                        _posMoney[_robotx][_roboty] = null;
                                        _totalMoney--;
                                      }
                                      print('$_totalMoneyEarn');
                                    }
                                    break;
                                  case east:
                                    if (_robotx >= 0 && _robotx < widget.dimensionx - 1) {
                                      _robotx += 1;
                                      _totalMove--;
                                      _movementHistories.add('Array[$_robotx][$_robotx]');
                                      _totalMoneyEarn = _totalMoneyEarn + _totalMoneyEarn * (_interestRate / 100);
                                      if (_posMoney[_robotx][_roboty] != null) {
                                        _totalMoneyAvailable -= _posMoney[_robotx][_roboty];
                                        _totalMoneyFound += _posMoney[_robotx][_roboty];
                                        _totalMoneyEarn += _posMoney[_robotx][_roboty];
                                        // print('$_totalMoneyAvailable');
                                        _posMoney[_robotx][_roboty] = null;
                                        _totalMoney--;
                                      }
                                      print('$_totalMoneyEarn');
                                    }
                                    break;
                                  case south:
                                    if (_roboty >= 0 && _roboty < widget.dimensiony - 1) {
                                      _roboty += 1;
                                      _totalMove--;
                                      _movementHistories.add('Array[$_robotx][$_robotx]');
                                      _totalMoneyEarn = _totalMoneyEarn + _totalMoneyEarn * (_interestRate / 100);
                                      if (_posMoney[_robotx][_roboty] != null) {
                                        _totalMoneyAvailable -= _posMoney[_robotx][_roboty];
                                        _totalMoneyFound += _posMoney[_robotx][_roboty];
                                        _totalMoneyEarn += _posMoney[_robotx][_roboty];
                                        // print('$_totalMoneyAvailable');
                                        _posMoney[_robotx][_roboty] = null;
                                        _totalMoney--;
                                      }
                                      print('$_totalMoneyEarn');
                                    }
                                    break;
                                  case west:
                                    if (_robotx > 0 && _robotx <= widget.dimensionx) {
                                      _robotx -= 1;
                                      _totalMove--;
                                      _movementHistories.add('Array[$_robotx][$_robotx]');
                                      _totalMoneyEarn = _totalMoneyEarn + _totalMoneyEarn * (_interestRate / 100);
                                      if (_posMoney[_robotx][_roboty] != null) {
                                        _totalMoneyAvailable -= _posMoney[_robotx][_roboty];
                                        _totalMoneyFound += _posMoney[_robotx][_roboty];
                                        _totalMoneyEarn += _posMoney[_robotx][_roboty];
                                        _posMoney[_robotx][_roboty] = null;
                                        _totalMoney--;
                                      }
                                      print('$_totalMoneyEarn');
                                    }
                                    break;
                                  default:
                                }
                                if (_totalMove == 0 || _totalMoney == 0) {
                                  // BlocProvider.of<SendToServerBloc>(context).add(SendDataToServer(
                                  //   userId: 'asfd',
                                  //   movementHistories: _movementHistories,
                                  //   totalMoneyAvaiable: _totalMoneyAvailable,
                                  //   totalMoneyFound: _totalMoneyFound,
                                  //   interestRate: _interestRate,
                                  //   totalMoneyEarn: _totalMoneyEarn,
                                  // ));
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
                                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blueGrey),
                                child: Icon(Icons.keyboard_arrow_down),
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
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blueGrey),
                            child: Icon(Icons.keyboard_arrow_right),
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
    print('$_totalMoneyAvailable');
  }

  void _generateInterest() {
    var _numbers = Random();
    _interestRate = _numbers.nextInt(20) + 5;
  }

  void _loadingDialog(BuildContext context) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          child: SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  void _setPlace() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Set Robot Placement"),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
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
                          "Direction:     ",
                          style: TextStyle(fontSize: 20),
                        ),
                        DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          // style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items:
                              <String>['North', 'East', 'South', 'West'].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
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
                _robotx = _xVal;
                _roboty = _yVal;
                switch (dropdownValue) {
                  case 'North':
                    _direction = north;
                    break;
                  case 'East':
                    _direction = east;
                    break;
                  case 'South':
                    _direction = south;
                    break;
                  case 'West':
                    _direction = west;
                    break;
                  default:
                }
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
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Game Over"),
        content: Container(
          height: MediaQuery.of(context).size.height / 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    Container(
                      child: Text('Total Move :  '),
                    ),
                    Container(
                      child: Text('$_totalMove'),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    Container(
                      child: Text('Interest Rate :  '),
                    ),
                    Container(
                      child: Text('$_interestRate%'),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    Container(
                      child: Text('Total Money Available :  '),
                    ),
                    Container(
                      child: Text('\$$_totalMoneyAvailable'),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    Container(
                      child: Text('Total Money Found :  '),
                    ),
                    Container(
                      child: Text('\$$_totalMoneyFound'),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Text('Total Money Earn :  '),
              ),
              Container(
                alignment: Alignment.center,
                child: Text('\$${_totalMoneyEarn.toStringAsFixed(2)}'),
              )
            ],
          ),
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
