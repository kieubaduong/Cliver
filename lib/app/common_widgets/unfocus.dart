import 'package:flutter/material.dart';

class UnFocusWidget extends StatefulWidget {
  final Widget child;

  const UnFocusWidget({required this.child, Key? key}) : super(key: key);

  @override
  State<UnFocusWidget> createState() => _UnFocusWidgetState();
}

class _UnFocusWidgetState extends State<UnFocusWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (primaryFocus != null) {
          primaryFocus!.unfocus();
        }
      },
      child: widget.child,
    );
  }
}
