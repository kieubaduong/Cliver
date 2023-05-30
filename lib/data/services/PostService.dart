import 'dart:convert';
import 'package:get/get.dart';
import '../../app/controller/controller.dart';
import '../../app/core/values/strings.dart';
import '../models/post.dart';
import '../../app/core/core.dart';

class PostService extends GetConnect {
  PostService._initInstance();

  static final PostService ins = PostService._initInstance();
  final UserController userController = Get.find();

  Future<Response> createPost({required Post myPost}) {
    myPost.description = ".";
    return post(
      "$api_url/posts",
      myPost.toJson(),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': userController.userToken,
      },
    );
  }

  Future<Response> putPostStep({required Post post}) {
    return put(
      "$api_url/posts/${post.id}",
      post.toJson(),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': userController.userToken,
      },
    );
  }

  Future<Response> getPostById({required int id}) {
    return get(
      "$api_url/posts/$id",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': userController.userToken,
      },
    );
  }

  Future<Response> getPosts({String? search, int? minPrice, int? maxPrice, int? deliveryTime, String? filter, int? categoryId, int? offset, int? limit, int? subCategoryId}) {
    String prm1 = search != null ? "&Search=$search" : '';
    String prm2 = minPrice != null ? "&MinPrice=$minPrice" : '';
    String prm3 = maxPrice != null ? "&MaxPrice=$maxPrice" : '';
    String prm4 = deliveryTime != null ? "&DeliveryTime=$deliveryTime" : '';
    String prm5 = filter != null ? "&Filter=$filter" : '';
    String prm6 = categoryId != null ? "&CategoryId=$categoryId" : '';
    String prm7 = subCategoryId != null ? "&SubCategoryId=$subCategoryId" : '';
    String prm8 = offset != null ? "&Offset=$offset" : '';
    String prm9 = limit != null ? "&Limit=$limit" : '';
    return get(
      "$api_url/posts?$prm1$prm2$prm3$prm4$prm5$prm6$prm7$prm8$prm9",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': userController.userToken,
      },
    );
  }

  Future<Response> getPostsRecently() {
    return get(
      "$api_url/posts/recently",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': userController.userToken,
      },
    );
  }

  Future<Response> getMyPosts({String? status}) {
    String prm1 = status != null ? "&Status=$status" : '';
    return get(
      "$api_url/seller/posts?$prm1",
      headers: <String, String>{
        'Authorization': userController.userToken,
      },
    );
  }

  Future<Response> getReviewById({required int id}) {
    return get(
      "$api_url/posts/$id/reviews",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': userController.userToken,
      },
    );
  }

  Future<Response> getReviewStatisticById({required int id}) {
    return get(
      "$api_url/posts/$id/reviews/statistic",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': userController.userToken,
      },
    );
  }

  Future<Response> deleteDraftPost({required int id}) async {
    return delete(
      "$api_url/posts/$id",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': userController.userToken,
      },
    );
  }

  Future<Response> putPostStatus({required int id, required String status}) {
    return put(
      "$api_url/posts/$id/status",
      jsonEncode(status),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': userController.userToken,
      },
    );
  }
}
