import 'package:cliver_mobile/app/features/chat/chat_controller.dart';
import 'package:cliver_mobile/app/controller/user_controller.dart';
import 'package:cliver_mobile/app/core/utils/utils.dart';
import 'package:cliver_mobile/data/models/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../data/enums/screen.dart';
import '../../../core/values/app_colors.dart';
import '../../../routes/routes.dart';

class RoomItem extends StatelessWidget {
  RoomItem({
    Key? key,
    required this.isEditted,
    required this.index,
    required this.delete,
    required this.roomName,
    required this.isActive,
  }) : super(key: key);

  final int index;
  final bool isEditted;
  final void Function() delete;
  final String roomName;
  final bool isActive;
  final chatController = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    final room = chatController.rooms[index];
    final DateFormat formatter = DateFormat('jm');
    Message? lastMessage = chatController.lastMessages[room.id];
    return Slidable(
      enabled: !isEditted,
      startActionPane: const ActionPane(
        motion: ScrollMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            onPressed: null,
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.mail_outline,
            label: 'Unread',
          ),
        ],
      ),
      endActionPane: const ActionPane(
        extentRatio: 0.5,
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: null,
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
            icon: Icons.block,
            label: 'Block',
          ),
          SlidableAction(
            onPressed: null,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete_outline,
            label: 'Delete',
          ),
        ],
      ),
      child: (!isEditted)
          ? CupertinoContextMenu(
              actions: [
                CupertinoContextMenuAction(
                  trailingIcon: Icons.mail_outline,
                  onPressed: () {},
                  child: Text(
                    'Unread'.tr,
                    style: TextStyle(
                      fontSize: context.screenSize.height * 0.02,
                    ),
                  ),
                ),
                CupertinoContextMenuAction(
                  trailingIcon: Icons.block,
                  onPressed: () {},
                  child: Text(
                    'Block'.tr,
                    style: TextStyle(
                      fontSize: context.screenSize.height * 0.02,
                    ),
                  ),
                ),
                CupertinoContextMenuAction(
                  isDestructiveAction: true,
                  trailingIcon: Icons.delete_outline,
                  onPressed: () {
                    chatController.rooms.remove(chatController.rooms[index]);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Delete'.tr,
                    style: TextStyle(
                      fontSize: context.screenSize.height * 0.02,
                    ),
                  ),
                ),
              ],
              child: GestureDetector(
                onTap: () {
                  chatController.rooms[index].isReaded = true;
                  String? partnerId, partnerAvt;
                  for (var i = 0; i < room.members!.length; i++) {
                    if (room.members![i].id !=
                        Get.find<UserController>().currentUser.value.id) {
                      partnerId = room.members![i].id;
                      partnerAvt = room.members![i].avatar;
                    }
                  }
                  chatController.currentScreen.value = Screen.chatScreen;
                  Get.toNamed(
                    chatScreenRoute,
                    arguments: [partnerId, roomName, room.id, null, partnerAvt],
                  );
                },
                child: Container(
                  color: AppColors.primaryWhite,
                  height: context.screenSize.height * 0.125,
                  child: Row(
                    children: [
                      Visibility(
                        visible: isEditted,
                        child: Transform.scale(
                          scale: 1.4,
                          child: Checkbox(
                            value: chatController.listCheckBoxValue[index],
                            onChanged: (value) {
                              chatController.listCheckBoxValue[index] = value!;
                            },
                            shape: const CircleBorder(),
                            fillColor:
                                (!chatController.listCheckBoxValue[index])
                                    ? MaterialStateProperty.all(
                                        AppColors.lightGreyColor)
                                    : MaterialStateProperty.all(
                                        AppColors.primaryColor),
                          ),
                        ),
                      ),
                      SizedBox(width: context.screenSize.width * 0.02),
                      Stack(
                        children: [
                          SizedBox(
                            height: context.screenSize.height * 0.07,
                            width: context.screenSize.height * 0.07,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(90),
                              child: Image.network(
                                fit: BoxFit.cover,
                                Get.find<UserController>()
                                        .currentUser
                                        .value
                                        .avatar ??
                                    "https://d2v9ipibika81v.cloudfront.net/uploads/sites/210/Profile-Icon.png",
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: context.screenSize.height * 0.02,
                              width: context.screenSize.height * 0.02,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(90),
                                color: (isActive) ? Colors.green : Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: context.screenSize.width * 0.04),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    roomName,
                                    maxLines: 2,
                                  ),
                                ),
                                Text(
                                  formatter.format(
                                    lastMessage?.createdAt?.toLocal()
                                        as DateTime,
                                  ),
                                  style: TextStyle(
                                    fontSize: context.screenSize.height * 0.016,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    lastMessage?.content as String,
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: (room.isReaded ?? false)
                                          ? Colors.grey
                                          : Colors.black,
                                      fontWeight: (room.isReaded ?? false)
                                          ? null
                                          : FontWeight.bold,
                                      fontSize:
                                          context.screenSize.height * 0.016,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                (FormatHelper()
                                            .toLocal(lastMessage?.createdAt)
                                            ?.day !=
                                        DateTime.now().day)
                                    ? Text(
                                        FormatHelper().dateFormat(lastMessage
                                                ?.createdAt
                                                ?.toLocal()) ??
                                            "",
                                      )
                                    : const SizedBox.shrink(),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Container(
              color: AppColors.primaryWhite,
              height: context.screenSize.height * 0.125,
              child: Row(
                children: [
                  Visibility(
                    visible: isEditted,
                    child: Transform.scale(
                      scale: 1.4,
                      child: Obx(
                        () => Checkbox(
                          value: chatController.listCheckBoxValue[index],
                          onChanged: (value) {
                            chatController.listCheckBoxValue[index] = value!;
                          },
                          shape: const CircleBorder(),
                          fillColor: (!chatController.listCheckBoxValue[index])
                              ? MaterialStateProperty.all(
                                  AppColors.lightGreyColor)
                              : MaterialStateProperty.all(
                                  AppColors.primaryColor),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: context.screenSize.width * 0.02,
                  ),
                  Stack(
                    children: [
                      SizedBox(
                        height: context.screenSize.height * 0.07,
                        width: context.screenSize.height * 0.07,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(90),
                          child: Image.network(
                            fit: BoxFit.cover,
                            Get.find<UserController>()
                                    .currentUser
                                    .value
                                    .avatar ??
                                "https://d2v9ipibika81v.cloudfront.net/uploads/sites/210/Profile-Icon.png",
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: context.screenSize.height * 0.02,
                          width: context.screenSize.height * 0.02,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90),
                            color: (isActive) ? Colors.green : Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: context.screenSize.width * 0.04,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                roomName,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: context.screenSize.height * 0.018,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.blackColor,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Text(
                              formatter.format(
                                lastMessage?.createdAt?.toLocal() as DateTime,
                              ),
                              style: TextStyle(
                                fontSize: context.screenSize.height * 0.016,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                lastMessage?.content as String,
                                maxLines: 2,
                                style: TextStyle(
                                  color: (room.isReaded ?? false)
                                      ? Colors.grey
                                      : Colors.black,
                                  fontWeight: (room.isReaded ?? false)
                                      ? null
                                      : FontWeight.bold,
                                  fontSize: context.screenSize.height * 0.016,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            (FormatHelper()
                                        .toLocal(lastMessage?.createdAt)
                                        ?.day !=
                                    DateTime.now().day)
                                ? Text(
                                    FormatHelper().dateFormat(lastMessage
                                            ?.createdAt
                                            ?.toLocal()) ??
                                        "",
                                  )
                                : const SizedBox.shrink(),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
