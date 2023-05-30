import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../controller/controller.dart';
import '../../../core/core.dart';
import '../../features.dart';

class EarningScreen extends StatefulWidget {
  const EarningScreen({Key? key}) : super(key: key);

  @override
  State<EarningScreen> createState() => _EarningScreenState();
}

class _EarningScreenState extends State<EarningScreen> {
  final _controller = Get.put(EarningController())..getEarningData();

  double myOpac = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Earnings".tr),
        actions: [
          Obx(() {
            if (_controller.analytics.value.availableForWithdrawal > 0) {
              return TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) => _buildInputMoneyDialog(context));
                },
                child: Text("Withdraw".tr),
              );
            }
            return TextButton(
              onPressed: null,
              child: Text("Withdraw".tr),
            );
          }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Obx(
              () => Text(
                FormatHelper().moneyFormat(_controller.totalBalance.value) ??
                    "0",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              "Personal balance".tr,
              textAlign: TextAlign.center,
            ),
            //ANALYTICS
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "Analytics".tr,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Obx(
              () => Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                              "${'Earning in'.tr} ${DateFormat("MMMM").format(DateTime.now())}"),
                          const Spacer(),
                          Text(
                            FormatHelper().moneyFormat(_controller
                                    .analytics.value.earningInMonth) ??
                                "",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text("Avg. selling price".tr),
                          const Spacer(),
                          Text(
                            FormatHelper().moneyFormat(_controller
                                    .analytics.value.avgSellingPrice
                                    .toInt()) ??
                                "",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text("Active orders".tr),
                          const Spacer(),
                          Text(
                            _controller.analytics.value.activeOrders.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text("Available for withdrawal".tr),
                          const Spacer(),
                          Text(
                            FormatHelper().moneyFormat(_controller
                                    .analytics.value.availableForWithdrawal) ??
                                "",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text("Completed orders".tr),
                          const Spacer(),
                          Text(
                            _controller.analytics.value.completedOrders
                                .toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            //REVENUES
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "Revenues".tr,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Obx(
              () => Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Cancelled orders".tr),
                          const Spacer(),
                          Text(
                            _controller.revenues.value.cancelledOrders
                                .toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text("Pending clearance".tr),
                          const Spacer(),
                          Text(
                            FormatHelper().moneyFormat(_controller
                                    .revenues.value.pendingClearance) ??
                                "",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text("Withdrawed money".tr),
                          const Spacer(),
                          Text(
                            FormatHelper().moneyFormat(
                                    _controller.revenues.value.withdrawn) ??
                                "",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text("Used for purchases".tr),
                          const Spacer(),
                          Text(
                            FormatHelper().moneyFormat(_controller
                                    .revenues.value.usedForPurchases) ??
                                "",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text("Cleared".tr),
                          const Spacer(),
                          Text(
                            FormatHelper().moneyFormat(
                                    _controller.revenues.value.cleared) ??
                                "",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildInputMoneyDialog(BuildContext context) {
    _controller.amount = "";
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Input the amount you want to draw".tr),
          const SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (val) => _controller.amount = val.trim(),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              if (_controller.amount.isEmpty) {
                EasyLoading.showToast("Please enter the amount",
                    toastPosition: EasyLoadingToastPosition.bottom);
                return;
              }
              try {
                var temp = double.parse(_controller.amount);
                if (temp <= 0) {
                  EasyLoading.showToast("The amount must greater than zero".tr,
                      toastPosition: EasyLoadingToastPosition.bottom);
                  return;
                }
              } catch (e) {
                EasyLoading.showToast("Please enter valid amount".tr,
                    toastPosition: EasyLoadingToastPosition.bottom);
                return;
              }
              if (int.parse(_controller.amount) >
                  _controller.totalBalance.value) {
                EasyLoading.showToast("Invalid amount",
                    toastPosition: EasyLoadingToastPosition.bottom);
                return;
              }
              var res = await _controller.performRequest();
              if (res) {
                Get.back();
                _controller.getEarningData();
                showDialog(context: context, builder: (_) => _successDialog());
                await _controller.getEarningData();
                Get.find<UserController>().currentUser.value.wallet?.balance =
                    _controller.totalBalance.value;
              } else {}
            },
            child: Text("Confirm".tr),
          )
        ],
      ),
    );
  }

  _successDialog() {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TweenAnimationBuilder(
            onEnd: () {
              setState(() {
                myOpac = 1;
              });
            },
            curve: Curves.bounceOut,
            duration: const Duration(milliseconds: 1000),
            tween: Tween<Size>(
                begin: const Size(5, 5), end: MediaQuery.of(context).size),
            builder: (BuildContext context, dynamic value, Widget? child) {
              return Image.asset(
                "assets/icons/success_icon.png",
                height: value.height / 5,
              );
            },
          ),
          const SizedBox(height: 10),
          Text(
            "- ${FormatHelper().moneyFormat(int.parse(_controller.amount))}",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
