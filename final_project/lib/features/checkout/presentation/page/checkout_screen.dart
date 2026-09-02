import 'package:final_project/core/routes/routes.dart';
import 'package:final_project/core/styles/colors.dart';
import 'package:final_project/core/widgets/app_gradient_scaffold.dart';
import 'package:final_project/core/widgets/app_header_bar.dart';
import 'package:final_project/core/widgets/app_snack_bar.dart';
import 'package:final_project/core/widgets/main_button.dart';
import 'package:final_project/features/cart/data/model/cart_item_model.dart';
import 'package:final_project/features/checkout/data/model/checkout_pricing_model.dart';
import 'package:final_project/features/checkout/data/repo/checkout_repo.dart';
import 'package:final_project/features/checkout/domain/usecase/checkout_usecases.dart';
import 'package:final_project/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part '../widgets/checkout_card_widgets.dart';
part '../widgets/checkout_map_preview.dart';
part '../widgets/checkout_payment_widgets.dart';
part '../widgets/checkout_summary_widgets.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  bool _isLoading = false;
  String _selectedPaymentMethod = 'cash';
  late final CheckoutCubit _checkoutCubit;

  String get _paymentMethodLabel {
    switch (_selectedPaymentMethod) {
      case 'card':
        return 'Credit Card';
      case 'other':
        return 'Other';
      case 'cash':
      default:
        return 'Cash on Delivery';
    }
  }

  @override
  void initState() {
    super.initState();
    _checkoutCubit = CheckoutCubit(CheckoutUseCases(CheckoutRepo()));
    _checkoutCubit.seedCheckoutPricingIfNeeded();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _checkoutCubit.dispose();
    super.dispose();
  }

  Future<void> _submitOrder(
    List<CartItemModel> items,
    CheckoutPricingModel pricing,
  ) async {
    if (_isLoading || items.isEmpty) return;
    if (_nameController.text.trim().isEmpty ||
        _phoneController.text.trim().isEmpty ||
        _addressController.text.trim().isEmpty) {
      showErrorSnackBar(context, 'checkout.complete_order_details'.tr());
      return;
    }

    setState(() => _isLoading = true);
    try {
      final orderId = await _checkoutCubit.createOrder(
        userName: _nameController.text,
        phone: _phoneController.text,
        address: _addressController.text,
        paymentMethod: _paymentMethodLabel,
        items: items,
        pricing: pricing,
      );
      if (mounted) context.go(Routes.invoicePath(orderId));
    } catch (error) {
      if (!mounted) return;
      showErrorSnackBar(context, error.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppGradientScaffold(
      body: Column(
        children: [
          AppHeaderBar(
            title: 'checkout.checkout'.tr(),
            onBack: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go(Routes.home);
              }
            },
          ),
          Expanded(
            child: StreamBuilder<CheckoutPricingModel>(
              stream: _checkoutCubit.watchPricing(),
              builder: (context, pricingSnapshot) {
                final pricing =
                          pricingSnapshot.data ??
                          const CheckoutPricingModel(
                            discountPercent: 15,
                            deliveryFee: 15,
                          );
                      return ListView(
                        padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
                        children: [
                          Text(
                            'checkout.description'.tr(),
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.35,
                              fontWeight: FontWeight.w500,
                              color: AppColor.greyColor(context),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _CheckoutCard(
                            title: 'checkout.personal_information'.tr(),
                            icon: Icons.person_outline_rounded,
                            children: [
                              _CheckoutInput(
                                icon: Icons.person_outline_rounded,
                                hint: 'checkout.user_name_hint'.tr(),
                                controller: _nameController,
                              ),
                              const SizedBox(height: 10),
                              _CheckoutInput(
                                icon: Icons.phone_rounded,
                                hint: 'checkout.mobile_number_hint'.tr(),
                                controller: _phoneController,
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          _CheckoutCard(
                            title: 'checkout.delivery_address'.tr(),
                            icon: Icons.local_shipping_outlined,
                            children: [
                              const _MapPreview(),
                              const SizedBox(height: 10),
                              _CheckoutInput(
                                icon: Icons.home_outlined,
                                hint: 'checkout.address_hint'.tr(),
                                controller: _addressController,
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          _CheckoutCard(
                            title: 'checkout.payment_method'.tr(),
                            icon: Icons.account_balance_wallet_outlined,
                            children: [
                              _PaymentTile(
                                icon: Icons.credit_card_rounded,
                                label: 'checkout.credit_card'.tr(),
                                isSelected:
                                    _selectedPaymentMethod == 'card',
                                onTap: () => setState(
                                  () => _selectedPaymentMethod = 'card',
                                ),
                              ),
                              const SizedBox(height: 10),
                              _PaymentTile(
                                icon: Icons.payments_outlined,
                                label: 'checkout.cash_on_delivery'.tr(),
                                isSelected:
                                    _selectedPaymentMethod == 'cash',
                                onTap: () => setState(
                                  () => _selectedPaymentMethod = 'cash',
                                ),
                              ),
                              const SizedBox(height: 10),
                              _OtherMethodsTile(
                                isSelected:
                                    _selectedPaymentMethod == 'other',
                                onTap: () => setState(
                                  () => _selectedPaymentMethod = 'other',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          StreamBuilder<List<CartItemModel>>(
                            stream: _checkoutCubit.watchCartItems(),
                            builder: (context, cartSnapshot) {
                              final items =
                                  cartSnapshot.data ??
                                  const <CartItemModel>[];
                              return Column(
                                children: [
                                  _CheckoutSummaryCard(
                                    items: items,
                                    pricing: pricing,
                                  ),
                                  const SizedBox(height: 18),
                                  MainButton(
                                    text: _isLoading
                                        ? 'checkout.please_wait'.tr()
                                        : 'checkout.done'.tr(),
                                    onPressed: () =>
                                        _submitOrder(items, pricing),
                                    minHeight: 52,
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
