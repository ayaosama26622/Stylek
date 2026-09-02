import 'package:final_project/core/widgets/app_empty_state.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';

class FavoritesEmptyState extends StatelessWidget {
  const FavoritesEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return AppEmptyState(
      icon: Icons.favorite_border_rounded,
      title: 'favorites.empty'.tr(),
    );
  }
}
