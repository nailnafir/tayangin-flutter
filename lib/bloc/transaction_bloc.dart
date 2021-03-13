import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tayangin_flutter/models/models.dart';
import 'package:tayangin_flutter/services/services.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitial());

  @override
  Stream<TransactionState> mapEventToState(
    TransactionEvent event,
  ) async* {
    if (event is LoadTransaction) {
      List<TayanginTransaction> transaction =
          await TayanginTransactionServices.getTransaction(event.id);
      yield TransactionLoaded(transaction: transaction);
    }
  }
}
