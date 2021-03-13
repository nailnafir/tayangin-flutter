part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {
  @override
  List<Object> get props => [];
}

class TransactionLoaded extends TransactionState {
  final List<TayanginTransaction> transaction;

  TransactionLoaded({this.transaction});

  @override
  List<Object> get props => [transaction];
}
