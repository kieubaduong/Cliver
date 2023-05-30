import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/enums/screen.dart';
import '../../../data/services/SignalRService.dart';
import '../../common_widgets/custom_bottom_navigation_bar.dart';
import '../../core/core.dart';
import '../features.dart';

class MyBottomBar extends StatefulWidget {
  const MyBottomBar({Key? key}) : super(key: key);

  @override
  State<MyBottomBar> createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  final _bottomBarController = Get.put(BottomBarController());

  final _chatController = Get.put(ChatController());

  @override
  void initState() {
    super.initState();

    SignalRService.instance.startConnection();
  }

  @override
  Widget build(BuildContext context) {
    CustomSize().init(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Obx(
        () =>
            _bottomBarController.pages[_bottomBarController.currentIndex.value],
      ),
      bottomNavigationBar: buildBottomNavigation(),
    );
  }

  Widget buildBottomNavigation() {
    return Obx(
      () => Stack(
        children: [
          BottomNavigationBarCustom(
            showElevation: false,
            itemCornerRadius: 15,
            items: <BottomNavigationBarCustomItem>[
              BottomNavigationBarCustomItem(
                title: 'Home'.tr,
                icon: const Icon(Icons.home_filled),
                inactiveColor: AppColors.secondaryColor,
                activeColor: AppColors.selectedNavBarColor,
                childColor: AppColors.itemChildColor,
              ),
              BottomNavigationBarCustomItem(
                title: 'Chat'.tr,
                icon: const Icon(Icons.message),
                inactiveColor: AppColors.secondaryColor,
                activeColor: AppColors.selectedNavBarColor,
                childColor: AppColors.itemChildColor,
              ),
              BottomNavigationBarCustomItem(
                title: 'Order'.tr,
                icon: const Icon(Icons.receipt_long),
                inactiveColor: AppColors.secondaryColor,
                activeColor: AppColors.selectedNavBarColor,
                childColor: AppColors.itemChildColor,
              ),
              BottomNavigationBarCustomItem(
                title: 'Profile'.tr,
                icon: const Icon(Icons.person),
                inactiveColor: AppColors.secondaryColor,
                activeColor: AppColors.selectedNavBarColor,
                childColor: AppColors.itemChildColor,
              ),
            ],
            onItemSelected: (index) {
              if (index == 1) {
                _chatController.currentScreen.value = Screen.roomScreen;
                _bottomBarController.isHaveMessage.value = false;
              } else {
                _chatController.currentScreen.value = Screen.bottomBarScreen;
              }
              _bottomBarController.currentIndex.value = index;
              _bottomBarController.changeLeftPadding();
            },
            selectedIndex: _bottomBarController.currentIndex.value,
          ),
          Visibility(
            visible: _bottomBarController.isHaveMessage.value,
            child: Positioned(
              left: _bottomBarController.paddingLeft.value,
              top: 20,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
