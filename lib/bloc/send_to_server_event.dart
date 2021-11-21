part of 'send_to_server_bloc.dart';

@immutable
abstract class SendToServerEvent {}

class SendDataToServer extends SendToServerEvent {
  final String userId;
  final List<String> movementHistories;
  final double totalMoneyAvaiable;
  final double totalMoneyFound;
  final int interestRate;
  final double totalMoneyEarn;

  SendDataToServer(
      {this.userId,
      this.movementHistories,
      this.totalMoneyAvaiable,
      this.totalMoneyFound,
      this.interestRate,
      this.totalMoneyEarn});

  @override
  List<Object> get props => [];
}
