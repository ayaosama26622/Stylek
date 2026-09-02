part of '../page/product_details_screen.dart';

class _ReviewInput extends StatelessWidget {
  const _ReviewInput({
    required this.controller,
    required this.hint,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String hint;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(color: AppColor.onSurface(context)),
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: AppColor.isDark(context)
            ? const Color(0xFF3A3A3A)
            : const Color(0xFFF2F2F2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _AddReviewSheet extends StatefulWidget {
  const _AddReviewSheet({
    required this.productId,
    required this.initialName,
    required this.initialColor,
    required this.initialSize,
    required this.detailsCubit,
  });

  final String productId;
  final String initialName;
  final String initialColor;
  final String initialSize;
  final DetailsCubit detailsCubit;

  @override
  State<_AddReviewSheet> createState() => _AddReviewSheetState();
}

class _AddReviewSheetState extends State<_AddReviewSheet> {
  late final TextEditingController _userNameController;
  late final TextEditingController _colorController;
  late final TextEditingController _sizeController;
  late final TextEditingController _commentController;
  int _rating = 5;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController(text: widget.initialName);
    _colorController = TextEditingController(text: widget.initialColor);
    _sizeController = TextEditingController(text: widget.initialSize);
    _commentController = TextEditingController();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _colorController.dispose();
    _sizeController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _saveReview() async {
    if (_commentController.text.trim().isEmpty) {
      showErrorSnackBar(context, 'details.please_write_comment'.tr());
      return;
    }
    if (_isSaving) return;

    setState(() => _isSaving = true);
    try {
      await widget.detailsCubit.addReview(
        productId: widget.productId,
        review: ProductReviewModel(
          userName: _userNameController.text.trim().isEmpty
              ? 'common.default_user'.tr()
              : _userNameController.text.trim(),
          date: DateTime.now().toString().split(' ').first,
          rating: _rating,
          color: _colorController.text.trim(),
          size: _sizeController.text.trim(),
          comment: _commentController.text.trim(),
          likes: 0,
        ),
      );
      if (mounted) Navigator.of(context).pop(true);
    } catch (error) {
      if (mounted) {
        setState(() => _isSaving = false);
        showErrorSnackBar(context, error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        16,
        16,
        MediaQuery.viewInsetsOf(context).bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'details.add_a_review'.tr(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: AppColor.onSurface(context),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(5, (index) {
              return IconButton(
                onPressed: _isSaving
                    ? null
                    : () => setState(() => _rating = index + 1),
                icon: Icon(
                  index < _rating ? Icons.star : Icons.star_border,
                  color: index < _rating ? Colors.amber : AppColor.mutedOnCard(context),
                ),
              );
            }),
          ),
          _ReviewInput(
            controller: _userNameController,
            hint: 'details.name_hint'.tr(),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _ReviewInput(
                  controller: _colorController,
                  hint: 'details.color_hint'.tr(),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _ReviewInput(
                  controller: _sizeController,
                  hint: 'details.size_hint'.tr(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _ReviewInput(
            controller: _commentController,
            hint: 'details.comment_hint'.tr(),
            maxLines: 3,
          ),
          const SizedBox(height: 12),
          MainButton(
            text: _isSaving
                ? 'details.saving'.tr()
                : 'details.save_review'.tr(),
            onPressed: () {
              if (!_isSaving) _saveReview();
            },
            minHeight: 48,
          ),
        ],
      ),
    );
  }
}
