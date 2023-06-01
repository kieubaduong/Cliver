import 'dart:convert';
import 'dart:developer';

import 'package:cliver_mobile/data/models/create_review.dart';
import 'package:cliver_mobile/data/models/custom_order.dart';
import 'package:cliver_mobile/data/models/order_action.dart';
import 'package:get/get.dart';

import '../../app/controller/user_controller.dart';
import '../../app/core/values/strings.dart';

class OrderService extends GetConnect {
  static final OrderService ins = OrderService._initInstance();

  OrderService._initInstance() {
    timeout = const Duration(seconds: 10);
  }

  Future<Response>? getBuyerOrders() {
    try {
      return get(
        "$api_url/orders",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': Get.find<UserController>().userToken,
        },
      );
    } catch (e) {
      log("OrderService get buyer orders error: $e");
      return null;
    }
  }

  Future<Response>? getBuyerOrdersByStatus({required String status}) {
    try {
      return get(
        "$api_url/orders?status=$status",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': Get.find<UserController>().userToken,
        },
      );
    } catch (e) {
      log("OrderService get buyer orders error: $e");
      return null;
    }
  }

  Future<Response>? getSellerOrders() {
    try {
      return get(
        "$api_url/seller/orders",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': Get.find<UserController>().userToken,
        },
      );
    } catch (e) {
      log("OrderService get seller orders error: $e");
      return null;
    }
  }

  Future<Response>? getSellerOrdersByStatus({required String status}) {
    try {
      return get(
        "$api_url/seller/orders?status=$status",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': Get.find<UserController>().userToken,
        },
      );
    } catch (e) {
      log("OrderService get buyer orders error: $e");
      return null;
    }
  }

  Future<Response>? getBuyerOrder({required int orderId}) {
    try {
      return get(
        "$api_url/orders/$orderId",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': Get.find<UserController>().userToken,
        },
      );
    } catch (e) {
      log("OrderService get order error: $e");
      return null;
    }
  }

  Future<Response>? getSellerOrder({required int orderId}) {
    try {
      return get(
        "$api_url/seller/orders/$orderId",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': Get.find<UserController>().userToken,
        },
      );
    } catch (e) {
      log("OrderService get order error: $e");
      return null;
    }
  }

  Future<Response> sendBuyerAction(
      {required int orderId, required OrderAction orderAction}) async {
    return await post(
      "$api_url/orders/$orderId/action",
      orderAction.toJson(),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': Get.find<UserController>().userToken,
      },
    );
  }

  Future<Response> sendSellerAction(
      {required int orderId, required OrderAction orderAction}) async {
    return await post(
      "$api_url/seller/orders/$orderId/action",
      orderAction.toJson(),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': Get.find<UserController>().userToken,
      },
    );
  }

  Future<Response> buyerReview(
      {required int orderId, required CreateReview createReview}) async {
    return await post(
      "$api_url/orders/$orderId/reviews",
      createReview.toJson(),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': Get.find<UserController>().userToken,
      },
    );
  }

  Future<Response> sellerReview(
      {required int orderId, required CreateReview createReview}) async {
    return await post(
      "$api_url/seller/orders/$orderId/reviews",
      createReview.toJson(),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': Get.find<UserController>().userToken,
      },
    );
  }

  Future<Response> buyerContinuePaymentWithVNPay({required int orderId}) async {
    return await get(
      "$api_url/orders/$orderId/payment",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': Get.find<UserController>().userToken,
      },
    );
  }

  Future<Response> buyerContinuePaymentWithBudget(
      {required int orderId}) async {
    return await get(
      "$api_url/orders/$orderId/wallet-payment",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': Get.find<UserController>().userToken,
      },
    );
  }

  // custom order

  Future<Response>? changeCustomOrderStatus(
      {required int customOrderId, required String customOrderStatus}) {
    try {
      return put(
        "$api_url/seller/custom-packages/$customOrderId/status",
        jsonEncode(customOrderStatus),
        headers: <String, String>{
          'Authorization': Get.find<UserController>().userToken,
        },
      );
    } catch (e) {
      log("OrderService change custom order status error: $e");
      return null;
    }
  }

  Future<Response> createCustomOrder({required CustomOrder customOrder}) async {
    return await post(
      "$api_url/seller/custom-packages",
      jsonEncode(customOrder),
      headers: <String, String>{
        'Authorization': Get.find<UserController>().userToken,
      },
    );
  }

  Future<Response>? getCustomOrder({required int customOrderId}) {
    try {
      return get(
        "$api_url/custom-package/$customOrderId",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': Get.find<UserController>().userToken,
        },
      );
    } catch (e) {
      log("OrderSerice get custom order error: $e");
      return null;
    }
  }
}
