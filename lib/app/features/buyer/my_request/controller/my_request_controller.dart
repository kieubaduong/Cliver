import 'package:cliver_mobile/app/core/utils/utils.dart';
import 'package:cliver_mobile/data/models/model.dart';
import 'package:cliver_mobile/data/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../../../../data/models/service_request.dart';
import '../../../../../data/services/RequestService.dart';

class MyRequestController extends GetxController {
  //DATA FROM API
  var categoryList = <Category>[].obs;
  var categoryNameList = <String>[].obs;
  var subCategoryList = <SubCategory>[].obs;
  var subCategoryNameList = <String>[].obs;
  var mainSelect = "".obs;
  var subSelect = "".obs;

  var isHaveDeadline = true.obs;
  var isHaveMoney = true.obs;
  var selectedDate = Rxn<DateTime>();

  final desController = TextEditingController();
  final tagController = TextfieldTagsController();
  final inputMoney = TextEditingController();

  //manage screen props here
  var listMyRequest = Rxn<List<ServiceRequest>>();

  void getAllCategory() async {
    EasyLoading.show();
    var res = await CategoriesService.ins.getAllCategory();
    EasyLoading.dismiss();

    if (res.isOk) {
      for (int i = 0; i < res.data.length; i++) {
        categoryList.add(Category.fromJson(res.data[i]));
        categoryNameList.add(Category.fromJson(res.data[i]).name!);
      }

      subCategoryList.value = categoryList[0].subcategories!;
      for (int i = 0; i < subCategoryList.length; i++) {
        subCategoryNameList.add(subCategoryList[i].name!);
      }
      mainSelect.value = categoryNameList[0];
      subSelect.value = subCategoryNameList[0];
    } else {
      Get.defaultDialog(
        title: "Error",
        content: Text(res.error),
      );
    }
  }

  void changeCategory(String val) {
    mainSelect.value = val;
    for (int i = 0; i < categoryList.length; i++) {
      if (categoryList[i].name == val) {
        subCategoryList.value = categoryList[i].subcategories!;
        subCategoryNameList.clear();
        for (int m = 0; m < subCategoryList.length; m++) {
          subCategoryNameList.add(subCategoryList[m].name!);
        }
        subSelect.value = subCategoryNameList[0];
        return;
      }
    }
  }

  void toggleDeadline(int? index) {
    isHaveDeadline.value = index! == 0 ? true : false;
  }

  void toggleMoney(int? index) {
    isHaveMoney.value = index! == 0 ? true : false;
  }

  getMyRequest() async {
    EasyLoading.show();
    var res = await RequestService.ins.getMyRequest();
    EasyLoading.dismiss();

    listMyRequest.value = [];
    if (res.isOk) {
      for (int i = 0; i < res.data.length; i++) {
        listMyRequest.value!.add(ServiceRequest.fromJson(res.data[i]));
      }
    } else {
      Get.defaultDialog(
        title: "Error",
        content: Text(res.error),
      );
    }
  }

  markRequestAsDone(ServiceRequest selectedReq) async {
    if (selectedReq.id == null) return;
    EasyLoading.show();
    var res = await RequestService.ins.markAsDone(selectedReq.id!);
    EasyLoading.dismiss();

    if (res.isOk) {
      listMyRequest.value?.forEach((element) {
        if (element.id == selectedReq.id) {
          element.doneAt = DateTime.now();
        }
      });
      Get.back();
      listMyRequest.refresh();
    } else {
      Get.defaultDialog(
        title: "Error",
        content: Text(res.error),
      );
    }
  }

  deleteRequest(ServiceRequest req) async {
    if (req.id == null) return;
    EasyLoading.show();
    var res = await RequestService.ins.deleteMyRequest(req);
    EasyLoading.dismiss();

    if (res.isOk) {
      listMyRequest.value?.removeWhere((element) => element.id == req.id);
      Get.back();
      listMyRequest.refresh();
    } else {
      Get.defaultDialog(
        title: "Error",
        content: Text(res.error),
      );
    }
  }

  createNewRequest() async {
    //check condition here
    if (desController.text.trim().isEmpty) {
      EasyLoading.showToast("Please fill all the field", toastPosition: EasyLoadingToastPosition.bottom);
    }
    if (isHaveDeadline.value && selectedDate.value == null) {
      EasyLoading.showToast("Please fill all the field", toastPosition: EasyLoadingToastPosition.bottom);
    }
    if (isHaveMoney.value == true && inputMoney.text.trim().isEmpty) {
      EasyLoading.showToast("Please fill all the field", toastPosition: EasyLoadingToastPosition.bottom);
    }
    if (tagController.hasTags == false) {
      EasyLoading.showToast("Please fill all the field", toastPosition: EasyLoadingToastPosition.bottom);
    }

    final newReq = ServiceRequest();
    newReq.description = desController.text.trim();
    newReq.categoryId = categoryList
        .firstWhere((element) => element.name == mainSelect.value)
        .id;
    newReq.subcategoryId = subCategoryList
        .firstWhere((element) => element.name == subSelect.value)
        .id;
    newReq.tags = tagController.getTags;
    if (isHaveMoney.value == true) {
      newReq.budget = int.parse(inputMoney.text.trim());
    }
    if (isHaveDeadline.value == true) {
      newReq.deadline = selectedDate.value;
    }

    EasyLoading.show();
    var res = await RequestService.ins.createMyRequest(newReq);
    EasyLoading.dismiss();
    if (res.isOk) {
      Get.back();
      getMyRequest();
    } else {
      Get.defaultDialog(
        title: "Error",
        content: Text(res.error),
      );
    }
  }
}
