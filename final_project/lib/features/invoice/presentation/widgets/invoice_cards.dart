part of '../page/invoice_screen.dart';

class _InvoiceSuccessCard extends StatelessWidget {
  const _InvoiceSuccessCard({required this.invoice});

  final InvoiceModel invoice;

  @override
  Widget build(BuildContext context) {
    return _InvoiceCard(
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: AppColor.gradientColors),
            ),
            child: const Icon(Icons.check_rounded, color: AppColor.whiteColor),
          ),
          const SizedBox(height: 10),
          Text(
            'invoice.order_confirmed'.tr(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: AppColor.onSurface(context),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '#${invoice.id}',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColor.mutedOnCard(context),
            ),
          ),
        ],
      ),
    );
  }
}

class _InvoiceDetailsCard extends StatelessWidget {
  const _InvoiceDetailsCard({required this.invoice});

  final InvoiceModel invoice;

  @override
  Widget build(BuildContext context) {
    return _InvoiceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InvoiceTitle('invoice.customer_details'.tr()),
          _InvoiceRow(label: 'invoice.name'.tr(), value: invoice.userName),
          _InvoiceRow(label: 'invoice.phone'.tr(), value: invoice.phone),
          _InvoiceRow(label: 'invoice.address'.tr(), value: invoice.address),
          _InvoiceRow(
            label: 'invoice.payment'.tr(),
            value: translateOptionLabel(invoice.paymentMethod),
          ),
          _InvoiceRow(
            label: 'invoice.status'.tr(),
            value: translateOptionLabel(invoice.status),
          ),
        ],
      ),
    );
  }
}

class _InvoiceItemsCard extends StatelessWidget {
  const _InvoiceItemsCard({required this.invoice});

  final InvoiceModel invoice;

  @override
  Widget build(BuildContext context) {
    return _InvoiceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InvoiceTitle('invoice.items'.tr()),
          ...invoice.items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      item.image,
                      width: 46,
                      height: 46,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 46,
                        height: 46,
                        color: AppColor.accentColor,
                        child: Icon(Icons.checkroom_outlined, color: AppColor.greyColor(context), size: 22),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.localizedName(context),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w900,
                            color: AppColor.onSurface(context),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${item.color}  Size: ${item.size}  Qty: ${item.quantity}',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColor.mutedOnCard(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${item.lineTotal.toStringAsFixed(0)} EGP',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: AppColor.onSurface(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InvoiceSummaryCard extends StatelessWidget {
  const _InvoiceSummaryCard({required this.invoice});

  final InvoiceModel invoice;

  @override
  Widget build(BuildContext context) {
    return _InvoiceCard(
      child: Column(
        children: [
          _InvoiceRow(
            label: 'invoice.subtotal'.tr(),
            value: '${invoice.subtotal.toStringAsFixed(2)} EGP',
          ),
          _InvoiceRow(
            label: 'invoice.delivery_fee'.tr(),
            value: '${invoice.deliveryFee.toStringAsFixed(2)} EGP',
          ),
          _InvoiceRow(
            label: 'invoice.discount'.tr(
              namedArgs: {
                'percent': invoice.discountPercent.toStringAsFixed(0),
              },
            ),
            value: '${invoice.discount.toStringAsFixed(2)} EGP',
          ),
          Divider(color: AppColor.greyColor(context).withValues(alpha: 0.25)),
          _InvoiceRow(
            label: 'invoice.total'.tr(),
            value: '${invoice.total.toStringAsFixed(2)} EGP',
            isTotal: true,
          ),
        ],
      ),
    );
  }
}
