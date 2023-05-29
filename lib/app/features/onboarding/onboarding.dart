import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/core.dart';
import '../../routes/routes.dart';
import 'widgets/buildPage.dart';


class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final controller = PageController();
  bool isEndBoarding = false;

  @override
  void initState() {
    super.initState();
    PermissionHelper().requestPermissions();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(bottom: 80),
          child: Stack(
            children: [
              PageView(
                controller: controller,
                onPageChanged: enableSkipBtn,
                children: [
                  BuildPage(
                    title: "Explore Jobs".tr,
                    image: "assets/images/board1.png",
                    des: "Discover jobs around the world\nwherever you are",
                  ),
                  BuildPage(
                      title: "Choose a Freelancer".tr,
                      image: "assets/images/board2.png",
                      des:
                          "Select a guy for your needs easily\nand know the exact cost of the job"),
                  BuildPage(
                      title: "World Wide Communication".tr,
                      image: "assets/images/board3.png",
                      des: "Finally, get ready because we work really fast"),
                ],
              ),
              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () {
                    showLanguageDialog(context);
                  },
                  child: const Icon(
                    Icons.language_outlined,
                    size: 30,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 5,
                child: Visibility(
                  visible: isEndBoarding,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () async {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.setBool("isFirstTime", false);

                        if (!mounted) return;
                        Get.offAllNamed(loginScreenRoute);
                      },
                      child: Text(
                        "Let's go",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomSheet: Container(
          decoration: BoxDecoration(color: AppColors.backgroundColor),
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: 140,
          child: Center(
            child: SmoothPageIndicator(
              controller: controller,
              count: 3,
              effect: ExpandingDotsEffect(
                dotColor: AppColors.secondaryColor,
                activeDotColor: AppColors.primaryColor,
                dotWidth: 28,
                dotHeight: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void enableSkipBtn(int index) {
    setState(() {
      if (index == 2) {
        isEndBoarding = true;
      } else {
        isEndBoarding = false;
      }
    });
  }
}
