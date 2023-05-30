import 'dart:math' as math;
import '../../../core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../features.dart';

class ArrowScroll extends StatelessWidget {
  final Function scrollToEnd;
  final chatController = Get.find<ChatController>();

  ArrowScroll({Key? key, required this.scrollToEnd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: chatController.hideArrow.value,
        child: Positioned.fill(
          bottom: (chatController.replyMessageData.isReplied.value)
              ? context.height * 0.15
              : context.height * 0.1,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () => scrollToEnd(),
              child: Container(
                height: context.screenSize.width * 0.1,
                width: context.screenSize.width * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  color: AppColors.lightGreenColor.withOpacity(0.2),
                ),
                child: Transform.rotate(
                  angle: -90 * math.pi / 180,
                  child: Icon(
                    Icons.arrow_back,
                    size: context.screenSize.width * 0.05,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
