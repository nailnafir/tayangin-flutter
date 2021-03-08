part of 'services.dart';

class TicketServices {
  // membuat collection atau tabel database
  static CollectionReference ticketCollection =
      FirebaseFirestore.instance.collection('tickets');

  // simpan data ke firebase
  static Future<void> saveTicket(String id, Ticket ticket) async {
    await ticketCollection.doc().set({
      'movieID': ticket.movieDetail.id ?? "",
      'userID': id ?? "",
      'theaterName': ticket.theater.name ?? 0,
      'time': ticket.time.millisecondsSinceEpoch ??
          DateTime.now().millisecondsSinceEpoch,
      'bookingCode': ticket.bookingCode,
      'seats': ticket.seatsInString,
      'name': ticket.name,
      'totalPrice': ticket.totalPrice
    });
  }

  // service untuk get ticket
  static Future<List<Ticket>> getTickets(String userId) async {
    // get document data dan ambil kumpulan ticket yang user id nya sesuai dengan parameter
    QuerySnapshot snapshot = await ticketCollection.get();
    var documents =
        snapshot.docs.where((document) => document.data()['userID'] == userId);

    // membuat list ticket dan ambil movie detail
    List<Ticket> tickets = [];
    for (var document in documents) {
      MovieDetail movieDetail = await MovieServices.getDetails(null,
          movieID: document.data()['movieID']);
      tickets.add(Ticket(
          movieDetail,
          Theater(document.data()['theaterName']),
          DateTime.fromMillisecondsSinceEpoch(document.data()['time']),
          document.data()['bookingCode'],
          document.data()['seats'].toString().split(','),
          document.data()['name'],
          document.data()['totalPrice']));
    }

    return tickets;
  }
}
