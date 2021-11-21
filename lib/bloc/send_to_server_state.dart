part of 'send_to_server_bloc.dart';

@immutable
abstract class SendToServerState {}

class SendToServerInitial extends SendToServerState {}

class SendToServerLoading extends SendToServerState {}

class SendToServerSuccess extends SendToServerState {}

class SendToServerError extends SendToServerState {
  final String error;

  SendToServerError({@required this.error});
  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SendToServerError { error: $error }';
}
