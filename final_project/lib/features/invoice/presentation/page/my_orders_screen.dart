// Lists all of the current user's past orders, pulled live from Firestore.
import 'package:final_project/core/functions/option_labels.dart';
import 'package:final_project/core/routes/routes.dart';
import 'package:final_project/core/styles/colors.dart';
import 'package:final_project/core/widgets/app_empty_state.dart';
import 'package:final_project/core/widgets/app_header_bar.dart';
import 'package:final_project/features/invoice/data/model/invoice_model.dart';
import 'package:final_project/features/invoice/data/repo/invoice_repo.dart';
import 'package:final_project/features/invoice/domain/usecase/invoice_usecases.dart';
import 'package:final_project/features/invoice/presentation/cubit/invoice_cubit.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part '../widgets/order_card.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
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
            child: Column(
              children: [
                AppHeaderBar(
                  title: 'my_orders.title'.tr(),
                  onBack: () => context.pop(),
                ),
                Expanded(
                  child: StreamBuilder<List<InvoiceModel>>(
                    stream: _invoiceCubit.watchMyOrders(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                              ConnectionState.waiting &&
                          !snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColor.onSurface(context),
                          ),
                        );
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.error_outline_rounded,
                                  size: 44,
                                  color: AppColor.errorColor,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'my_orders.load_error'.tr(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: AppColor.onSurface(context),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '${snapshot.error}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: AppColor.greyColor(context).withValues(
                                      alpha: 0.9,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      final orders = snapshot.data ?? const <InvoiceModel>[];
                      if (orders.isEmpty) {
                        return AppEmptyState(
                          icon: Icons.receipt_long_outlined,
                          title: 'my_orders.empty'.tr(),
                          subtitle: 'my_orders.empty_subtitle'.tr(),
                        );
                      }

                      return ListView.separated(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                        itemCount: orders.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final order = orders[index];
                          return _OrderCard(order: order);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
