import 'package:cliver_mobile/app/features/chat/chat_controller.dart';
import 'package:cliver_mobile/app/core/utils/utils.dart';
import 'package:cliver_mobile/app/features/chat/widgets/bottom_sheet_chat.dart';
import 'package:cliver_mobile/app/features/chat/widgets/room_item.dart';
import 'package:cliver_mobile/data/models/chat_filter.dart';
import 'package:cliver_mobile/data/models/label_filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/app_colors.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({Key? key}) : super(key: key);

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  final chatController = Get.find<ChatController>();
  final _listChatFilter = ChatFilter.getListChatFilter();
  final _listLabel = LabelFilter.getListLabel();

  @override
  void initState() {
    chatController.getAllRoom();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.backgroundColor,
          title: Row(
            children: [
              GestureDetector(
                onTap: () => chatController.editRooms(),
                child: Obx(
                  () => Text(
                    (!chatController.isEditted.value) ? 'Edit'.tr : 'cancel'.tr,
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: context.screenSize.height * 0.03,
                    ),
                  ),
                ),
              ),
              const Expanded(child: SizedBox.shrink()),
              Text(
                'Inbox'.tr,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: context.screenSize.height * 0.035,
                ),
              ),
              const Expanded(child: SizedBox()),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    isDismissible: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    builder: (context) => DraggableScrollableSheet(
                      initialChildSize: 0.4,
                      maxChildSize: 0.5,
                      expand: false,
                      builder: (context, scrollController) {
                        return BottomSheetChat(
                          scrollController: scrollController,
                          listChatFilter: _listChatFilter,
                          listLabel: _listLabel,
                        );
                      },
                    ),
                  );
                },
                child: Icon(
                  Icons.tune,
                  color: Colors.black,
                  size: context.screenSize.height * 0.05,
                ),
              ),
            ],
          ),
        ),
        body: GestureDetector(
          onTap: () => chatController.tapOnRoomScreen(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Obx(() {
              if (chatController.lastMessages.isNotEmpty) {
                return ListView.separated(
                  itemBuilder: ((_, index) {
                    List turpleRoomName = chatController.getRoomName(index);
                    String roomName = turpleRoomName[0];
                    bool isActive = turpleRoomName[1];
                    return Obx(
                      () => RoomItem(
                        delete: chatController.delete,
                        index: index,
                        isEditted: chatController.isEditted.value,
                        roomName: roomName,
                        isActive: isActive,
                      ),
                    );
                  }),
                  separatorBuilder: (_, __) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: chatController.rooms.length,
                );
              }
              return const SizedBox.shrink();
            }),
          ),
        ),
        bottomNavigationBar: Obx(() => Visibility(
              visible: chatController.isEditted.value,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => chatController.delete(),
                      child: SizedBox(
                        width: context.width * 0.25,
                        child: Text(
                          'Delete'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: (chatController.isOneBoxChecked())
                                ? AppColors.blackColor
                                : AppColors.lightGreyColor,
                            fontSize: context.height * 0.025,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => chatController.markAll(),
                      child: SizedBox(
                        width: context.width * 0.25,
                        child: Text(
                          'Mark all'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: context.screenSize.height * 0.025,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => chatController.markRead(),
                      child: SizedBox(
                        width: context.width * 0.25,
                        child: Text(
                          'Mark read'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: (chatController.isOneBoxChecked())
                                ? AppColors.blackColor
                                : AppColors.lightGreyColor,
                            fontSize: context.screenSize.height * 0.025,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
