import 'dart:developer';
import 'package:cliver_mobile/app/controller/user_controller.dart';
import 'package:cliver_mobile/app/core/utils/utils.dart';
import 'package:cliver_mobile/app/features/chat/models/copy_chat_data.dart';
import 'package:cliver_mobile/app/features/chat/models/reply_message_data.dart';
import 'package:cliver_mobile/data/enums/custom_order_status.dart';
import 'package:cliver_mobile/data/models/model.dart';
import 'package:cliver_mobile/data/services/OrderService.dart';
import 'package:cliver_mobile/data/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../data/enums/screen.dart';
import '../../routes/routes.dart';

class ChatController extends GetxController {
  RxList<Room> rooms = <Room>[].obs;
  RxList<Message> messages = <Message>[].obs;
  var room = Rxn<Room>();
  final String? senderId = Get.find<UserController>().currentUser.value.id;
  Rxn<Post> post = Rxn<Post>();

  // signalr properties
  Rx<Screen> currentScreen = Screen.bottomBarScreen.obs;

  // ui properties in room_screen
  var listCheckBoxValue = RxList<bool>();
  RxInt selectedFilter = 0.obs;
  RxBool openImageAttach = false.obs, isEditted = false.obs;
  RxMap<int, Message> lastMessages = <int, Message>{}.obs;

  // ui properties in chat_screen
  Rx<int?> roomId = (-1).obs, hideTimeIndex = (-1).obs;
  RxString partnerId = "".obs;
  RxString partnerName = "".obs;
  ReplyMessageData replyMessageData = ReplyMessageData.instance;

  //ui method in room_screen
  void tapOnRoomScreen() {
    isEditted.value = false;
    clearCheckBox();
  }

  void editRooms() {
    if (!isEditted.value) {
    } else {
      clearCheckBox();
    }
    isEditted.value = !isEditted.value;
  }

  void clearCheckBox() {
    for (int i = 0; i < listCheckBoxValue.length; i++) {
      listCheckBoxValue[i] = false;
    }
  }

  void markAll() {
    for (int i = 0; i < rooms.length; i++) {
      rooms[i].isReaded = true;
    }
  }

  void delete() {
    if (isOneBoxChecked()) {
      for (int i = listCheckBoxValue.length - 1; i > 0; i--) {
        if (listCheckBoxValue[i]) {
          rooms.removeAt(i);
          listCheckBoxValue.removeLast();
        }
      }
      clearCheckBox();
    }
  }

  void markRead() {
    if (isOneBoxChecked()) {
      for (int i = 0; i < rooms.length; i++) {
        if (listCheckBoxValue[i]) {
          rooms[i].isReaded = true;
        }
      }
      clearCheckBox();
      update();
    }
  }

  List getRoomName(int index) {
    for (var i = 0; i < rooms[index].members!.length; i++) {
      if (rooms[index].members![i].id != senderId) {
        return [
          rooms[index].members![i].name as String,
          rooms[index].members![i].isActive!
        ];
      }
    }
    return [];
  }

  // ui method in chat_screen

  void getListLastMessage() {
    for (var i = 0; i < rooms.length; i++) {
      lastMessages[rooms[i].id as int] = rooms[i].lastMessage!;
    }
  }

  Future<void> initChatScreenData(String username) async {
    partnerId.value = Get.arguments[0];
    partnerName.value = username;
    roomId.value = Get.arguments[2];
    post.value = Get.arguments[3];
    if (roomId.value == null) {
    } else {
      await getRoom(roomId: roomId.value as int);
    }
    EasyLoading.dismiss();
    copyChatData.tapX.value = tapPosition.dx;
    copyChatData.tapY.value = tapPosition.dy;
    isShownDialog.value = false;
    if (copyChatData.tapY.value >= Get.height * 0.75) {
      copyChatData.tapY.value = Get.height * 0.75;
    }
  }

  void showCopyDialog({required Message message, required bool isSentByMe}) {
    copyChatData.message.value = message;
    isShownDialog.value = true;
    copyChatData.isSentByMe.value = isSentByMe;
    if (isSentByMe) {
      if (copyChatData.tapX.value >= Get.width * 0.3) {
        copyChatData.tapX.value -= Get.width * 0.3;
      } else {
        copyChatData.tapX.value = Get.width * 0.3;
      }
    }
  }

  void copyChat(String message) {
    isShownDialog.value = false;
    Clipboard.setData(ClipboardData(text: message));
    Get.showSnackbar(const GetSnackBar(message: "Text copied"));
  }

  String getReplyLabel({required int replyId, required bool isSentByMe}) {
    String result = "";
    if (isSentByMe) {
      result += "You".tr;
    } else {
      result += partnerName.value;
    }
    result += " ${'has replied to'.tr} ";
    for (var i = 0; i < messages.length; i++) {
      if (replyId == messages[i].id) {
        if (isSentByMe) {
          if (messages[i].senderId == senderId) {
            result += "yourself".tr;
          } else {
            result += partnerName.value;
          }
        } else {
          if (messages[i].senderId == senderId) {
            result += "your message".tr;
          } else {
            result += "their own message".tr;
          }
        }
      }
    }
    return result;
  }

  String? getReplyMessage(int? replyId) {
    if (replyId == null) return null;
    for (var i = 0; i < messages.length; i++) {
      if (messages[i].id == replyId) {
        return messages[i].content;
      }
    }
    return null;
  }

  void reply({required int messageId, required String messageContent}) {
    replyMessageData.replyMessageId.value = messageId;
    replyMessageData.replyMessage.value = messageContent;
    replyMessageData.isReplied.value = true;
    isShownDialog.value = false;
  }

  void tapOnChatScreen() {
    Get.closeCurrentSnackbar();
    FocusManager.instance.primaryFocus?.unfocus();
    isShownDialog.value = false;
    openImageAttach.value = false;
    replyMessageData.isReplied.value = false;
  }

  Future<void> scrollToEndAnimate() async {
    if (scrollController.value.hasClients) {
      await scrollController.value.animateTo(
        scrollController.value.position.maxScrollExtent,
        duration: const Duration(milliseconds: 700),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  void scrollToEnd() {
    scrollController.value
        .jumpTo(scrollController.value.position.maxScrollExtent);
  }

  void backToRoomScreen() {
    Get.back();
    tapOnChatScreen();
    post.value = null;
    currentScreen.value = Screen.roomScreen;
    messages.clear();
  }

  void sendMessage() {
    if (messageInput.value.text.isNotEmpty) {
      int? repliedToMessageId;
      (replyMessageData.isReplied.value)
      message.createdAt = DateTime.now();
      if (repliedToMessageId == null) {
        for (var i = 0; i < messages.length; i++) {
          if (messages[i].id == repliedToMessageId) {
            message.replyMessage = messages[i].content;
            break;
          }
        }
      }
      messageInput.value.clear();
      FocusManager.instance.primaryFocus!.unfocus();
      tapOnChatScreen();
      message.isLoading.value = true;
      messages.add(message);
      scrollToEnd();
      SignalRService.instance.sendMessage(
        CreateMessage(
          content: message.content,
          senderId: senderId,
          receiverId: partnerId.value,
          roomId: roomId.value,
          postId: post.value?.id,
          repliedToMessageId: repliedToMessageId,
        ),
      );
      countTimeOutMessage(messages.length - 1);
    }
  }

  Future<void> countTimeOutMessage(int index) async {
    await Future.delayed(const Duration(seconds: 10));
    if (messages[index].id == null) {
      messages[index].isError.value = true;
      messages[index].isLoading.value = false;
    }
    scrollToEnd();
  Future<void> getMessages({required String partnerId}) async {
    EasyLoading.show();
    try {
      ChatService.ins.getAllMessages(partnerId: partnerId)?.then(
        (res) {
          if (res.isOk) {
            var listMessage =
                res.body["data"].map((json) => Message.fromJson(json));
            messages.value = List.from(listMessage);
            log("get messages success: ${res.body['message']}");
            SchedulerBinding.instance.addPostFrameCallback(
              (_) => scrollToEnd(),
            );
          } else {
            Get.defaultDialog(
              title: "Error".tr,
              content: Text(res.error),
            );
          }
        },
      );
    } catch (e) {
      log("get messages failed: $e");
      EasyLoading.dismiss();
    }
    EasyLoading.dismiss();
  }
}
