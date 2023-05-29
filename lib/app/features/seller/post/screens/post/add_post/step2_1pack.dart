import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../../../../../data/models/model.dart';
import '../../../../../../../data/services/services.dart';
import '../../../../../../core/core.dart';
import '../../../../../features.dart';

class Step2_1pack extends StatefulWidget {
  const Step2_1pack({Key? key}) : super(key: key);

  @override
  State<Step2_1pack> createState() => _Step2_1packState();
}

class _Step2_1packState extends State<Step2_1pack>
    with SingleTickerProviderStateMixin {
  late var _controller;
  final PostController _postController = Get.find();
  final StepController _stepController = Get.find();

  PackageController onePack = PackageController();

  @override
  void initState() {
    _controller = TabController(length: 1, vsync: this);
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
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          PackageDetail(packageController: onePack),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ElevatedButton(
          onPressed: () async {
            if (onePack.isValidData()) {
              List<Package> listpack = [];
              Package package = Package(
                name: onePack.packageName.text.trim(),
                description: onePack.packageDes.text.trim(),
                deliveryDays: onePack.deliveryDays,
                numberOfRevisions: onePack.revisions,
                price: int.tryParse(
                    onePack.price.text.replaceAll(RegExp(r"\D"), "")),
                type: "Basic",
              );
              listpack.add(package);

              Post upPost = Post(
                id: _postController.currentPost.id,
                packages: listpack,
                hasOfferPackages: false,
              );

              EasyLoading.show();
              var res = await PostService.ins.putPostStep(post: upPost);
              EasyLoading.dismiss();
              if (res.isOk) {
                _stepController.currentIndex.value++;
              } else {
                EasyLoading.showToast(res.error,
                    toastPosition: EasyLoadingToastPosition.bottom);
              }
            } else {
              EasyLoading.showToast('enterAllInformation'.tr,
                  toastPosition: EasyLoadingToastPosition.bottom);
            }
          },
          child: const Text("Next"),
        ),
      ),
    );
  }
}
