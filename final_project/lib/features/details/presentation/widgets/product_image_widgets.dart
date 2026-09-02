part of '../page/product_details_screen.dart';

class _MainProductImage extends StatelessWidget {
  const _MainProductImage({required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: AspectRatio(
        aspectRatio: 1.05,
        child: Image.asset(
          image,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: AppColor.greyColor(context),
            child: const Icon(
              Icons.checkroom_outlined,
              size: 64,
              color: AppColor.whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}

class _GalleryRow extends StatelessWidget {
  const _GalleryRow({required this.images});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(
                images[index],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 88,
                  color: AppColor.greyColor(context).withValues(alpha: 0.12),
                  child: Icon(
                    Icons.image_outlined,
                    color: AppColor.greyColor(context),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
