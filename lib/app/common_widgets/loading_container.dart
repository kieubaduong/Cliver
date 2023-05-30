import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final BoxShape shape;
  final Color? baseColor;
  final Color? highlightColor;
  final Color? loadingColor;
  final Widget? child;

  const LoadingContainer({
    Key? key,
    this.shape = BoxShape.rectangle,
    this.borderRadius,
    this.width,
    this.height,
    this.baseColor,
    this.highlightColor,
    this.loadingColor,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey.shade300,
      highlightColor: highlightColor ?? Colors.grey.shade100,
      enabled: true,
      child: child ??
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              shape: shape,
              color: loadingColor ?? Colors.grey,
            ),
          ),
    );
  }
}
