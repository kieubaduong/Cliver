import 'dart:developer';

import 'package:cliver_mobile/app/controller/user_controller.dart';
import 'package:cliver_mobile/app/core/utils/utils.dart';
import 'package:cliver_mobile/app/features/bottom_navigation_bar/bottom_bar_controller.dart';
import 'package:cliver_mobile/app/features/buyer/order/buyer_order_controller.dart';
import 'package:cliver_mobile/app/features/chat/chat_controller.dart';
import 'package:cliver_mobile/app/features/payment/screens/webview_screen.dart';
import 'package:cliver_mobile/data/models/create_order.dart';
import 'package:cliver_mobile/data/models/model.dart';
import 'package:cliver_mobile/data/services/ChatService.dart';
import 'package:cliver_mobile/data/services/OrderService.dart';
import 'package:cliver_mobile/data/services/PaymentService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../data/enums/screen.dart';
import '../../../data/models/order.dart';
import '../../routes/routes.dart';

class PaymentController extends GetxController {
  int selectedPackage = 0;
  Post? post;
  Package? package;
  int? balance;
  int? remaining;
  Order? order;
  bool? changeBottomBarIndex;
  bool isContinueOrder = false;

  // ui properties
  RxBool isYourBudget = true.obs;
  RxBool isVNPay = false.obs;
  RxBool isOrderDetailsClosed = false.obs;
  RxString paymentMessage = "".obs;

  // function in post details
  Future<void> toChatScreen() async {
    EasyLoading.show();
    try {
      String parterId = post?.userId as String;
      var res = await ChatService.ins.getRoomFromParterId(partnerId: parterId);
      EasyLoading.dismiss();
      if (res!.isOk) {
        Room room = Room.fromJson(res.body["data"]);
        String roomName = post?.user?.name as String;
        if (room.id == null) {
          Get.toNamed(chatScreenRoute,
              arguments: [parterId, roomName, null, post, post?.user?.avatar]);
        } else {
          Get.toNamed(chatScreenRoute, arguments: [
            parterId,
            roomName,
            room.id,
            post,
            post?.user?.avatar
          ]);
        }
        var chatController = Get.find<ChatController>();
        chatController.currentScreen.value = Screen.chatScreen;
      } else {
        Get.defaultDialog(
          title: "Error",
          content: Text(res.error),
        );
      }
    } catch (e) {
      log("payment controller to chat screen error: $e");
      EasyLoading.dismiss();
    }
    EasyLoading.dismiss();
  }

  //order review screen
  void selectYourBudget(bool value) {
    isYourBudget.value = value;
    isVNPay.value = false;
  }

  void selectVNPay(bool value) {
    isVNPay.value = value;
    isYourBudget.value = false;
  }

  void showOrderDetails() {
    isOrderDetailsClosed.value = !isOrderDetailsClosed.value;
  }

  //function in add method screen
  Future<void> addPaymentMethod() async {
    if (Get.find<UserController>().currentUser.value.id == null) {
      await Get.defaultDialog(
        title: "Error",
        content: const Text("Server error"),
      );
      return;
    }
    if (Get.find<UserController>().currentUser.value.wallet == null) {
      await Get.defaultDialog(
        title: "Error",
        content: const Text("Server error"),
      );
      return;
    }
    if (isYourBudget.value) {
      Get.toNamed(budgetPaymentRoute);
    } else if (isVNPay.value) {
      try {
        EasyLoading.show();
        Response res;
        if (!isContinueOrder) {
          res = await PaymentService.ins.getPaymentUrl(
              createOrder:
                  CreateOrder(packageId: package?.id as int, note: ""));
        } else {
          res = await OrderService.ins
              .buyerContinuePaymentWithVNPay(orderId: order?.id as int);
        }
        EasyLoading.dismiss();

        if (res.isOk) {
          var vnpayUrl = res.body;
          if (vnpayUrl != null) {
            var webResult =
                await Get.to(() => WebviewScreen(initUrl: vnpayUrl));

            //nếu thanh toán thành công thì pop ra
            if (webResult == true) {
              await Get.defaultDialog(
                title: "Payment success",
                middleText: "You have paid for the service",
              );
            }
            popAllToBottomBar();
          } else {
            log("vnpayUrl null");
          }
        } else {
          Get.defaultDialog(
            title: "Error",
            content: Text(res.error),
          );
        }
      } catch (e) {
        log("getPaymentUrl error: $e");
        EasyLoading.dismiss();
      }
      EasyLoading.dismiss();
    } else {
      Get.defaultDialog(
        title: "Warning",
        middleText: "Please choose payment method",
      );
    }
  }

  //function in budget screen
  Future<void> payWithBudget() async {
    if (remaining! < 0) {
      await Get.defaultDialog(
        title: "Warning",
        content: const Text("Your balance is not enought"),
      );
      return;
    }
    EasyLoading.show();
    try {
      Response res;
      if (!isContinueOrder) {
        res = await PaymentService.ins.orderWithBudget(
            createOrder: CreateOrder(packageId: package?.id as int, note: ""));
      } else {
        res = await OrderService.ins
            .buyerContinuePaymentWithBudget(orderId: order?.id as int);
      }
      EasyLoading.dismiss();
      if (res.isOk) {
        // order = Order.fromJson(res.body);
        await Get.defaultDialog(
          title: "Payment success",
          middleText: "You have paid for the service ${package?.name}",
        );
        int temp =
            Get.find<UserController>().currentUser.value.wallet?.balance as int;
        Get.find<UserController>().currentUser.value.wallet?.balance =
            temp - (package?.price as int);
        //mua xong ok thì navigate qua order
        if (!isContinueOrder) {
          popAllToBottomBar();
        } else {
          Get.until((route) => Get.currentRoute == buyerOrderDetailScreenRoute);
          var buyerOrderController = Get.find<BuyerOrderController>();
          await buyerOrderController.getOrder(
              orderId: buyerOrderController.order.value.id as int);
        }
      } else {
        Get.defaultDialog(
          title: "Error",
          content: Text(res.error),
        );
      }
    } catch (e) {
      log("pay with budget error: $e");
      EasyLoading.dismiss();
      paymentMessage.value = "server error";
    }
  }

  void popAllToBottomBar() {
    var bottomBarController = Get.find<BottomBarController>();
    bottomBarController.currentIndex.value = 2;
    Get.offAllNamed(myBottomBarRoute);
  }
}
