import 'package:final_project/core/styles/colors.dart';
import 'package:final_project/core/widgets/main_button.dart';
import 'package:final_project/features/cart/data/model/cart_item_model.dart';
import 'package:final_project/features/cart/presentation/widgets/discount_code_field.dart';
import 'package:final_project/features/cart/presentation/widgets/order_summary_card.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';

class CartBottomPanel extends StatelessWidget {
  const CartBottomPanel({
    super.key,
    required this.summary,
    required this.discountController,
    required this.onCheckout,
  });

  final CartSummaryModel summary;
  final TextEditingController discountController;
  final VoidCallback? onCheckout;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 86),
      color: Colors.transparent,
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DiscountCodeField(controller: discountController),
            const SizedBox(height: 12),
            OrderSummaryCard(summary: summary),
            const SizedBox(height: 12),
            MainButton(
              text: 'cart.checkout'.tr(),
              onPressed: onCheckout ?? () {},
              minHeight: 52,
              bgColor: AppColor.primaryPink,
            ),
          ],
        ),
      ),
    );
  }
}
