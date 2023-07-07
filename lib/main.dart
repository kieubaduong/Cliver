import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/app.dart';
import 'app/controller/user_controller.dart';
import 'app/core/core.dart';
import 'app/features/setting/setting_controller.dart';
import 'data/models/model.dart';
import 'data/services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  FlutterDownloader.registerCallback(DownloadClass.callback);
  await initData();
  configLoadingBar();
  runApp(const MyApp());

  // runApp(
  //   DevicePreview(
  //     enabled: false,
  //     builder: (context) => const MyApp(),
  //   ),
  // );
}

initData() async {
  await Firebase.initializeApp();

  var pref = await SharedPreferences.getInstance();
  final userController = Get.put(UserController());
  final settingController = Get.put(SettingController());

  userController.isFirstTime = pref.getBool("isFirstTime") ?? true;
  userController.userToken = pref.getString("user_token") ?? "";
  settingController.isDarkMode.value = pref.getBool("isDark") ?? false;
  settingController.isVN.value = pref.getBool("isVN") ?? false;

  if (settingController.isDarkMode.value) {
    AppColors().changeColor(true);
    Get.changeTheme(AppColors().darkTheme);
  } else {
    AppColors().changeColor(false);
    Get.changeTheme(AppColors().lightTheme);
  }

  if (userController.userToken != "") {
    var res =
        await AuthService.instance.getUserData(token: userController.userToken);

    if (res.statusCode == 200) {
      userController.currentUser.value = User.fromJson(res.body['data']);
      log("get user infomation success");
      log("current user: ${userController.currentUser.value.name}");
    } else {
      log("get user infomation failed");
    }
    res = await AuthService.instance.getWallet(token: userController.userToken);
    if (res.isOk) {
      Wallet wallet = Wallet.fromJson(res.body["data"]["wallet"]);
      userController.currentUser.value.wallet = wallet;
      log("get user wallet success");
    } else {
      log("get user wallet failed");
    }
  }
}
