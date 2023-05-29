import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/models/post.dart';

class PostController extends GetxController {
  Post currentPost = Post();
}

class PackageController {
  TextEditingController packageName = TextEditingController();
  TextEditingController packageDes = TextEditingController();
  TextEditingController price = TextEditingController();
  int deliveryDays = 1;
  int revisions = 0;

  bool isValidData() {
    return packageName.text.isNotEmpty &&
        packageDes.text.isNotEmpty &&
        price.text.isNotEmpty;
  }
}
