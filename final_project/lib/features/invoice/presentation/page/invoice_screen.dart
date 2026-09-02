import 'package:final_project/core/functions/option_labels.dart';
import 'package:final_project/core/routes/routes.dart';
import 'package:final_project/core/styles/colors.dart';
import 'package:final_project/core/widgets/app_header_bar.dart';
import 'package:final_project/core/widgets/main_button.dart';
import 'package:final_project/features/invoice/data/model/invoice_model.dart';
import 'package:final_project/features/invoice/data/repo/invoice_repo.dart';
import 'package:final_project/features/invoice/domain/usecase/invoice_usecases.dart';
import 'package:final_project/features/invoice/presentation/cubit/invoice_cubit.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part '../widgets/invoice_cards.dart';
part '../widgets/invoice_common_widgets.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key, required this.orderId});

  final String orderId;

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  late final InvoiceCubit _invoiceCubit;

  @override
  void initState() {
    super.initState();
    _invoiceCubit = InvoiceCubit(InvoiceUseCases(InvoiceRepo()));
  }

  @override
  void dispose() {
    _invoiceCubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColor.pageGradient(context),
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: StreamBuilder<InvoiceModel?>(
              stream: _invoiceCubit.watchInvoice(widget.orderId),
              builder: (context, snapshot) {
                final invoice = snapshot.data;
                if (invoice == null) {
                  return Center(
                    child: CircularProgressIndicator(color: AppColor.onSurface(context)),
                  );
                }
                return Column(
                  children: [
                    AppHeaderBar(
                      title: 'invoice.title'.tr(),
                      onBack: () => context.go(Routes.home),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 22),
                        children: [
                          _InvoiceSuccessCard(invoice: invoice),
                          const SizedBox(height: 14),
                          _InvoiceDetailsCard(invoice: invoice),
                          const SizedBox(height: 14),
                          _InvoiceItemsCard(invoice: invoice),
                          const SizedBox(height: 14),
                          _InvoiceSummaryCard(invoice: invoice),
                          const SizedBox(height: 18),
                          MainButton(
                            text: 'invoice.done'.tr(),
                            onPressed: () => context.go(Routes.home),
                            minHeight: 52,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
