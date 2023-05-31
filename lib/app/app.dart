import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'controller/user_controller.dart';
import 'core/core.dart';
import 'core/utils/localization_service.dart';
import 'features/features.dart';
import 'routes/pages.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UserController _userController = Get.find();
  final SettingController _settingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
      locale: _settingController.isVN.value
          ? LocalizationService.locales[1]
          : LocalizationService.locales[0],
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
      theme: AppColors().lightTheme,
      home: SafeArea(
        child: _userController.isFirstTime
            ? const OnBoarding()
            : _userController.userToken.isEmpty
                ? const LoginScreen() // ? const LoginScreen()
                : const MyBottomBar(),
      ),
      builder: EasyLoading.init(),
      darkTheme: AppColors().darkTheme,
      // initialRoute: vnpayPaymentRoute,
    );
  }
}
