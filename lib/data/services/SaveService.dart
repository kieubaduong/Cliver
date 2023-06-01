import 'package:cliver_mobile/app/controller/user_controller.dart';
import 'package:cliver_mobile/app/core/values/strings.dart';
import 'package:get/get.dart';

class SaveServiceAPI extends GetConnect {
  SaveServiceAPI._initInstance();

  static final SaveServiceAPI ins = SaveServiceAPI._initInstance();
  final UserController userController = Get.find();

  Future<Response> getSaveList({int? serviceId, String? sellerId}) {
    String pr1 = serviceId != null ? 'postId=$serviceId' : '';
    String pr2 = sellerId != null ? 'sellerId=$sellerId' : '';
    return get(
      "$api_url/me/saved-lists?$pr1$pr2",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': userController.userToken,
      },
    );
  }

  Future<Response> createSaveItem({required String name}) {
    return post(
      "$api_url/me/saved-lists",
      {"name": name},
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': userController.userToken,
      },
    );
  }

  Future<Response> getSaveListServiceById({required int id}) {
    return get(
      "$api_url/me/saved-lists/$id/services",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': userController.userToken,
      },
    );
  }

  Future<Response> getSaveListSellerById({required int id}) {
    return get(
      "$api_url/me/saved-lists/$id/sellers",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': userController.userToken,
      },
    );
  }

  Future<Response> deleteSaveListServiceById({required int id}) {
    return delete(
      "$api_url/me/saved-lists/$id",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': userController.userToken,
      },
    );
  }

  Future<Response> renameSaveListServiceById({required int id, required String name}) {
    return put(
      "$api_url/me/saved-lists/$id",
      {"name": name},
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': userController.userToken,
      },
    );
  }

  Future<Response> changeStatusServicesSaveListById({required int listId, required int serviceId}) {
    return post(
      "$api_url/me/saved-lists/$listId/services",
      {"serviceId": serviceId},
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': userController.userToken,
      },
    );
  }

  Future<Response> changeStatusSellerSaveListById({required int listId, required String sellerId}) {
    return post(
      "$api_url/me/saved-lists/$listId/sellers",
      {"sellerId": sellerId},
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': userController.userToken,
      },
    );
  }

  Future<Response> getServicesSave() {
    return get(
      "$api_url/me/saved-lists/services/recently",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': userController.userToken,
      },
    );
  }
}
