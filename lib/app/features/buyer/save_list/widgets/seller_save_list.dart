import 'package:cliver_mobile/app/common_widgets/inkWell_wrapper.dart';
import 'package:cliver_mobile/app/core/utils/size_config.dart';
import 'package:cliver_mobile/app/core/values/app_colors.dart';
import 'package:cliver_mobile/app/routes/routes.dart';
import 'package:cliver_mobile/data/models/model.dart';
import 'package:cliver_mobile/data/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SellerSaveList extends StatefulWidget {
  const SellerSaveList({Key? key, required this.saveListId}) : super(key: key);
  final int saveListId;

  @override
  State<SellerSaveList> createState() => _SellerSaveListState();
}

class _SellerSaveListState extends State<SellerSaveList> {
  late bool isGetData;
  late List<User> user = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() => isGetData = false);
    EasyLoading.show();
    var res = await SaveServiceAPI.ins.getSaveListSellerById(id: widget.saveListId);
    if (res.isOk) {
      user.clear();
      if (res.body["data"] is Iterable<dynamic> && res.body["data"].isNotEmpty) {
        user = <User>[];
        res.body["data"].forEach((v) {
          if (v != null) {
            user.add(User.fromJson(v));
          }
        });
      }
    }
    EasyLoading.dismiss();
    setState(() => isGetData = true);
  }

  @override
  Widget build(BuildContext context) {
    return isGetData ? GridView.builder(
      padding: EdgeInsets.only(
        top: getHeight(10),
        left: getWidth(10),
        right: getWidth(10),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: getWidth(15),
        mainAxisSpacing: getHeight(10),
        childAspectRatio: 0.75,
      ),
      itemCount: user.length,
      itemBuilder: (context, index) {
        return InkWellWrapper(
          onTap: () => Get.toNamed(sellerProfileScreenRoute, arguments: user[index].id),
          borderRadius: BorderRadius.circular(15),
          color: AppColors.primaryWhite,
          paddingChild: const EdgeInsets.all(5),
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 32, height: 32),
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: getHeight(15)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.network(
                            user[index].avatar ?? '',
                            fit: BoxFit.cover,
                            width: getWidth(70),
                            height: getWidth(70),
                            errorBuilder: (_, __, ___) => const SizedBox(),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 1.5,
                        bottom: 1.5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.greenCrayola,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.primaryWhite, width: 1.5),
                          ),
                          width: getWidth(15),
                          height: getWidth(15),
                        ),
                      )
                    ],
                  ),
                  InkWellWrapper(
                    paddingChild: const EdgeInsets.all(5),
                    borderRadius: BorderRadius.circular(20),
                    onTap: () async {
                      EasyLoading.show();
                      await SaveServiceAPI.ins.changeStatusSellerSaveListById(listId: widget.saveListId, sellerId: user[index].id!);
                      await loadData();
                    },
                    child: user[index].isSaved!  ? const Icon(Icons.favorite_outlined, size: 22, color: Colors.red) : const Icon(Icons.favorite_border_outlined, size: 22),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: getHeight(8), bottom: getHeight(4)),
                child: Text(
                  user[index].name ?? '',
                  style: TextStyle(
                    fontSize: getFont(17),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                user[index].description ?? '',
                style: TextStyle(
                  fontSize: getFont(14),
                ),
              ),
              SizedBox(height: getHeight(50)),
              Text(
                'Lever 2 Seller',
                style: TextStyle(fontSize: getFont(14), color: AppColors.primaryBlack.withOpacity(0.6)),
              ),
              SizedBox(height: getHeight(10)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: AppColors.rajah, size: 16),
                  Padding(
                      padding: EdgeInsets.only(left: getWidth(3), right: getWidth(3), top: getHeight(3)),
                      child: Text(user[index].ratingAvg?.toStringAsFixed(2) ?? '0', style: TextStyle(color: AppColors.rajah, fontSize: 14, fontWeight: FontWeight.w700))),
                  Padding(
                    padding: EdgeInsets.only(top: getHeight(3)),
                    child: Text("(${user[index].ratingCount ?? 0})", style: TextStyle(color: AppColors.metallicSilver, fontSize: 14)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ) : const SizedBox.shrink();
  }
}
