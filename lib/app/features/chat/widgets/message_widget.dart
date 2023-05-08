import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:cliver_mobile/app/core/utils/utils.dart';
import 'package:cliver_mobile/app/features/chat/chat_controller.dart';
import 'package:cliver_mobile/app/features/chat/widgets/message_custom_order.dart';
import 'package:cliver_mobile/app/features/chat/widgets/message_item.dart';
import 'package:cliver_mobile/app/features/chat/widgets/message_related_post.dart';
import 'package:cliver_mobile/data/models/message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/values/app_colors.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget(
      {super.key,
      required this.isSentByMe,
      required this.message,
      required this.index,
      this.replyMessage,
      this.replyLabel});
  final bool isSentByMe;
  final Message message;
  final int index;
  final String? replyMessage, replyLabel;

  @override
  Widget build(BuildContext context) {
    final chatController = Get.find<ChatController>();
    final DateFormat formatter;

    if (FormatHelper().toLocal(message.createdAt)?.day != DateTime.now().day) {
      formatter = DateFormat('HH:mm dd/MM/yyyy');
    } else {
      formatter = DateFormat('jm');
    }

    return Column(
      crossAxisAlignment:
          (isSentByMe) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
              (isSentByMe) ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => chatController.showTimeSent(index),
              onLongPress: () => chatController.showCopyDialog(
                message: message,
                isSentByMe: isSentByMe,
              ),
              onTapDown: (details) =>
                  chatController.getCopyDialogPosition(details),
              child: Column(
                crossAxisAlignment: (isSentByMe)
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  // reply label
                  Visibility(
                    visible: message.repliedToMessageId != null,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.reply,
                          color: Colors.grey,
                        ),
                        Text(
                          replyLabel ?? "",
                          style: const TextStyle(color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  // message reply to another message
                  ColumnSuper(
                    innerDistance: -10,
                    alignment: (isSentByMe)
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    children: [
                      Visibility(
                        visible: message.repliedToMessageId != null,
                        child: MessageItem(
                            content: replyMessage ?? "",
                            isSentByMe: isSentByMe,
                            isReplied: true),
                      ),
                      MessageItem(
                        content: message.content as String,
                        isSentByMe: isSentByMe,
                        isReplied: false,
                      ),
                    ],
                  ),
                  MessageRelatedPost(
                    isRelatedToPost: message.relatedPost != null,
                    message: message,
                    isSentByMe: isSentByMe,
                  ),
                  // custom order message
                  if (message.customPackageId != null)
                    MessageCustomOrder(message: message)
                  else
                    const SizedBox.shrink()
                ],
              ),
            ),
            Obx(() => Visibility(
                  visible: message.isLoading.value,
                  child: Row(
                    children: const [
                      SizedBox(width: 5),
                      SizedBox(
                        width: 10,
                        height: 10,
                        child: CircularProgressIndicator(),
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                )),
          ],
        ),
        Obx(() => Visibility(
              visible: message.isError.value,
              child: Row(
                mainAxisAlignment: (isSentByMe)
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: const [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 20,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Can't send message",
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  )
                ],
              ),
            )),
        // show message time
        Obx(
          () => Visibility(
            visible: index == chatController.hideTimeIndex.value &&
                !chatController.hideTime.value,
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Text(
                  formatter.format(
                      FormatHelper().toLocal(message.createdAt) as DateTime),
                  style: TextStyle(
                      color: AppColors.lightGreyColor,
                      fontSize: context.height * 0.015),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
