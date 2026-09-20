import 'package:final_project/features/invoice/data/model/invoice_model.dart';
import 'package:final_project/features/invoice/data/repo/invoice_repo.dart';

class InvoiceUseCases {
  InvoiceUseCases(this._repo);

  final InvoiceRepo _repo;

  Stream<InvoiceModel?> watchInvoice(String orderId) {
    return _repo.watchInvoice(orderId);
  }

  Stream<List<InvoiceModel>> watchMyOrders() {
    return _repo.watchMyOrders();
  }
}
