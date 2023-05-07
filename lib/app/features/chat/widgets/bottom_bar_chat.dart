import 'package:cliver_mobile/app/features/chat/chat_controller.dart';
import 'package:cliver_mobile/app/core/utils/utils.dart';
import 'package:cliver_mobile/app/features/chat/widgets/button_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/app_colors.dart';

class BottomBarChat extends StatelessWidget {
  BottomBarChat({Key? key}) : super(key: key);
  final chatController = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(
          top: context.height * 0.01,
          left: context.width * 0.02,
          right: context.width * 0.02,
        ),
        child: SizedBox(
          height: context.height * 0.15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Obx(
                () => Visibility(
                  visible: chatController.replyMessageData.isReplied.value,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Icon(
                                    Icons.reply,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                Text(
                                  "Replying to ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                Text(
                                  chatController.partnerName.value,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              chatController
                                  .replyMessageData.replyMessage.value,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.lightGreenColor,
                        ),
                        child: Icon(
                          Icons.close,
                          color: AppColors.primaryColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ButtonIcon(
                    onPressed: () {
                      chatController.openImageAttach.value =
                          !chatController.openImageAttach.value;
                    },
                    icon: Icons.add,
                  ),
                  SizedBox(
                    width: context.screenSize.width * 0.03,
                  ),
                  ButtonIcon(
                    onPressed: () {},
                    icon: Icons.mic,
                  ),
                  SizedBox(
                    width: context.screenSize.width * 0.03,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration.collapsed(
                                hintText: '${'Write now'.tr}...',
                              ),
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              controller: chatController.messageInput.value,
                              onSubmitted: (_) => chatController.sendMessage(),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () => (chatController.isDisconnected.value)
                                ? Get.defaultDialog(
                                    title: "Error",
                                    content: const Text("Server error"),
                                  )
                                : chatController.sendMessage(),
                            child: Icon(
                              Icons.send,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
