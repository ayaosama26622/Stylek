import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:final_project/core/styles/colors.dart';
import 'package:final_project/features/auth/presentation/widgets/custom_gradient_border.dart';

class SearchBarWithFilter extends StatelessWidget {
  const SearchBarWithFilter({
    super.key,
    this.onFilterTap,
    this.controller,
    this.onTap,
    this.readOnly = false,
    this.autofocus = false,
    this.onChanged,
    this.isFilterActive = false,
  });

  final VoidCallback? onFilterTap;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final bool isFilterActive;

  @override
  Widget build(BuildContext context) {
    final bool isDark = AppColor.isDark(context);

    // Light mode: white pill with a soft pink-to-blue gradient outline and
    // grey icons/text. Dark mode keeps the original solid dark styling.
    final Color fieldColor = isDark ? AppColor.darkColor(context) : AppColor.whiteColor;
    final Color iconColor = isDark ? AppColor.whiteColor : AppColor.greyColor(context);

    final Widget searchField = Container(
      height: 48,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: fieldColor,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: TextField(
        controller: controller,
        onTap: onTap,
        onChanged: onChanged,
        readOnly: readOnly,
        autofocus: autofocus,
        style: TextStyle(fontSize: 13, color: isDark ? AppColor.whiteColor : AppColor.darkColor(context)),
        decoration: InputDecoration(
          hintText: 'home.search_hint'.tr(),
          hintStyle: TextStyle(color: iconColor, fontSize: 13),
          prefixIcon: Icon(
            Icons.search,
            color: iconColor,
            size: 20,
          ),
          suffixIcon: Icon(
            Icons.mic_none_rounded,
            color: iconColor,
            size: 20,
          ),
          filled: true,
          fillColor: fieldColor,
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14.5)),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14.5)),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );

    final Widget filterButton = GestureDetector(
      onTap: onFilterTap,
      child: Container(
        height: 48,
        width: 48,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: fieldColor,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: fieldColor,
            borderRadius: BorderRadius.all(Radius.circular(14.5)),
          ),
          child: Icon(
            Icons.tune_rounded,
            color: iconColor,
            size: 20,
          ),
        ),
      ),
    );

    return Row(
      textDirection: TextDirection.ltr,
      children: [
        Expanded(
          child: CustomGradientBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            strokeWidth: 3,
            child: searchField,
          ),
        ),
        const SizedBox(width: 10),
        CustomGradientBorder(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          strokeWidth: 3,
          child: filterButton,
        ),
      ],
    );
  }
}
