import '../../../../core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../../../data/models/service_request.dart';
import '../../../../../data/services/RequestService.dart';

class BuyerRequestController extends GetxController {
  var listRequest = <ServiceRequest>[].obs;

  getAllRequest() async {
    EasyLoading.show();
    var res = await RequestService.ins.getBuyerRequest();
    EasyLoading.dismiss();
    if (res.isOk) {
      listRequest.value = [];
      for (int i = 0; i < res.data.length; i++) {
        listRequest.add(ServiceRequest.fromJson(res.data[i]));
      }
    } else {
      Get.defaultDialog(
        title: "Error",
        content: Text(res.error),
      );
    }
  }
}
