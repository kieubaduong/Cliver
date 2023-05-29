import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common_widgets/custom_bottom_navigation_bar.dart';
import '../../../../../../core/values/app_colors.dart';
import '../../../../../features.dart';

class EditPostScreen extends StatefulWidget {
  const EditPostScreen({Key? key}) : super(key: key);

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  late List<Widget> page = [
    EditStep1(changeWidgetPackage: (value) => changeWidgetPage(value)),
    const Edit_Step2_1pack(),
    const EditStep3(),
    const EditStep4(),
  ];

  final controller = Get.put(PostController());
  final stepController = Get.put(StepController());

  @override
  void initState() {
    if (controller.currentPost.packages!.isEmpty || controller.currentPost.packages!.length == 1) {
      stepController.isThreePack.value = false;
    } else {
      stepController.isThreePack.value = true;
    }
    super.initState();
  }

  void changeWidgetPage(bool isThreePackage) {
    if (isThreePackage) {
      setState(() {
        page[1] = const Edit_Step2_3pack();
        controller.currentPost.hasOfferPackages = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit your post".tr),
          actions: [
            Obx(
              () => Visibility(
                visible: stepController.currentIndex.value == 1 ? true : false,
                child: Row(
                  children: [
                    const Text(
                      "3 PACKS",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Checkbox(
                      activeColor: AppColors.primaryColor,
                      value: stepController.isThreePack.value,
                      onChanged: (newValue) {
                        stepController.changeIsThreePack();
                        setState(() {
                          if (newValue!) {
                            page[1] = const Edit_Step2_3pack();
                            controller.currentPost.hasOfferPackages = true;
                          } else {
                            page[1] = const Edit_Step2_1pack();
                            controller.currentPost.hasOfferPackages = false;
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: Obx(
          () => page[stepController.currentIndex.value],
        ),
        bottomNavigationBar: buildStepper(),
      ),
    );
  }

  Widget buildStepper() {
    return Obx(
      () => BottomNavigationBarCustom(
        showElevation: true,
        items: <BottomNavigationBarCustomItem>[
          BottomNavigationBarCustomItem(
            title: 'Overview',
            icon: const Icon(Icons.reorder),
            inactiveColor: AppColors.secondaryColor,
            activeColor: AppColors.selectedNavBarColor,
            childColor: AppColors.itemChildColor,
          ),
          BottomNavigationBarCustomItem(
            title: "Packages",
            icon: const Icon(Icons.list),
            inactiveColor: AppColors.secondaryColor,
            activeColor: AppColors.selectedNavBarColor,
            childColor: AppColors.itemChildColor,
          ),
          BottomNavigationBarCustomItem(
            title: 'Description',
            icon: const Icon(Icons.description_outlined),
            inactiveColor: AppColors.secondaryColor,
            activeColor: AppColors.selectedNavBarColor,
            childColor: AppColors.itemChildColor,
          ),
          BottomNavigationBarCustomItem(
            title: "Gallery",
            icon: const Icon(Icons.collections),
            inactiveColor: AppColors.secondaryColor,
            activeColor: AppColors.selectedNavBarColor,
            childColor: AppColors.itemChildColor,
          ),
        ],
        onItemSelected: (index) {
          //do nothing here
        },
        selectedIndex: stepController.currentIndex.value,
      ),
    );
  }
}
