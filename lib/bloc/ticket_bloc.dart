import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tayangin_flutter/models/models.dart';
import 'package:tayangin_flutter/services/services.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  TicketState get initialState => TicketState([]);

  @override
  Stream<TicketState> mapEventToState(
    TicketEvent event,
  ) async* {
    if (event is BuyTicket) {
      // save ticket ke firebase
      await TicketServices.saveTicket(event.userID, event.ticket);

      // kalo udah berhasil disimpan, buat list ticket yang baru
      // list ticket saat ini + list ticket yang baru
      List<Ticket> tickets = state.tickets + [event.ticket];

      // kembalikan yield ticket state yang baru
      yield TicketState(tickets);
    } else if (event is GetTickets) {
      // ambil data ticket dari firebase
      List<Ticket> tickets = await TicketServices.getTickets(event.userID);

      // kembalikan yield ticket state yang baru
      yield TicketState(tickets);
    }
  }
}
