import '../../../../core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../features.dart';

class cardEarn extends StatelessWidget {
  const cardEarn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final earningController = Get.put(EarningController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: context.screenSize.height * 0.02),
        const Text(
          "Earnings",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Personal balance".tr,
                          style: TextStyle(
                              fontSize: context.screenSize.width * 0.03),
                        ),
                        Text(
                          FormatHelper().moneyFormat(
                                  earningController.totalBalance.value) ??
                              "0",
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Avg. selling price".tr,
                          style: TextStyle(
                              fontSize: context.screenSize.width * 0.03),
                        ),
                        Text(
                          FormatHelper().moneyFormat(earningController
                                  .analytics.value.avgSellingPrice
                                  .toInt()) ??
                              "",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pending clearance".tr,
                          style: TextStyle(
                              fontSize: context.screenSize.width * 0.03),
                        ),
                        Text(
                          FormatHelper().moneyFormat(earningController
                                  .revenues.value.pendingClearance) ??
                              "",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${'Earning in'.tr} ${DateFormat("MMMM").format(DateTime.now())}",
                          style: TextStyle(
                              fontSize: context.screenSize.width * 0.03),
                        ),
                        Text(
                          FormatHelper().moneyFormat(earningController
                                  .analytics.value.earningInMonth) ??
                              "",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Active orders".tr,
                          style: TextStyle(
                              fontSize: context.screenSize.width * 0.03),
                        ),
                        Text(
                          earningController.analytics.value.activeOrders
                              .toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Cancelled orders".tr,
                          style: TextStyle(
                              fontSize: context.screenSize.width * 0.03),
                        ),
                        Text(
                          earningController.revenues.value.cancelledOrders
                              .toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
