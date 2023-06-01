import 'package:get/get.dart';

import '../../app/controller/user_controller.dart';
import '../../app/core/values/strings.dart';

class EarningService extends GetConnect {
  static final ins = EarningService._();

  EarningService._();

  final userController = Get.find<UserController>();

  Future<Response> getAnalytics() async {
    return await get("$api_url/earning/analytics", headers: <String, String>{
      'Authorization': userController.userToken,
    });
  }

  Future<Response> getRevenues() async {
    return await get("$api_url/earning/revenues", headers: <String, String>{
      'Authorization': userController.userToken,
    });
  }
}