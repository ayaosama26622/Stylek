part of '../page/my_orders_screen.dart';

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});

  final InvoiceModel order;

  Color get _statusColor {
    switch (order.status.toLowerCase()) {
      case 'delivered':
      case 'completed':
        return const Color(0xFF2E7D32);
      case 'cancelled':
      case 'canceled':
        return AppColor.errorColor;
      default:
        return const Color(0xFFB07C00);
    }
  }

  String get _formattedDate {
    final date = order.createdAt;
    if (date == null) return '';
    final month = 'common.month_${date.month}'.tr();
    return '${date.day} $month ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.surface(context),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => context.push(Routes.invoicePath(order.id)),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: AppColor.gradientColors,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.shopping_bag_outlined,
                  color: AppColor.whiteColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '#${order.id}',
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
                      'my_orders.items_count'.plural(order.items.length) +
                          '${_formattedDate.isEmpty ? '' : '  •  $_formattedDate'}',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColor.mutedOnCard(context),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: _statusColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        translateOptionLabel(order.status),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: _statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${order.total.toStringAsFixed(0)} EGP',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      color: AppColor.onSurface(context),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 20,
                    color: AppColor.onSurface(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
