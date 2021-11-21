import 'package:counter_button/counter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robot_money_collector/bloc/send_to_server_bloc.dart';
import 'package:robot_money_collector/home_page.dart';

class DimensionPicker extends StatefulWidget {
  @override
  _DimensionPickerState createState() => _DimensionPickerState();
}

class _DimensionPickerState extends State<DimensionPicker> {
  int _xVal = 5, _yVal = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Robot Money Collector'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: Text(
                "Choose dimensions",
                style: TextStyle(fontSize: 20),
              ),
            ),
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
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                ),
                onPressed: () {
                  if (_xVal < 4 || _yVal < 4) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Dimensions too small    ( x < 4 || y < 4 )')));
                  } else if (_xVal > 9 || _yVal > 9) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Dimensions too BIG    ( x > 9 || y > 9 )')));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider<SendToServerBloc>(
                            create: (context) {
                              return SendToServerBloc();
                            },
                            child: HomePage(
                              dimensionx: _xVal,
                              dimensiony: _yVal,
                            ),
                          ),
                        ));
                  }
                },
                child: Text('Start'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
