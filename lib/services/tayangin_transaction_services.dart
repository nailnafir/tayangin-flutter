part of 'services.dart';

class TayanginTransactionServices {
  // membuat reference ke transaction collection atau ke tabel transaksi firebase
  static CollectionReference transactionCollection =
      FirebaseFirestore.instance.collection('transactions');

  // membuat method untuk save transaksi
  static Future<void> saveTransaction(
      TayanginTransaction tayanginTransaction) async {
    await transactionCollection.doc().set({
      'userID': tayanginTransaction.userID,
      'title': tayanginTransaction.title,
      'subtitle': tayanginTransaction.subtitle,
      'time': tayanginTransaction.time.millisecondsSinceEpoch,
      'amount': tayanginTransaction.amount,
      'picture': tayanginTransaction.picture,
    });
  }

  // membuat method untuk get data transaksi
  static Future<List<TayanginTransaction>> getTransaction(String userID) async {
    QuerySnapshot snapshot = await transactionCollection.get();

    var documents =
        snapshot.docs.where((document) => document.data()['userID'] == userID);

    return documents
        .map((e) => TayanginTransaction(
              userID: e.data()['userID'],
              title: e.data()['title'],
              subtitle: e.data()['subtitle'],
              time: DateTime.fromMillisecondsSinceEpoch(e.data()['time']),
              amount: e.data()['amount'],
              picture: e.data()['picture'],
            ))
        .toList();
  }
}
