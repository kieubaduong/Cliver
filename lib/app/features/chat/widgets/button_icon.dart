import 'package:cliver_mobile/app/core/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../../core/values/app_colors.dart';

class ButtonIcon extends StatelessWidget {
  final IconData icon;

  final void Function() onPressed;

  const ButtonIcon({Key? key, required this.icon, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: context.screenSize.width * 0.1,
        width: context.screenSize.width * 0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Icon(
          icon,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
