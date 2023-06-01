import 'package:cliver_mobile/app/controller/user_controller.dart';
import 'package:cliver_mobile/app/core/utils/utils.dart';
import 'package:cliver_mobile/app/routes/routes.dart';
import 'package:cliver_mobile/data/models/model.dart';
import 'package:cliver_mobile/data/services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupController extends GetxController {
  final TextEditingController fullName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final TextEditingController repass = TextEditingController();
  String? code;

  toEmailScreen() async {
    if (isValidData()) {
      EasyLoading.show();
      var res = await AuthService.instance.signup(
        user: User(name: fullName.text, email: email.text, password: pass.text),
      );
      EasyLoading.dismiss();
      if (res.isOk) {
        Get.toNamed(verifyEmailSignupScreenRoute);
      } else {
        Get.defaultDialog(
          title: "Error",
          content: Text(res.error),
        );
      }
    }
  }

  bool isValidData() {
    if (fullName.text.isEmpty ||
        email.text.isEmpty ||
        pass.text.isEmpty ||
        repass.text.isEmpty) {
      EasyLoading.showToast("Please enter the form!".tr, toastPosition: EasyLoadingToastPosition.bottom);
      return false;
    }
    if (pass.text != repass.text) {
      EasyLoading.showToast("The password does not match!".tr, toastPosition: EasyLoadingToastPosition.bottom);
      return false;
    }
    return true;
  }

  void toSuccessScreen() async {
    if (code == null || code!.isEmpty) {
      EasyLoading.showToast("Please enter the code".tr, toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }

    EasyLoading.show();
    var res =
        await AuthService.instance.verifyEmail(email: email.text, code: code!);
    EasyLoading.dismiss();

    if (res.isOk) {
      Get.offAllNamed(successScreenRoute,
          arguments: "Account Created Successfully");
    } else {
      Get.defaultDialog(
        title: "Error",
        content: Text(res.error),
      );
    }
  }

  void directLogin() async {
    EasyLoading.show();
    //call api
    var res = await AuthService.instance
        .login(user: User(email: email.text, password: pass.text));
    EasyLoading.dismiss();

    if (res.isOk) {
      //save user data
      final UserController userController = Get.find();
      userController.currentUser.value = User.fromJson(res.data);
      userController.userToken = res.body["token"];
      userController.currentUser.value.isActive = false;

      //save user token in local
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString("user_token", "Bearer ${res.body["token"]}");

      Get.offAllNamed(myBottomBarRoute);
    } else {
      Get.defaultDialog(
        title: "Error",
        content: Text(res.error),
      );
    }
  }
}
