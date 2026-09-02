import 'package:final_project/features/invoice/data/model/invoice_model.dart';
import 'package:final_project/features/invoice/domain/usecase/invoice_usecases.dart';
import 'package:flutter/foundation.dart';

class InvoiceCubit extends ChangeNotifier {
  InvoiceCubit(this._useCases);

  final InvoiceUseCases _useCases;

  Stream<InvoiceModel?> watchInvoice(String orderId) {
    return _useCases.watchInvoice(orderId);
  }

  Stream<List<InvoiceModel>> watchMyOrders() {
    return _useCases.watchMyOrders();
  }
}
