import '../../../core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../../data/models/analytics.dart';
import '../../../../data/models/revenues.dart';
import '../../../../data/services/AuthService.dart';
import '../../../../data/services/CreditService.dart';
import '../../../../data/services/EarningService.dart';
import '../../../controller/user_controller.dart';
import '../../payment/screens/webview_screen.dart';

class EarningController extends GetxController {
  var analytics = Analytics().obs;
  var revenues = Revenues().obs;
  var totalBalance = 0.obs;
  String amount = "";

  getEarningData() async {
    EasyLoading.show();
    await Future.wait([
      EarningService.ins.getAnalytics().then((value) {
        if (value.isOk) {
          analytics.value = Analytics.fromJson(value.data);
        } else {
          Get.defaultDialog(
            title: "Error",
            content: Text(value.error),
          );
        }
      }),
      EarningService.ins.getRevenues().then((value) {
        if (value.isOk) {
          revenues.value = Revenues.fromJson(value.data);
        } else {
          Get.defaultDialog(
            title: "Error",
            content: Text(value.error),
          );
        }
      }),
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
    ]);

    EasyLoading.dismiss();
  }

  performRequest() async {
    EasyLoading.show();
    var res = await CreditService.ins.sendWithdrawRequest(amount);
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
}
