import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../../data/models/model.dart';
import '../../../../../../core/core.dart';
import '../../../../../features.dart';

class Edit_Step2_3pack extends StatefulWidget {
  const Edit_Step2_3pack({Key? key}) : super(key: key);

  @override
  State<Edit_Step2_3pack> createState() => Edit_Step2_3packState();
}

class Edit_Step2_3packState extends State<Edit_Step2_3pack>
    with SingleTickerProviderStateMixin {
  late var _controller;
  final PostController _postController = Get.find();
  final StepController _stepController = Get.find();

  List<PackageController> threePackController = [
    PackageController(),
    PackageController(),
    PackageController(),
  ];

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    if (_postController.currentPost.packages!.length == 3) {
      for (int index = 0; index < 3; index++) {
        threePackController[index].packageName.text =
            _postController.currentPost.packages![index].name!;
        threePackController[index].packageDes.text =
            _postController.currentPost.packages![index].description!;
        threePackController[index].deliveryDays =
            _postController.currentPost.packages![index].deliveryDays!;
        threePackController[index].revisions =
            _postController.currentPost.packages![index].numberOfRevisions!;
        threePackController[index].price.text =
            "${NumberFormat("#,##0", "vi_VN").format(_postController.currentPost.packages![index].price!)} VND(đ)";
      }
    } else if (_postController.currentPost.packages!.length == 1) {
      threePackController[0].packageName.text =
          _postController.currentPost.packages![0].name!;
      threePackController[0].packageDes.text =
          _postController.currentPost.packages![0].description!;
      threePackController[0].deliveryDays =
          _postController.currentPost.packages![0].deliveryDays!;
      threePackController[0].revisions =
          _postController.currentPost.packages![0].numberOfRevisions!;
      threePackController[0].price.text =
          "${NumberFormat("#,##0", "vi_VN").format(_postController.currentPost.packages![0].price!)} VND(đ)";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TabBar(
          controller: _controller,
          indicator: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 0.5, color: AppColors.primaryColor),
            ),
          ),
          tabs: const [
            Tab(
              text: "Basic",
            ),
            Tab(
              text: "Standard",
            ),
            Tab(
              text: "Premium",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          EditPackageDetail(
            packageController: threePackController[0],
          ),
          EditPackageDetail(
            packageController: threePackController[1],
          ),
          EditPackageDetail(
            packageController: threePackController[2],
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ElevatedButton(
          onPressed: () async {
            for (int i = 0; i < 3; i++) {
              if (!threePackController[i].isValidData()) {
                EasyLoading.showToast('enterAllInformation'.tr,
                    toastPosition: EasyLoadingToastPosition.bottom);
                return;
              }
            }

            for (int i = 0; i < 3; i++) {
              String type = "";
              switch (i) {
                case 0:
                  type = "Basic";
                  break;
                case 1:
                  type = "Standard";
                  break;
                case 2:
                  type = "Premium";
                  break;
              }

              Package package = Package(
                name: threePackController[i].packageName.text.trim(),
                description: threePackController[i].packageDes.text.trim(),
                deliveryDays: threePackController[i].deliveryDays,
                numberOfRevisions: threePackController[i].revisions,
                price: int.tryParse(threePackController[i]
                    .price
                    .text
                    .replaceAll(RegExp(r"\D"), "")),
                type: type,
              );
              _postController.currentPost.packages![i] = package;
              _postController.currentPost.hasOfferPackages = true;
            }
            _stepController.currentIndex.value++;
          },
          child: const Text("Next"),
        ),
      ),
    );
  }
}
