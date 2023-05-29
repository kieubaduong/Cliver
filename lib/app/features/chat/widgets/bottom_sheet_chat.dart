import '../../../core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/models/model.dart';
import '../chat_controller.dart';

class BottomSheetChat extends StatefulWidget {
  const BottomSheetChat({
    Key? key,
    required this.scrollController,
    required this.listChatFilter,
    required this.listLabel,
  }) : super(key: key);
  final ScrollController scrollController;
  final List<ChatFilter> listChatFilter;
  final List<LabelFilter> listLabel;

  @override
  State<BottomSheetChat> createState() => _BottomSheetChatState();
}

class _BottomSheetChatState extends State<BottomSheetChat> {
  final chatController = Get.find<ChatController>();
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) =>
          SingleChildScrollView(
        controller: widget.scrollController,
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 4,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'filter'.tr,
                style: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: context.screenSize.height * 0.03,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Icon(
                          widget.listChatFilter[index].icon,
                          color: Colors.grey,
                          size: context.screenSize.height * 0.05,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                chatController.selectedFilter.value = index;
                                Navigator.of(context).pop();
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: const BorderSide(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    widget.listChatFilter[index].text.tr,
                                    style: TextStyle(
                                      fontSize:
                                          context.screenSize.height * 0.02,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.blackColor,
                                    ),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  (chatController.selectedFilter == index)
                                      ? Icon(
                                          Icons.check,
                                          size:
                                              context.screenSize.height * 0.03,
                                          color: AppColors.primaryColor,
                                        )
                                      : const SizedBox(),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
                separatorBuilder: (context, _) => const SizedBox(),
                itemCount: widget.listChatFilter.length,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
