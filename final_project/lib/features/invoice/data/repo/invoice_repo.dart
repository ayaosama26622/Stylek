import 'package:final_project/core/services/firebase/firestore_provider.dart';
import 'package:final_project/features/invoice/data/model/invoice_model.dart';

class InvoiceRepo {
  Stream<InvoiceModel?> watchInvoice(String orderId) {
    return FirebaseProvider.orderStream(orderId).map((snapshot) {
      final data = snapshot.data();
      if (data == null) return null;
      return InvoiceModel.fromMap(snapshot.id, data);
    });
  }

  Stream<List<InvoiceModel>> watchMyOrders() {
    return FirebaseProvider.myOrdersStream().map((snapshot) {
      final orders = snapshot.docs
          .map((doc) => InvoiceModel.fromMap(doc.id, doc.data()))
          .toList();
      orders.sort((a, b) {
        final aDate = a.createdAt;
        final bDate = b.createdAt;
        if (aDate == null && bDate == null) return 0;
        if (aDate == null) return 1;
        if (bDate == null) return -1;
        return bDate.compareTo(aDate);
      });
      return orders;
    });
  }
}
