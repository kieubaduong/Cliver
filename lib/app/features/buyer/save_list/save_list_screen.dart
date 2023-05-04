import 'package:cliver_mobile/app/common_widgets/inkWell_wrapper.dart';
import 'package:cliver_mobile/app/common_widgets/loading_container.dart';
import 'package:cliver_mobile/app/core/utils/size_config.dart';
import 'package:cliver_mobile/app/core/values/app_colors.dart';
import 'package:cliver_mobile/app/routes/routes.dart';
import 'package:cliver_mobile/data/models/save_service.dart';
import 'package:cliver_mobile/data/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SaveList extends StatefulWidget {
  const SaveList({Key? key}) : super(key: key);

  @override
  State<SaveList> createState() => _SaveListState();
}

class _SaveListState extends State<SaveList> {
  List<SaveService> saveList = [];
  bool isGetData = false;

  @override
  void initState() {
    super.initState();
    getSaveList();
  }

  Future<void> getSaveList() async {
    setState(() {
      isGetData = false;
    });
    EasyLoading.show();
    var res = await SaveServiceAPI.ins.getSaveList();
    EasyLoading.dismiss();
    if (res.isOk) {
      if (res.body["data"] is Iterable<dynamic> &&
          res.body["data"].isNotEmpty) {
        saveList = <SaveService>[];
        res.body["data"].forEach((v) {
          if (v != null) {
            saveList.add(SaveService.fromJson(v));
          }
        });
      }
    }
    setState(() {
      isGetData = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'my list'.tr,
          style: TextStyle(fontSize: getFont(25), fontWeight: FontWeight.w700),
        ),
        elevation: 0.5,
      ),
      body: isGetData
          ? saveList.isNotEmpty
              ? SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                      horizontal: getWidth(10), vertical: getHeight(3)),
                  child: Column(
                    children: List.generate(saveList.length, (index) {
                      return InkWellWrapper(
                        onTap: () => Get.toNamed(saveListDetailRoute,
                            arguments: saveList[index]),
                        margin: EdgeInsets.symmetric(
                            horizontal: getWidth(10), vertical: getHeight(20)),
                        width: getWidth(MediaQuery.of(context).size.width),
                        height: getHeight(getHeight(260)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 3,
                            spreadRadius: 1,
                            offset: const Offset(0, 1),
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 2,
                            spreadRadius: 0,
                            offset: const Offset(0, 1),
                          )
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primaryWhite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              child: Image.network(
                                saveList[index].thumnail ?? '',
                                height: getHeight(175),
                                width:
                                    getWidth(MediaQuery.of(context).size.width),
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return LoadingContainer(
                                    height: getHeight(175),
                                    width: getWidth(
                                        MediaQuery.of(context).size.width),
                                  );
                                },
                                errorBuilder: (_, __, ___) => Image.asset(
                                  "assets/images/bg_default.png",
                                  height: getHeight(175),
                                  width: getWidth(
                                      MediaQuery.of(context).size.width),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getWidth(10),
                                  vertical: getHeight(10)),
                              child: Text(
                                saveList[index].name ?? '',
                                style: TextStyle(
                                    fontSize: getFont(17),
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getWidth(10)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${saveList[index].sellerCount} ${'seller'.tr}',
                                      style: TextStyle(
                                          fontSize: getFont(15),
                                          color: AppColors.metallicSilver
                                              .withOpacity(0.8)),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Container(
                                      width: getWidth(4),
                                      height: getWidth(4),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: getWidth(5)),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryBlack
                                            .withOpacity(0.55),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    Text(
                                      '${saveList[index].serviceCount} ${'post'.tr}',
                                      style: TextStyle(
                                          fontSize: getFont(15),
                                          color: AppColors.metallicSilver
                                              .withOpacity(0.8)),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      );
                    }),
                  ),
                )
              : Center(
                  child: Text('No Save list'.tr),
                )
          : null,
    );
  }
}
