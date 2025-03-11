import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '/core/constant/app_assets.dart';
import '/core/theme/app_colors.dart';

class LoadingImageNetworkWidget extends StatefulWidget {
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
  State<LoadingImageNetworkWidget> createState() =>
      _LoadingImageNetworkWidgetState();
}

class _LoadingImageNetworkWidgetState extends State<LoadingImageNetworkWidget>
    with SingleTickerProviderStateMixin {
  // Add this mixin
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: widget.width ?? double.maxFinite,
      height: widget.height,
      imageUrl: widget.imageUrl,
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, downloadProgress) {
        return Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: _controller.value * -2 * 3.14159,
                child: Image.asset(
                  "assets/images/loading_indicator.png",
                  width: 50, // Adjust size as needed
                  height: 50,
                ),
              );
            },
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Skeletonizer(
          enabled: true,
          enableSwitchAnimation: true,
          child: Container(
            width: widget.width ?? double.maxFinite,
            height: widget.height,
            decoration: BoxDecoration(
              color: AppColors.greyColor,
              border: Border.all(
                width: 2,
                color: AppColors.greyColor,
              ),
            ),
            child: Expanded(
              child: Image.asset(
                AppAssets.firstScreenIMG,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
