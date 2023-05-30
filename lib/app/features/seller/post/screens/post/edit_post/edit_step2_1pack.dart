import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../../data/models/model.dart';
import '../../../../../../core/core.dart';
import '../../../../../features.dart';

class Edit_Step2_1pack extends StatefulWidget {
  const Edit_Step2_1pack({Key? key}) : super(key: key);

  @override
  State<Edit_Step2_1pack> createState() => Edit_Step2_1packState();
}

class Edit_Step2_1packState extends State<Edit_Step2_1pack>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  final PostController _postController = Get.find();
  final StepController _stepController = Get.find();

  PackageController onePack = PackageController();

  @override
  void initState() {
    _controller = TabController(length: 1, vsync: this);
    if(_postController.currentPost.packages!.isNotEmpty) {
      onePack.packageName.text = _postController.currentPost.packages![0].name!;
      onePack.packageDes.text = _postController.currentPost.packages![0].description!;
      onePack.deliveryDays = _postController.currentPost.packages![0].deliveryDays!;
      onePack.revisions = _postController.currentPost.packages![0].numberOfRevisions!;
      onePack.price.text = "${NumberFormat("#,##0", "vi_VN").format(_postController.currentPost.packages![0].price!)} VND(đ)";
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
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          EditPackageDetail(packageController: onePack),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ElevatedButton(
          onPressed: () async {
            if (onePack.isValidData()) {
              Package package = Package(
                name: onePack.packageName.text.trim(),
                description: onePack.packageDes.text.trim(),
                deliveryDays: onePack.deliveryDays,
                numberOfRevisions: onePack.revisions,
                price: int.tryParse(onePack.price.text.replaceAll(RegExp(r"\D"), "")),
                type: "Basic",
              );
              _postController.currentPost.packages![0] = package;
              _stepController.currentIndex.value++;
            } else {
              EasyLoading.showToast('enterAllInformation'.tr, toastPosition: EasyLoadingToastPosition.bottom);
            }
          },
          child: const Text("Next"),
        ),
      ),
    );
  }
}
