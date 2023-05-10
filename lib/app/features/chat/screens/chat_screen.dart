import 'package:cliver_mobile/app/core/values/app_colors.dart';
import 'package:cliver_mobile/app/features/chat/widgets/card_post.dart';
import 'package:cliver_mobile/app/features/chat/widgets/image_attach_popup.dart';
import 'package:cliver_mobile/app/features/chat/widgets/message_widget.dart';
import 'package:cliver_mobile/data/models/message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../chat_controller.dart';
import '../widgets/app_bar_chat.dart';
import '../widgets/arrow_scroll.dart';
import '../widgets/bottom_bar_chat.dart';
import '../widgets/chat_action_dialog.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final chatController = Get.find<ChatController>();
  String username = Get.arguments[1];
  String? partnerAvt = Get.arguments[4];

  @override
  void initState() {
    super.initState();
    chatController.initChatScreenData(username);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: InkWell(
            onTap: () => chatController.backToRoomScreen(),
            child: const Icon(
              Icons.arrow_back,
              size: 30,
            ),
          ),
          title: AppBarChat(
            username: username,
            partnerAvt: partnerAvt,
          ),
        ),
        body: GestureDetector(
          onTap: () => chatController.tapOnChatScreen(),
          child: Column(
            children: [
              // error message
              Obx(
                () => Visibility(
                  visible: chatController.isDisconnected.value,
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${'Server error'.tr}!",
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // post tag
              Obx(() => (chatController.post.value?.description != null)
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CardPost(
                        imageUrl: chatController.post.value!.images![0],
                        description:
                            chatController.post.value?.description as String,
                      ),
                    )
                  : const SizedBox.shrink()),
              Expanded(
                child: Stack(
                  children: [
                    // list view
                    Positioned.fill(
                      child: Obx(
                        () => Padding(
                          padding: const EdgeInsets.all(10.0).copyWith(
                            bottom: (chatController
                                    .replyMessageData.isReplied.value)
                                ? context.height * 0.15
                                : context.height * 0.1,
                          ),
                          child: Obx(() {
                            return ListView.separated(
                              controller: chatController.scrollController.value,
                              itemBuilder: (_, int index) {
                                Message message =
                                    chatController.messages[index];
                                String? senderId = message.senderId;
                                bool isSentByMe =
                                    senderId == chatController.senderId;
                                String? replyMessage, replyLabel;
                                if (message.repliedToMessageId != null) {
                                  replyMessage = chatController.getReplyMessage(
                                      message.repliedToMessageId);
                                  replyLabel = chatController.getReplyLabel(
                                      replyId:
                                          message.repliedToMessageId as int,
                                      isSentByMe: isSentByMe);
                                }
                                return MessageWidget(
                                  isSentByMe: isSentByMe,
                                  message: message,
                                  index: index,
                                  replyLabel: replyLabel,
                                  replyMessage: replyMessage,
                                );
                              },
                              itemCount: chatController.messages.length,
                              separatorBuilder: (_, __) {
                                return const SizedBox(
                                  height: 15,
                                );
                              },
                            );
                          }),
                        ),
                      ),
                    ),
                    ArrowScroll(scrollToEnd: chatController.scrollToEndAnimate),
                    Obx(
                      () => Padding(
                        padding: EdgeInsets.only(
                          left: chatController.copyChatData.tapX.value,
                          top: chatController.copyChatData.tapY.value -
                              56 -
                              MediaQuery.of(context).viewPadding.top,
                        ),
                        child: Visibility(
                          visible: chatController.isShownDialog.value,
                          child: ChatActionDialog(),
                        ),
                      ),
                    ),
                    BottomBarChat(),
                    Obx(
                      () => Visibility(
                        visible: chatController.openImageAttach.value,
                        child: const ImageAttachPopup(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
