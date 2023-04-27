import 'package:cliver_mobile/app/core/utils/utils.dart';
import 'package:cliver_mobile/app/core/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../setting_controller.dart';

class PreferencesSettingScreen extends StatefulWidget {
  const PreferencesSettingScreen({Key? key}) : super(key: key);

  @override
  State<PreferencesSettingScreen> createState() =>
      _PreferencesSettingScreenState();
}

class _PreferencesSettingScreenState extends State<PreferencesSettingScreen> {
  late final SharedPreferences pref;
  final SettingController _controller = Get.find();

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Preferences".tr,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Obx(
                  () => SwitchListTile(
                    title: Text(
                      "Dark Mode".tr,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    value: _controller.isDarkMode.value,
                    onChanged: (value) => changeTheme(),
                    secondary: Icon(
                      Icons.nightlight_sharp,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.language_outlined,
                    color: AppColors.primaryColor,
                  ),
                  title: Text(
                    "Language".tr,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  onTap: () => showLanguageDialog(context),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void initData() async {
    pref = await SharedPreferences.getInstance();
  }

  changeTheme() {
    if (!_controller.isDarkMode.value) {
      AppColors().changeColor(true);
      Get.changeTheme(AppColors().darkTheme);
      pref.setBool("isDark", true);
      _controller.isDarkMode.value = true;
    } else {
      AppColors().changeColor(false);
      Get.changeTheme(AppColors().lightTheme);
      pref.setBool("isDark", false);
      _controller.isDarkMode.value = false;
    }
  }
}
