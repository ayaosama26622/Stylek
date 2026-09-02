part of 'cart_item_card.dart';

class _OptionRow extends StatelessWidget {
  const _OptionRow({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    this.translateOptions = false,
  });

  final String label;
  final String value;
  final List<String> options;
  final ValueChanged<String> onChanged;
  final bool translateOptions;

  @override
  Widget build(BuildContext context) {
    final selectedValue = options.contains(value) ? value : options.first;
    return Row(
      children: [
        SizedBox(
          width: 42,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColor.mutedOnCard(context).withValues(alpha: 0.95),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: AppColor.surface(context),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColor.greyColor(context).withValues(alpha: 0.35),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedValue,
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 18,
                  color: AppColor.onSurface(context),
                ),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColor.onSurface(context),
                ),
                dropdownColor: AppColor.surface(context),
                borderRadius: BorderRadius.circular(10),
                items: options
                    .map(
                      (option) => DropdownMenuItem<String>(
                        value: option,
                        child: Text(
                          translateOptions
                              ? translateOptionLabel(option)
                              : option,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (newValue) {
                  if (newValue == null || newValue == value) return;
                  onChanged(newValue);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
