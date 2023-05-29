import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';

class ForgetPassController extends GetxController {
  final TextEditingController email = TextEditingController();
  String? code;

  void toVerifyEmailScreen() {
    if (email.text.isEmpty) {
      EasyLoading.showToast("Please enter your email!".tr, toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }

    Get.toNamed(verifyEmailScreenRoute);
  }

  void toSuccessScreen() {
    if (code == null || code!.isEmpty) {
      EasyLoading.showToast("Please enter the code", toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }

    Get.offAllNamed(successScreenRoute,
        arguments: "Account Recovery Successfully");
  }
}
