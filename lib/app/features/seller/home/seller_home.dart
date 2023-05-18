import 'package:cliver_mobile/app/common_widgets/circle_avatar_online.dart';
import 'package:cliver_mobile/app/controller/user_controller.dart';
import 'package:cliver_mobile/app/core/utils/utils.dart';
import 'package:cliver_mobile/app/core/values/app_colors.dart';
import 'package:cliver_mobile/app/features/seller/home/widgets/card_earn.dart';
import 'package:cliver_mobile/app/features/seller/home/widgets/card_post.dart';
import 'package:cliver_mobile/app/features/seller/home/widgets/custom_circular_progress_bar.dart';
import 'package:cliver_mobile/app/features/seller/home/widgets/custom_expanded.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../earning/earning_controller.dart';

class SellerHome extends StatefulWidget {
  const SellerHome({Key? key}) : super(key: key);

  @override
  State<SellerHome> createState() => _SellerHomeState();
}

class _SellerHomeState extends State<SellerHome> {
  final UserController _userController = Get.find();
  final _earningController = Get.put(EarningController())..getEarningData();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              //USER NAME
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: context.screenSize.height * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomCircleAvatar(
                      isOnline: _userController.currentUser.value.isActive!,
                    ),
                    const SizedBox(width: 5),
                    Text(_userController.currentUser.value.name ?? "")
                  ],
                ),
              ),

              //summary statistic
              Column(
                children: [
                  Container(
                    color: const Color(0xff2A2B2E),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.screenSize.width * 0.03,
                          vertical: context.screenSize.height * 0.01),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Here is how you're doing".tr,
                                style: const TextStyle(color: Colors.white),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {},
                                child: const Icon(
                                  Icons.help_outline,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          // const SizedBox(height: 5),
                          // Row(
                          //   children: [
                          //     Text(
                          //       "Seller level".tr,
                          //       style: const TextStyle(color: Colors.white),
                          //     ),
                          //     const Spacer(),
                          //     Text(
                          //       "New Seller".tr,
                          //       style: const TextStyle(
                          //           color: Colors.white,
                          //           fontWeight: FontWeight.bold),
                          //     ),
                          //   ],
                          // ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                "Next evaluation".tr,
                                style: const TextStyle(color: Colors.white),
                              ),
                              const Spacer(),
                              Text(
                                "Feb 25, 2023".tr,
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                "Response time".tr,
                                style: const TextStyle(color: Colors.white),
                              ),
                              const Spacer(),
                              Text(
                                "1 hour".tr,
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                CustomCircularBar(
                                  value: 0.8,
                                  label: "Response\ntime",
                                ),
                                CustomCircularBar(
                                  value: 0.6,
                                  label: "Order\ncompletion",
                                ),
                                CustomCircularBar(
                                  value: 0.4,
                                  label: "On-time\ndelivery",
                                ),
                                CustomCircularBar(
                                  value: 0.5,
                                  label: "Positive\nrating",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomExpanded(),
                ],
              ),

              //CARD AREA
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: const [
                    cardEarn(),
                    // cardTodo(),
                    cardPost(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
