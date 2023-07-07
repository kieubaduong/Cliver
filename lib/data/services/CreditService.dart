import 'dart:convert';
import 'package:get/get.dart';
import '../../app/controller/controller.dart';
import '../../app/core/core.dart';

class CreditService extends GetConnect {
  static final ins = CreditService._();
  final userController = Get.find<UserController>();

  CreditService._();

  Future<Response> sendDepositRequest(String amount) async {
    return await post("$api_url/account/deposit", jsonEncode(amount),
        headers: <String, String>{
          'Authorization': userController.userToken,
        });
  }

  Future<Response> sendWithdrawRequest(String amount) async {
    return await post(
        "$api_url/account/withdraw", jsonEncode(amount),
        headers: <String, String>{
          'Authorization': userController.userToken,
        });
  }

  Future<Response> getCreditHistory() async {
    return await get("$api_url/account/wallet/history",
        headers: <String, String>{
          'Authorization': userController.userToken,
        });
  }
}
