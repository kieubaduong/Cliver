import 'dart:developer';

import '../../../../../../core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../../../../../data/models/post.dart';
import '../../../../../../../data/services/services.dart';

class ManagePostController extends GetxController {
  var myPostList = <Post>[].obs;
  RxString statusListPost = "You have no post yet".tr.obs;

  getAllMyPost({String? postStatus}) async {
    EasyLoading.show();
    try{
      myPostList.clear();
    } catch (e) {
      log(e.toString());
    }
    Response? res;
    if (postStatus == null) {
      res = await PostService.ins.getMyPosts();
      statusListPost.value = "You have no post yet";
    } else {
      res = await PostService.ins.getMyPosts(status: postStatus);
      statusListPost.value = "You have no $postStatus post yet";
    }
    EasyLoading.dismiss();

    if (res.isOk) {
      myPostList.value = [];
      for (int i = 0; i < res.data.length; i++) {
        myPostList.add(Post.fromJson(res.data[i]));
      }
    } else {
      Get.defaultDialog(
        title: "Error",
        content: Text(res.error),
      );
    }
  }
}
