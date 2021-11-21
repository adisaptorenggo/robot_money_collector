import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:robot_money_collector/constants.dart' as constants;

part 'send_to_server_event.dart';
part 'send_to_server_state.dart';

class SendToServerBloc extends Bloc<SendToServerEvent, SendToServerState> {
  SendToServerBloc() : super(SendToServerInitial());

  @override
  Stream<SendToServerState> mapEventToState(
    SendToServerEvent event,
  ) async* {
    if (event is SendDataToServer) {
      yield SendToServerLoading();
      try {
        final result = await _sendDataToServer(event.userId, event.movementHistories, event.totalMoneyAvaiable,
            event.totalMoneyFound, event.interestRate, event.totalMoneyEarn);

        if (result.statusCode == 200) {
          yield SendToServerSuccess();
        } else {
          yield SendToServerError(error: "${result.toString()}");
        }
      } catch (e) {
        yield SendToServerError(error: "${e.toString()}");
      }
    }
  }
}

Future _sendDataToServer(
  String userId,
  List<String> movementHistories,
  double totalMoneyAvaiable,
  double totalMoneyFound,
  int interestRate,
  double totalMoneyEarn,
) async {
  var url = Uri.parse('https://test.komunal.id/robo-test/');
  var response = await http.post(url, body: {
    constants.userID: userId,
    constants.movementHistories: movementHistories,
    constants.totalMoneyAvailable: totalMoneyAvaiable,
    constants.totalMoneyFound: totalMoneyFound,
    constants.interestRate: interestRate,
    constants.totalMoneyEarn: totalMoneyEarn,
  });
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  // print(await http.read(Uri.parse('https://example.com/foobar.txt')));
}
