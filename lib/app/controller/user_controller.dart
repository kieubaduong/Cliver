import 'dart:developer';
import 'package:get/get.dart';

import '../../data/models/model.dart';

class UserController extends GetxController {
  static UserController instance = Get.put(UserController());

  var currentUser = User().obs;
  late String userToken = "".obs.value;
  late bool isFirstTime = false.obs.value;

  @override
  void onClose() {
    super.onClose();
    log("UserController closed");
  }
}
