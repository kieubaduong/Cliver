import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../../../../../data/models/model.dart';
import '../../../../../../../data/services/services.dart';
import '../../../../../../core/core.dart';
import '../../../../../features.dart';

class Step2_3pack extends StatefulWidget {
  const Step2_3pack({Key? key}) : super(key: key);

  @override
  State<Step2_3pack> createState() => _Step2_3packState();
}

class _Step2_3packState extends State<Step2_3pack>
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
          PackageDetail(
            packageController: threePackController[0],
          ),
          PackageDetail(
            packageController: threePackController[1],
          ),
          PackageDetail(
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

            List<Package> listPackage = [];
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

              listPackage.add(package);
            }

            Post upPost = Post(
              id: _postController.currentPost.id,
              packages: listPackage,
              hasOfferPackages: true,
            );

            EasyLoading.show();
            var res = await PostService.ins.putPostStep(post: upPost);
            EasyLoading.dismiss();

            if (res.isOk) {
              _postController.currentPost = upPost;
              _stepController.currentIndex.value++;
            } else {
              EasyLoading.showToast(res.error,
                  toastPosition: EasyLoadingToastPosition.bottom);
            }
          },
          child: const Text("Next"),
        ),
      ),
    );
  }
}
