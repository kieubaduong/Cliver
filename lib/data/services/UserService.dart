import 'package:get/get.dart';
import '../../app/controller/controller.dart';
import '../../app/core/core.dart';
import '../models/model.dart';

class UserService extends GetConnect {
  UserService._initInstance();

  static final UserService ins = UserService._initInstance();
  final UserController userController = Get.find();

  Future<Response> getUser({required String? text}) {
    var pr = 'search=$text';
    return get(
      "$api_url/users?$pr",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

  Future<Response> getUserById({required String id}) {
    return get(
      "$api_url/users/$id",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': userController.userToken,
      },
    );
  }

  Future<Response> updateInfoUser({required User user}) async {
    return put(
      "$api_url/account/info",
      {
        "name": user.name,
        "email": user.email,
        "description": user.description,
        "languages": user.languages?.map((e) => e.toJson()).toList(),
        "skills": user.skills
      },
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': userController.userToken,
      },
    );
  }

  Future<Response> updateUserAvatar({required String avt}) async {
    return put(
      "$api_url/account/info",
      {
        "avatar": avt,
      },
      headers: <String, String>{
        'Authorization': userController.userToken,
      },
    );
  }

  Future<Response> getReviewById({required String id}) {
    return get(
      "$api_url/users/$id/reviews",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': userController.userToken,
      },
    );
  }

  Future<Response> getReviewStatisticById({required String id}) {
    return get(
      "$api_url/users/$id/reviews/statistic",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': userController.userToken,
      },
    );
  }

  Future<Response> getReviewSentimentsById({required String id}) {
    return get(
      "$api_url/users/$id/reviews/sentiments",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': userController.userToken,
      },
    );
  }
}
