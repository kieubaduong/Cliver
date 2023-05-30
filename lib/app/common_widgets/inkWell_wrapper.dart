import 'package:flutter/material.dart';

class InkWellWrapper extends StatelessWidget {
  final Color? color;
  final VoidCallback? onTap;
  final void Function(TapDownDetails)? onTapDown;
  final Widget child;
  final BorderRadius? borderRadius;
  final Color? splashColor;
  final Color? highlightColor;
  final Color? hoverColor;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? paddingChild;
  final EdgeInsetsGeometry margin;
  final Border? border;
  final List<BoxShadow>? boxShadow;

  const InkWellWrapper(
      {Key? key,
        this.color,
        this.onTap,
        this.onTapDown,
        required this.child,
        this.borderRadius,
        this.splashColor = const Color.fromRGBO(102, 102, 102, 0.24),
        this.highlightColor = const Color.fromRGBO(102, 102, 102, 0.24),
        this.hoverColor = const Color.fromRGBO(102, 102, 102, 0.24),
        this.height,
        this.width,
        this.paddingChild,
        this.border,
        this.margin = EdgeInsets.zero,
        this.boxShadow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
          border: border, color: color, borderRadius: borderRadius, boxShadow: boxShadow),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onTapDown: onTapDown,
          highlightColor: highlightColor,
          splashColor: splashColor,
          hoverColor: hoverColor,
          borderRadius: borderRadius,
          child: Container(
            height: height,
            width: width,
            padding: paddingChild,
            child: child,
          ),
        ),
      ),
    );
  }
}
