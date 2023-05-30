import 'dart:developer';
import '../../core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../data/enums/enums.dart';
import '../../../data/models/model.dart';
import '../../../data/services/services.dart';
import '../../controller/controller.dart';
import '../../routes/routes.dart';
import '../features.dart';

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
  RxBool hideTime = true.obs,
      hideArrow = true.obs,
      isDisconnected = true.obs,
      isShownDialog = false.obs;
  final messageInput = TextEditingController().obs;
  final scrollController = ScrollController().obs;
  CopyChatData copyChatData = CopyChatData.instance;
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

  bool isOneBoxChecked() {
    for (int i = 0; i < listCheckBoxValue.length; i++) {
      if (listCheckBoxValue[i]) {
        return true;
      }
    }
    return false;
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
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels ==
          scrollController.value.position.maxScrollExtent) {
        hideArrow.value = false;
      } else {
        hideArrow.value = true;
      }
    });
  }

  void showTimeSent(int index) {
    if (hideTimeIndex.value == index) {
      hideTime.value = !hideTime.value;
    } else {
      hideTime.value = false;
    }

    hideTimeIndex.value = index;
    if (index == messages.length - 1) {
      scrollToEnd();
    }
  }

  void getCopyDialogPosition(TapDownDetails details) {
    Offset tapPosition = details.globalPosition;
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
          ? repliedToMessageId = replyMessageData.replyMessageId.value
          : repliedToMessageId = null;
      Message message = Message();
      message.content = messageInput.value.text;
      message.senderId = senderId;
      message.repliedToMessageId = repliedToMessageId;
      message.roomId = roomId.value;
      message.relatedPost = post.value;
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
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => scrollToEnd(),
    );
  }

  // custom order method
  Future<bool> changeCustomOrderStatus(
      {required int customOrderId, required CustomOrderStatus status}) async {
    EasyLoading.show();
    var res = await OrderService.ins.changeCustomOrderStatus(
        customOrderId: customOrderId,
        customOrderStatus: status.toString().substring(18));
    EasyLoading.dismiss();
    if (res!.isOk) {
      return true;
    } else {
      await Get.defaultDialog(
        title: "Error".tr,
        content: Text(res.error),
      );
      return false;
    }
  }

  Future<void> viewThisOffer({required int customOrderId}) async {
    var res =
        await OrderService.ins.getCustomOrder(customOrderId: customOrderId);
    if (res!.isOk) {
      Get.toNamed(buyerOrderDetailScreenRoute, arguments: [customOrderId]);
    } else {
      await Get.defaultDialog(
        title: "Error".tr,
        content: Text(res.error),
      );
    }
  }

  // api room_screen
  Future<void> getAllRoom() async {
    rooms.clear();
    EasyLoading.show();
    try {
      ChatService.ins.getAllRooms()?.then(
        (res) {
          if (res.isOk) {
            var listRoom = res.body['data'].map((json) => Room.fromJson(json));
            rooms.value = List.from(listRoom);
            listCheckBoxValue.value = List<bool>.filled(rooms.length, true);
            getListLastMessage();
            log("get rooms success");
          } else {
            Get.defaultDialog(
              title: "Error",
              content: Text(res.error),
            );
          }
        },
      );
    } catch (e) {
      log("get rooms failed: $e");
      EasyLoading.dismiss();
    }
    EasyLoading.dismiss();
  }

  // api chat_screen
  Future<void> getRoom({required int roomId}) async {
    EasyLoading.show();
    try {
      var res = await ChatService.ins.getRoom(roomId: roomId)!;
      EasyLoading.dismiss();
      if (res.isOk) {
        room.value = Room.fromJson(res.body['data'] as Map<String, dynamic>);
        log("get room success: ${res.body['message']}");
        messages.value = room.value!.messages!;
        SchedulerBinding.instance.addPostFrameCallback(
          (_) => scrollToEnd(),
        );
      } else {
        Get.defaultDialog(
          title: "Error".tr,
          content: Text(res.error),
        );
      }
    } catch (e) {
      log("get room failed: $e");
      Get.defaultDialog(
        title: "Error".tr,
        content: Text("Something went wrong".tr),
      );
      EasyLoading.dismiss();
    }
    // EasyLoading.dismiss();
  }

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
