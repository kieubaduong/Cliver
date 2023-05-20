import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../values/values.dart';
import 'localization_service.dart';

showLanguageDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (builder) {
      return AlertDialog(
        title: Text("Change language".tr),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Text(
                        LocalizationService.displayLangList[index]['name']),
                    onTap: () {
                      //Dùng hàm này tiện hơn
                      LocalizationService.changeLocale(
                          LocalizationService.languageCodes[index]);
                      SharedPreferences.getInstance().then((ins) =>
                          ins.setBool("isVN", index == 1 ? true : false));
                      Navigator.pop(context);
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  color: Colors.grey,
                );
              },
              itemCount: LocalizationService.displayLangList.length),
        ),
      );
    },
  );
}

void configLoadingBar() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..backgroundColor = Colors.black.withOpacity(0.1)
    ..indicatorColor = AppColors.primaryColor
    ..userInteractions = false
    ..dismissOnTap = false
    ..textColor = Colors.white;
}

extension GetSize on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;
}

extension ApiResponseHanlder on Response {
  get data => body["data"];

  String get error {
    try {
      Map<String, dynamic> map = jsonDecode(bodyString!);
      if (map.keys.contains("message") && body["message"] != null) {
        return body["message"];
      }
      var temp = Map.from(map["errors"]);
      for (var element in temp.values) {
        return element[0];
      }
    } catch (e) {
      dev.log("parse error error: $e");
    }
    return "Server error";
  }
}

class FormatHelper {
  String? dateFormat(DateTime? date) {
    if (date == null) return null;
    DateTime temp = FormatHelper().toLocal(date) as DateTime;
    String formatTime = "${temp.day}-${temp.month}-${temp.year}";
    return formatTime;
  }

  DateTime? toLocal(DateTime? dateTime) {
    if (dateTime == null) return null;
    return DateFormat("yyyy-MM-dd HH:mm:ss")
        .parse(dateTime.toString(), true)
        .toLocal();
  }

  String? moneyFormat(int? money) {
    if (money == null) return null;
    return NumberFormat.simpleCurrency(
      locale: 'vi',
    ).format(money);
  }

  String? getTimeAgo(DateTime? time) {
    if (time == null) {
      return null;
    }
    timeago.setLocaleMessages("vi", timeago.ViMessages());
    return timeago.format(
        time.add(DateTime.parse(time.toString()).timeZoneOffset),
        locale: Get.locale?.languageCode ?? "en");
  }
}

Future<String> getFileSize(String filepath, int decimals) async {
  var file = File(filepath);
  int bytes = await file.length();
  if (bytes <= 0) return "0 B";
  return '${(bytes / pow(1024, 2)).toStringAsFixed(decimals)} MB';
}
