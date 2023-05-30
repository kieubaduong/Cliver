import 'package:get/get.dart';
import '../features.dart';

class BottomBarController extends GetxController {
  var currentIndex = 0.obs;
  var isSeller = false.obs;
  // show red dot message
  RxBool isHaveMessage = false.obs;
  RxDouble paddingLeft = (23 + 130 + 50 + ((Get.width - 326) / 5) * 2).obs;

  var pages = [
    const BuyerHomeScreen(),
    const RoomScreen(),
    const BuyerOrderScreen(),
    const ProfileSettingScreen(),
  ].obs;

  void changeToSeller() {
    if (isSeller.value) {
      pages.value = [
        const BuyerHomeScreen(),
        const RoomScreen(),
        const BuyerOrderScreen(),
        const ProfileSettingScreen(),
      ];
    } else {
      pages.value = [
        const SellerHome(),
        const RoomScreen(),
        const SellerPostHomeScreen(),
        const ProfileSettingScreen(),
      ];
    }
    isSeller.value = !isSeller.value;
  }

  void changeLeftPadding() {
    if (currentIndex.value < 1) {
      paddingLeft = (23 + 130 + 50 + ((Get.width - 326) / 5) * 2).obs;
    } else {
      paddingLeft = (23 + 50 + 50 + ((Get.width - 326) / 5) * 2).obs;
    }
  }
}
