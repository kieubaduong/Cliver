import 'package:cliver_mobile/app/core/utils/utils.dart';
import 'package:cliver_mobile/data/services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../data/models/credit_history.dart';
import '../../../data/services/CreditService.dart';
import '../../controller/user_controller.dart';
import '../payment/screens/webview_screen.dart';

class CreditController extends GetxController {
  String amount = "";
  var totalBalance = 0.obs;
  var listHistory = <CreditHistory>[].obs;

  Future<bool> performRequest() async {
    EasyLoading.show();
    var res = await CreditService.ins.sendDepositRequest(amount);
    EasyLoading.dismiss();

    if (res.isOk) {
      var result = await Get.to(() => WebviewScreen(
            initUrl: res.body,
          ));

      if (result == true) {
        return true;
      }
    } else {
      Get.defaultDialog(
        title: "Error",
        content: Text(res.error),
      );
    }
    return false;
  }

  getData() async {
    EasyLoading.show();
    await Future.wait([
      AuthService.instance
          .getWallet(token: Get.find<UserController>().userToken)
          .then(
        (res) {
          if (res.isOk) {
            totalBalance.value = res.data["wallet"]["balance"];
          } else {
            Get.defaultDialog(
              title: "Error",
              content: Text(res.error),
            );
          }
        },
      ),
      CreditService.ins.getCreditHistory().then(
        (res) {
          if (res.isOk) {
            listHistory.clear();
            for (int i = 0; i < res.data.length; i++) {
              listHistory.add(CreditHistory.fromJson(res.data[i]));
            }
          } else {
            Get.defaultDialog(
              title: "Error",
              content: Text(res.error),
            );
          }
        },
      ),
    ]);

    EasyLoading.dismiss();
  }
}
