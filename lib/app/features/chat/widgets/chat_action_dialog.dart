import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/utils.dart';
import '../../../core/values/app_colors.dart';
import '../../features.dart';

class ChatActionDialog extends StatelessWidget {
  ChatActionDialog({
    Key? key,
  }) : super(key: key);
  final chatController = Get.find<ChatController>();
  @override
  Widget build(BuildContext context) {
    final isSentByMe = chatController.copyChatData.isSentByMe.value;
    final message = chatController.copyChatData.message.value;
    return Column(
      children: [
        InkWell(
          onTap: () => chatController.copyChat(message.content as String),
          child: Container(
            width: context.screenSize.width * 0.3,
            height: context.screenSize.height * 0.045,
            decoration: BoxDecoration(
              color: (isSentByMe) ? Colors.white : AppColors.primaryColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(5),
                topLeft: Radius.circular(5),
              ),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.copy,
                  color: (isSentByMe) ? AppColors.primaryColor : Colors.white,
                  size: context.screenSize.height * 0.03,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Copy',
                  style: TextStyle(
                    fontSize: context.screenSize.height * 0.02,
                    color: (isSentByMe) ? AppColors.blackColor : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 1,
          width: context.screenSize.width * 0.3,
          color: (isSentByMe) ? AppColors.primaryColor : Colors.white,
        ),
        InkWell(
          onTap: () => chatController.reply(
            messageId: message.id as int,
            messageContent: message.content as String,
          ),
          child: Container(
            width: context.screenSize.width * 0.3,
            height: context.screenSize.height * 0.045,
            decoration: BoxDecoration(
              color: (isSentByMe) ? Colors.white : AppColors.primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.reply_outlined,
                  color: (isSentByMe) ? AppColors.primaryColor : Colors.white,
                  size: context.screenSize.height * 0.03,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Reply',
                  style: TextStyle(
                    fontSize: context.screenSize.height * 0.02,
                    color: (isSentByMe) ? AppColors.blackColor : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
