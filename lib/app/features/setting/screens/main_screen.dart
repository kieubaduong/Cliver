import 'dart:io';
import '../../../../data/services/services.dart';
import '../../../core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../controller/controller.dart';
import '../../../routes/routes.dart';
import '../../features.dart';

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  final UserController _userController = Get.find();
  final BottomBarController _bottomController = Get.find();

  var iconSize = 0.0;

  final ImagePicker imgPicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    iconSize = context.screenSize.height * 0.04;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              //avatar
              Center(
                child: GestureDetector(
                  onTap: () {
                    pickAvatar();
                  },
                  child: Center(
                    child: CircleAvatar(
                      radius: context.screenSize.height * 0.065,
                      backgroundImage: NetworkImage(
                        _userController.currentUser.value.avatar ??
                            "https://d2v9ipibika81v.cloudfront.net/uploads/sites/210/Profile-Icon.png",
                      ),
                    ),
                  ),
                ),
              ),
              //name
              Center(
                child: Obx(() => Text(
                      _userController.currentUser.value.name ?? "",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    )),
              ),
              //switch to seller
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                activeColor: AppColors.primaryColor,
                title: Text(
                  _bottomController.isSeller.value
                      ? "switch_buyer".tr
                      : "switch_seller".tr,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value: _bottomController.isSeller.value,
                onChanged: (val) {
                  if (_userController.currentUser.value.isVerified == false) {
                    Get.to(() => const VerifySellerScreen());
                    return;
                  } else {
                    _bottomController.changeToSeller();
                  }
                },
              ),
              Expanded(
                child: ListView(
                  children: [
                    _bottomController.isSeller.value
                        ? buildSellerCliver(context)
                        : buildBuyerCliver(context),
                    _buildGeneral(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildSellerCliver(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "My Cliver".tr,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const Divider(),
        ListTile(
          leading: Icon(
            Icons.attach_money_outlined,
            color: AppColors.primaryColor,
            size: iconSize,
          ),
          title: Text(
            "Earnings".tr,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_right,
            color: Color(0xff9395A4),
          ),
          onTap: () {
            Get.toNamed(earningScreenRoute);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.request_page_outlined,
            color: AppColors.primaryColor,
            size: iconSize,
          ),
          title: Text(
            "Buyer requests".tr,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_right,
            color: Color(0xff9395A4),
          ),
          onTap: () => Get.to(() => BuyerRequestScreen()),
        ),
        ListTile(
          leading: Icon(
            Icons.person_outline,
            color: AppColors.primaryColor,
            size: iconSize,
          ),
          title: Text(
            "My profile".tr,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_right,
            color: Color(0xff9395A4),
          ),
          onTap: () {
            Get.toNamed(sellerProfileScreenRoute,
                arguments: _userController.currentUser.value.id);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.attach_money_outlined,
            color: AppColors.primaryColor,
            size: iconSize,
          ),
          title: Text(
            "In-app credit".tr,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_right,
            color: Color(0xff9395A4),
          ),
          onTap: () => Get.to(() => const InAppCreditScreen()),
        ),
      ],
    );
  }

  buildBuyerCliver(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "My Cliver".tr,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const Divider(),
        ListTile(
          leading: Icon(
            Icons.favorite_border_outlined,
            color: AppColors.primaryColor,
            size: iconSize,
          ),
          title: Text(
            "Saved".tr,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_right,
            color: Color(0xff9395A4),
          ),
          onTap: () => Get.toNamed(saveListRoute),
        ),
        ListTile(
          leading: Icon(
            Icons.request_page_outlined,
            color: AppColors.primaryColor,
            size: iconSize,
          ),
          title: Text(
            "Manage requests".tr,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_right,
            color: Color(0xff9395A4),
          ),
          onTap: () => Get.to(() => MyRequestScreen()),
        ),
        ListTile(
          leading: Icon(
            Icons.person_outline,
            color: AppColors.primaryColor,
            size: iconSize,
          ),
          title: Text(
            "My profile".tr,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_right,
            color: Color(0xff9395A4),
          ),
          onTap: () => Get.toNamed(buyerProfileScreenRoute,
              arguments: _userController.currentUser.value.id),
        ),
        ListTile(
          leading: Icon(
            Icons.attach_money_outlined,
            color: AppColors.primaryColor,
            size: iconSize,
          ),
          title: Text(
            "In-app credit".tr,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_right,
            color: Color(0xff9395A4),
          ),
          onTap: () => Get.to(() => const InAppCreditScreen()),
        ),
        _userController.currentUser.value.isVerified == false
            ? ListTile(
                leading: Icon(
                  Icons.sell_outlined,
                  color: AppColors.primaryColor,
                  size: iconSize,
                ),
                title: const Text(
                  "Become a Seller",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Get.to(() => const VerifySellerScreen());
                },
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  _buildGeneral(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "General".tr,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const Divider(),
        ListTile(
          leading: Icon(
            Icons.settings_outlined,
            color: AppColors.primaryColor,
            size: iconSize,
          ),
          title: Text(
            "Preferences".tr,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_right,
            color: Color(0xff9395A4),
          ),
          onTap: () {
            Get.toNamed(preferencesSettingScreenRoute);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.support_outlined,
            color: AppColors.primaryColor,
            size: iconSize,
          ),
          title: Text(
            "Customer reviews".tr,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_right,
            color: Color(0xff9395A4),
          ),
          onTap: () {
            Get.toNamed(customerReviewScreenRoute);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.logout_outlined,
            color: AppColors.primaryColor,
            size: iconSize,
          ),
          title: Text(
            "Logout".tr,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () async {
            Get.delete<ChatController>();
            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.remove("user_token");
            Get.offAllNamed(loginScreenRoute);
          },
        ),
      ],
    );
  }

  void pickAvatar() async {
    final XFile? selected =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selected != null) {
      var avatar = File(selected.path);
      var res = await StorageService.ins.uploadAvatar(avatar);
      if (res != null) {
        EasyLoading.show();
        var r = await UserService.ins.updateUserAvatar(avt: res);
        EasyLoading.dismiss();
        if (r.isOk) {
          setState(() {
            _userController.currentUser.value.avatar = res;
          });
        }
      }
    }
  }
}
