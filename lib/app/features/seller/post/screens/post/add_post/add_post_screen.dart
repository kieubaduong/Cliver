import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common_widgets/custom_bottom_navigation_bar.dart';
import '../../../../../../core/values/app_colors.dart';
import '../../../../../features.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  List<Widget> page = [
    const Step1(),
    const Step2_1pack(),
    const Step3(),
    const Step4(),
  ];

  final _controller = Get.put(PostController());
  final _stepController = Get.put(StepController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Create a new post"),
          actions: [
            Obx(
              () => Visibility(
                visible: _stepController.currentIndex.value == 1 ? true : false,
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
                      value: _stepController.isThreePack.value,
                      onChanged: (newValue) {
                        _stepController.changeIsThreePack();

                        setState(() {
                          if (newValue!) {
                            page[1] = const Step2_3pack();
                            _controller.currentPost.hasOfferPackages = true;
                          } else {
                            page[1] = const Step2_1pack();
                            _controller.currentPost.hasOfferPackages = false;
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
          () => page[_stepController.currentIndex.value],
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
        selectedIndex: _stepController.currentIndex.value,
      ),
    );
  }
}
