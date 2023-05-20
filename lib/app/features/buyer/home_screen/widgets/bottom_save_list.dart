import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../../../data/models/model.dart';
import '../../../../../data/services/services.dart';
import '../../../../common_widgets/common_widgets.dart';
import '../../../../core/core.dart';

class BottomSaveList extends StatefulWidget {
  const BottomSaveList({Key? key, this.icon, this.onTapChangeStatus, this.serviceId, this.sellerId}) : super(key: key);
  final String? icon;
  final int? serviceId;
  final String? sellerId;
  final Future<void> Function(int)? onTapChangeStatus;

  @override
  State<BottomSaveList> createState() => _BottomSaveListState();
}

class _BottomSaveListState extends State<BottomSaveList> {
  bool isCreate = false;
  bool isTextEmpty = true;
  late bool isGetData;
  List<SaveService> saveList = [];
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    getSaveList();
    Future.delayed(const Duration(seconds: 2));
  }

  Future<void> createSaveItem(String name) async {
    EasyLoading.show();
    await SaveServiceAPI.ins.createSaveItem(name: name);
    EasyLoading.dismiss();
  }

  Future<void> getSaveList() async {
    setState(() {
      isGetData = false;
    });
    EasyLoading.show();
    if(widget.serviceId != null) {
      var res = await SaveServiceAPI.ins.getSaveList(serviceId: widget.serviceId);
      EasyLoading.dismiss();
      if (res.isOk) {
        if (res.body["data"] is Iterable<dynamic> && res.body["data"].isNotEmpty) {
          saveList = <SaveService>[];
          res.body["data"].forEach((v) {
            if (v != null) {
              saveList.add(SaveService.fromJson(v));
            }
          });
        }
      }
    } else {
      var res = await SaveServiceAPI.ins.getSaveList(sellerId: widget.sellerId);
      EasyLoading.dismiss();
      if (res.isOk) {
        if (res.body["data"] is Iterable<dynamic> && res.body["data"].isNotEmpty) {
          saveList = <SaveService>[];
          res.body["data"].forEach((v) {
            if (v != null) {
              saveList.add(SaveService.fromJson(v));
            }
          });
        }
      }
    }
    setState(() {
      isGetData = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: getWidth(60),
            height: getHeight(2),
            margin: EdgeInsets.symmetric(vertical: getHeight(10)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.metallicSilver,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: getHeight(10)),
            child: Row(
              children: [
                InkWellWrapper(
                  onTap: isCreate ? () => setState(() => isCreate = !isCreate) : null,
                  margin: EdgeInsets.symmetric(horizontal: getWidth(10)),
                  paddingChild: EdgeInsets.all(getWidth(5)),
                  child: Text(
                    'cancel'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: getFont(18),
                      color: isCreate ? AppColors.metallicSilver : Colors.transparent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'save list'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: getFont(18)),
                  ),
                ),
                InkWellWrapper(
                  onTap: !isCreate || !isTextEmpty
                      ? () async {
                          if (isTextEmpty) {
                            Navigator.pop(context);
                          } else {
                            await createSaveItem(controller.text);
                            await getSaveList();
                            controller.clear();
                            setState(() {
                              isTextEmpty = true;
                            });
                          }
                        }
                      : null,
                  margin: EdgeInsets.symmetric(horizontal: getWidth(10)),
                  paddingChild: EdgeInsets.all(getWidth(5)),
                  child: Text(
                    isCreate ? 'create'.tr : 'done'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: getFont(18),
                      color: !isCreate || !isTextEmpty ? AppColors.greenCrayola : AppColors.greenCrayola.withOpacity(0.5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: getHeight(10)),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              if (index == 0) {
                return isCreate
                    ? TextField(
                        controller: controller,
                        autofocus: true,
                        onChanged: (value) {
                          if (value.isEmpty) {
                            setState(() => isTextEmpty = true);
                          } else {
                            setState(() => isTextEmpty = false);
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'create list'.tr,
                          hintStyle: TextStyle(fontSize: getFont(18), fontWeight: FontWeight.w600),
                          contentPadding: EdgeInsets.symmetric(horizontal: getWidth(15), vertical: getHeight(20)),
                          filled: true,
                          fillColor: AppColors.primaryWhite,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                      )
                    : InkWellWrapper(
                        onTap: () => setState(() => isCreate = !isCreate),
                        width: MediaQuery.of(context).size.width,
                        border: Border(
                          top: BorderSide(width: 2, color: AppColors.metallicSilver.withOpacity(0.2)),
                          bottom: BorderSide(width: 2, color: AppColors.metallicSilver.withOpacity(0.2)),
                        ),
                        paddingChild: EdgeInsets.symmetric(horizontal: getWidth(15), vertical: getHeight(20)),
                        child: Text(
                          'create list'.tr,
                          style: TextStyle(fontSize: getFont(18), color: AppColors.greenCrayola, fontWeight: FontWeight.w600),
                        ),
                      );
              } else {
                return InkWellWrapper(
                  onTap: () async {
                    EasyLoading.show();
                    await widget.onTapChangeStatus?.call(saveList[index - 1].id!);
                    await getSaveList();
                  },
                  width: MediaQuery.of(context).size.width,
                  paddingChild: EdgeInsets.symmetric(horizontal: getWidth(15), vertical: getHeight(10)),
                  border: Border(
                    bottom: BorderSide(width: 1, color: AppColors.metallicSilver.withOpacity(0.15)),
                  ),
                  child: Row(
                    children: [
                      Image.network(
                        widget.icon ?? "",
                        fit: BoxFit.cover,
                        width: getWidth(40),
                        height: getWidth(40),
                        errorBuilder: (_, __, ___) => const SizedBox(),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              saveList[index - 1].name ?? "",
                              style: TextStyle(fontWeight: FontWeight.w700, fontSize: getFont(17)),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: getHeight(6)),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.person,
                                  size: getWidth(19),
                                  color: AppColors.metallicSilver,
                                ),
                                Text(
                                  '${saveList[index - 1].sellerCount} seller',
                                  style: TextStyle(fontSize: getFont(17), color: AppColors.metallicSilver.withOpacity(0.8)),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(width: getWidth(5)),
                                Icon(
                                  Icons.person,
                                  size: getWidth(19),
                                  color: AppColors.metallicSilver,
                                ),
                                Text(
                                  '${saveList[index - 1].serviceCount} post',
                                  style: TextStyle(fontSize: getFont(17), color: AppColors.metallicSilver.withOpacity(0.7)),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Visibility(
                        visible: saveList[index - 1].isSaved!,
                        child: Icon(
                          Icons.check,
                          size: getWidth(24),
                          color: AppColors.greenCrayola,
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
            itemCount: saveList.length + 1,
          )
        ],
      ),
    );
  }
}
