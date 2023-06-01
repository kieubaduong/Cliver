import 'package:get/get.dart';

import '../../app/core/values/strings.dart';

class CategoriesService extends GetConnect {
  CategoriesService._initInstance();

  static final CategoriesService ins = CategoriesService._initInstance();

  Future<Response> getAllCategory() {
    return get(
      "$api_url/categories",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

  Future<Response> getPopularCategory() {
    return get(
      "$api_url/categories/popular",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }
}
