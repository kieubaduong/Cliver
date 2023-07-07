import 'dart:developer';
import 'dart:io';
import '../../../../../core/core.dart';
import '../../../../../../data/enums/action.dart' as Action;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../../../data/enums/status.dart';
import '../../../../../../data/models/model.dart';
import '../../../../../../data/services/services.dart';

class SellerOrderController extends GetxController {
  RxList<Order> orders = <Order>[].obs;
  Rx<Order> order = Order().obs;
  RxList<String> images = RxList();

  // seller order detail
  final f = DateFormat('dd MMM HH:mm');
  RxList<Widget> timeline = <Widget>[].obs;
  File? file;
  RxString fileName = "Please select a zip file".tr.obs;
  RxString fileSizeName = "".obs;
  Status? orderStatus;
  bool isFirstDoing = true;
  String reviewContent = "";
  late Review review;
  int rating = 1;

  Future<void> getSellerOrderByStatus({required String? orderStatus}) async {
    try {
      EasyLoading.show();
      Response? res;
      if (orderStatus == null) {
        res = await OrderService.ins.getSellerOrders();
      } else {
        res =
            await OrderService.ins.getSellerOrdersByStatus(status: orderStatus);
      }
      EasyLoading.dismiss();
      if (res!.isOk) {
        List<Order> listOrder = res.body["data"]
            .map<Order>((json) => Order.fromJson(json))
            .toList() as List<Order>;
        if (orderStatus == null) {
          listOrder
              .sort((a, b) => b.updatedAt!.compareTo(a.updatedAt as DateTime));

          orders.value = List.from(listOrder);
        } else {
          orders.value = List.from(listOrder);
        }
        log("${res.body['message']}");
      } else {
        Get.defaultDialog(
          title: "Error",
          content: Text(res.error),
        );
      }
    } catch (e) {
      log("SellerOrderController get orders by status error: $e");
      EasyLoading.dismiss();
    }
  }

  void initSellerOrderDetailData() {
    clearZipFile();
    orderStatus = Status.values.firstWhere((e) => e == order.value.status);
  }

  Future<void> reloadData() async {
    clearZipFile();
    order.value = await getOrder(orderId: order.value.id as int) as Order;
    orderStatus = order.value.status;
  }

  // created order method
  Future<void> startMakingOrder() async {
    EasyLoading.show();
    try {
      OrderAction orderAction = OrderAction(action: Action.Action.Start);
      var res = await OrderService.ins.sendSellerAction(
        orderId: order.value.id as int,
        orderAction: orderAction,
      );
      order.value = await getOrder(orderId: order.value.id as int) as Order;
      await reloadData();
      EasyLoading.dismiss();
      if (res.isOk) {
        Get.defaultDialog(
          title: "Success",
          content: const Text("Start making order successfully"),
        );
      } else {
        Get.defaultDialog(
          title: "Error".tr,
          content: Text(res.error),
        );
      }
    } catch (e) {
      log("start making order error $e");
      EasyLoading.dismiss();
    }
  }

  //delivery order method
  Future<void> pickZipFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );
    if (result != null) {
      log(result.toString());
      File pickedFile = File(result.files.single.path as String);
      if (pickedFile.path.substring(pickedFile.path.length - 3) != 'zip') {
        await Get.defaultDialog(
          title: "Unsupported file type".tr,
          content: Text("Please pick a zip file".tr),
        );
        return;
      }
      file = pickedFile;
      fileName.value = getFileName();
      String temp = await getFileSize(pickedFile.path, 1);
      fileSizeName.value = "($temp)";
    }
  }

  void clearZipFile() {
    file = null;
    fileName.value = "Please select a zip file".tr;
    fileSizeName.value = "";
  }

  Future<void> downloadZip(
      {required String fileName, required String url}) async {
    try {
      EasyLoading.show();
      final appStorage = await getApplicationDocumentsDirectory();
      log(url);
      await FlutterDownloader.enqueue(
        url: url,
        savedDir: appStorage.path,
        showNotification: true,
        openFileFromNotification: true,
        saveInPublicStorage: true,
      );
      EasyLoading.dismiss();
      await Get.defaultDialog(
        title: "Notification".tr,
        content: Text("Download successfully".tr),
      );
      log("download path: ${appStorage.path}/$fileName");
    } catch (e) {
      EasyLoading.dismiss();
      log("download zip error: $e");
    }
  }

  Future<void> deliveryOrder() async {
    EasyLoading.show();
    try {
      CreateResource? createResource;
      String? zipUrl;
      if (file != null) {
        zipUrl = await StorageService.ins
            .uploadZip(file!, order.value.package?.postId as int);
        createResource = CreateResource(
          name: fileName.value,
          size: file?.lengthSync(),
          url: zipUrl,
        );
        String temp =
            fileSizeName.value.substring(0, fileSizeName.value.length - 4);
        double fileSize = double.parse(temp.substring(1));
        if (fileSize > 500) {
          await Get.defaultDialog(
              title: "The selected zip file must not exceed 500 MB");
          return;
        }
      }
      OrderAction orderAction = OrderAction(
        action: Action.Action.Delivery,
        resource: createResource,
      );
      var res = await OrderService.ins.sendSellerAction(
        orderId: order.value.id as int,
        orderAction: orderAction,
      );
      await reloadData();
      EasyLoading.dismiss();
      if (res.isOk) {
        Get.defaultDialog(
          title: "Success",
          content: const Text("Delivery order successfully"),
        );
      } else {
        Get.defaultDialog(
          title: "Error".tr,
          content: Text(res.error),
        );
      }
    } catch (e) {
      log("delivery order error $e");
      EasyLoading.dismiss();
    }
  }

// completed order
  Future<void> reviewOrder() async {
    if (reviewContent.length < 10) {
      Get.defaultDialog(
        title: "Warning",
        content: const Text("Please review at least 10 characters"),
      );
      return;
    }
    EasyLoading.show();
    try {
      var sentiment = await SentimentService.ins.getSentiment(text: reviewContent);
      var review = Review();
      if (sentiment.isOk) {
        if (sentiment.body != null) {
          sentiment.body.forEach((v) {
            if (v != null) {
              review = Review.fromJson(v);
            }
          });
        }
      }
      var res = await OrderService.ins.sellerReview(
        orderId: order.value.id as int,
        createReview: CreateReview(
          orderId: order.value.id,
          rating: rating,
          comment: review.comment,
          label: review.label
        ),
      );
      if (res.isOk) {
        var temp = Map<String, dynamic>.from(res.body["data"]);
        review = Review.fromJson(temp);
        await reloadData();
        log(res.body["message"]);
      } else {
        Get.defaultDialog(
          title: "Error".tr,
          content: Text(res.error),
        );
      }
      EasyLoading.dismiss();
    } catch (e) {
      log("seller review error $e");
      EasyLoading.dismiss();
    }
  }

// canceled order
  Future<void> cancelOrder() async {
    EasyLoading.show();
    try {
      OrderAction orderAction = OrderAction(action: Action.Action.Cancel);
      var res = await OrderService.ins.sendSellerAction(
        orderId: order.value.id as int,
        orderAction: orderAction,
      );
      await reloadData();
      EasyLoading.dismiss();
      if (res.isOk) {
        Get.defaultDialog(
          title: "Sucess",
          content: const Text("Cancel order successfully"),
        );
      } else {
        Get.defaultDialog(
          title: "Error".tr,
          content: Text(res.error),
        );
      }
    } catch (e) {
      EasyLoading.dismiss();
    }
  }

// order base method
  Future<RxList<Order>> getAllOrders() async {
    orders.clear();
    EasyLoading.show();
    try {
      var res = await OrderService.ins.getSellerOrders();
      EasyLoading.dismiss();
      if (res!.isOk) {
        List<Order> listOrder = res.body["data"]
            .map<Order>((json) => Order.fromJson(json))
            .toList() as List<Order>;
        listOrder
            .sort((a, b) => b.updatedAt!.compareTo(a.updatedAt as DateTime));
        orders.value = List.from(listOrder);
        log("${res.body['message']}");
        return orders;
      } else {
        Get.defaultDialog(
          title: "Error".tr,
          content: Text(res.error),
        );
      }
    } catch (e) {
      log("SellerOrderController getAllOrders error: $e");
      EasyLoading.dismiss();
    }
    return <Order>[].obs;
  }

  Future<String?> getOrderImage({required int postId}) async {
    try {
      var res = await PostService.ins.getPostById(id: postId);
      if (res.isOk) {
        return res.body["data"]["images"][0];
      } else {
        Get.defaultDialog(
          title: "Error".tr,
          content: Text(res.error),
        );
      }
    } catch (e) {
      log("get order image error: $e");
    }
    return null;
  }

  Future<Order?> getOrder({required int orderId}) async {
    try {
      var res = await OrderService.ins.getSellerOrder(orderId: orderId);
      if (res!.isOk) {
        log("${res.body['message']}");
        order.value = Order.fromJson(res.body["data"]);
        return order.value;
      } else {
        Get.defaultDialog(
          title: "Error".tr,
          content: Text(res.error),
        );
      }
    } catch (e) {
      log("SellerOrderController getAllOrders error: $e");
    }
    return null;
  }

  String getFileName() {
    int nameLength = 0;
    for (var i = file!.path.length - 1; i >= 0; i--) {
      if (file?.path[i] != '/') {
        nameLength++;
      } else {
        break;
      }
    }
    return file!.path.substring(file!.path.length - nameLength);
  }
}
