part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();
}

class LoadTransaction extends TransactionEvent {
  final String id;

  LoadTransaction(this.id);

  @override
  List<Object> get props => [id];
}
