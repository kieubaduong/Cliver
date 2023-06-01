import 'dart:developer';

import 'package:cliver_mobile/app/core/values/strings.dart';

import '../../app/controller/user_controller.dart';

import 'package:get/get.dart';

class ChatService extends GetConnect {
  static final ChatService ins = ChatService._initInstance();

  ChatService._initInstance() {
    timeout = const Duration(seconds: 10);
  }

  Future<Response>? getAllRooms() {
    try {
      return get(
        "$api_url/rooms",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': Get.find<UserController>().userToken,
        },
      );
    } catch (e) {
      log("ChatService get all room error: $e");
      return null;
    }
  }

  Future<Response>? getRoom({required int roomId}) {
    try {
      return get(
        "$api_url/rooms/$roomId",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': Get.find<UserController>().userToken,
        },
      );
    } catch (e) {
      log("ChatService get room error: $e");
      return null;
    }
  }

  Future<Response>? getAllMessages({required String partnerId}) {
    try {
      return get(
        "$api_url/messages?partnerId=$partnerId",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': Get.find<UserController>().userToken,
        },
      );
    } catch (e) {
      log("ChatService get all messages error: $e");
      return null;
    }
  }

  Future<Response>? getRoomFromParterId({required String partnerId}) {
    try {
      return get(
        "$api_url/rooms/partner/$partnerId?partnerId=$partnerId",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': Get.find<UserController>().userToken,
        },
      );
    } catch (e) {
      log("ChatService get room from partner id error: $e");
      return null;
    }
  }
}
