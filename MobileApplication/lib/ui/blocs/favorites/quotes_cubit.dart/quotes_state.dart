import '../../../../logic/models/quotes.dart';

class QuotesState {}

class DisconnectedQuotesState extends QuotesState {}

class ConnectedQuotesState extends QuotesState {}

class NewDataQuotesState extends QuotesState {
  final Qoutes quotes;

  NewDataQuotesState({required this.quotes});
}

class ErrorQuotesState extends QuotesState {
  final String message;

  ErrorQuotesState({required this.message});
}
