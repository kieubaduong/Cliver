import 'dart:convert';

import 'package:cliver_mobile/app/core/values/strings.dart';
import 'package:get/get.dart';

import '../../app/controller/user_controller.dart';
import '../models/service_request.dart';

class RequestService extends GetConnect {
  static final RequestService ins = RequestService._();
  final UserController userController = Get.find();

  RequestService._();

  Future<Response> getBuyerRequest() async {
    return await get("$api_url/seller/service-requests",
        headers: <String, String>{
          'Authorization': userController.userToken,
        });
  }

  Future<Response> getMyRequest() async {
    return await get("$api_url/service-requests", headers: <String, String>{
      'Authorization': userController.userToken,
    });
  }

  Future<Response> markAsDone(int id) async {
    return await get("$api_url/service-requests/$id/done",
        headers: <String, String>{
          'Authorization': userController.userToken,
        });
  }

  Future<Response> createMyRequest(ServiceRequest newReq) async {
    return await post("$api_url/service-requests/", jsonEncode(newReq),
        headers: <String, String>{
          'Authorization': userController.userToken,
        });
  }

  Future<Response> deleteMyRequest(ServiceRequest newReq) async {
    return await delete("$api_url/service-requests/${newReq.id}",
        headers: <String, String>{
          'Authorization': userController.userToken,
        });
  }
}
