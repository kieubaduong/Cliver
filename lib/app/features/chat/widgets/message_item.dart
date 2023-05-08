import 'package:cliver_mobile/app/core/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../../core/values/app_colors.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({
    super.key,
    required this.isSentByMe,
    required this.content,
    required this.isReplied,
  });
  final bool isSentByMe;
  final String content;
  final bool isReplied;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor, textColor;
    if (isReplied) {
      backgroundColor = AppColors.lightGreenColor;
      textColor = AppColors.primaryColor;
    } else {
      backgroundColor = (isSentByMe) ? AppColors.primaryColor : Colors.white;
      textColor = (isSentByMe) ? Colors.white : Colors.black;
    }
    return Container(
      constraints: BoxConstraints(maxWidth: context.screenSize.width * 0.7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: backgroundColor,
        boxShadow: !(isSentByMe)
            ? [
                BoxShadow(
                  blurRadius: 50,
                  color: AppColors.greyShadowColor,
                  offset: const Offset(20, 20),
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          content,
          style: TextStyle(
            fontSize: context.screenSize.height * 0.02,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
