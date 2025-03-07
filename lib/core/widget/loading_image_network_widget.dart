import 'package:flutter/material.dart';
import 'package:travel_go/core/theme/app_colors.dart';

class LoadingImageNetworkWidget extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;

  const LoadingImageNetworkWidget({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      width: width ??  double.maxFinite,
      imageUrl,
      fit: BoxFit.cover,
      height: height,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            color: AppColors.newBlueColor,
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    (loadingProgress.expectedTotalBytes ?? 1)
                : null,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Center(
          child: Icon(Icons.error, color: Colors.red, size: 50),
        );
      },
    );
  }
}
