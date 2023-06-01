import 'package:get/get.dart';

import '../../app/controller/user_controller.dart';
import '../../app/core/values/strings.dart';
import '../models/create_order.dart';

class PaymentService extends GetConnect {
  static final PaymentService ins = PaymentService._initInstance();

  PaymentService._initInstance() {
    timeout = const Duration(seconds: 10);
  }

  Future<Response> getPaymentUrl({required CreateOrder createOrder}) async {
    return await post(
      "$api_url/payment",
      createOrder.toJson(),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': Get.find<UserController>().userToken,
      },
    );
  }

  Future<Response> orderWithBudget({required CreateOrder createOrder}) async {
    return await post(
      "$api_url/orders",
      createOrder.toJson(),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': Get.find<UserController>().userToken,
      },
    );
  }
}
