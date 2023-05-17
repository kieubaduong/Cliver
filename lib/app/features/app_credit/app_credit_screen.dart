import 'package:cliver_mobile/data/models/credit_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../controller/user_controller.dart';
import '../../core/utils/utils.dart';
import '../../core/values/app_colors.dart';
import 'credit_controller.dart';

class InAppCreditScreen extends StatefulWidget {
  const InAppCreditScreen({Key? key}) : super(key: key);

  @override
  State<InAppCreditScreen> createState() => _InAppCreditScreenState();
}

class _InAppCreditScreenState extends State<InAppCreditScreen> {
  final _controller = Get.put(CreditController())..getData();
  double myOpac = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My credit".tr),
        actions: [
          TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => _buildInputMoneyDialog(context));
            },
            child: Text("Deposit".tr),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Obx(
            () => Text(
              FormatHelper().moneyFormat(_controller.totalBalance.value) ?? "",
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
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "History".tr,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () => ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (ctx, i) =>
                        _buildHistoryItem(_controller.listHistory[i]),
                    itemCount: _controller.listHistory.length,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildHistoryItem(CreditHistory value) {
    String prefixSign = "-";

    switch (value.type) {
      case "Payment":
        prefixSign = "-";
        break;
      case "Deposit":
        prefixSign = "+";
        break;
      case "Refund":
        prefixSign = "+";
        break;
      case "Withdrawal ":
        prefixSign = "-";
        break;
    }

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value.type?.tr ?? ""),
          Text(value.description ?? ""),
        ],
      ),
      isThreeLine: true,
      subtitle: Text(FormatHelper().getTimeAgo(value.createdAt) ?? ""),
      trailing: Text(
        "$prefixSign ${FormatHelper().moneyFormat(value.amount) ?? "0"}",
        style: TextStyle(
          color: prefixSign == "+" ? Colors.green : Colors.redAccent,
        ),
      ),
    );
  }

  Widget _buildInputMoneyDialog(context) {
    _controller.amount = "";
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Input the amount you want".tr),
          const SizedBox(height: 10),
          TextField(
            decoration: const InputDecoration(
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
                EasyLoading.showToast("Please enter the amount".tr,
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
              var res = await _controller.performRequest();
              if (res) {
                Get.back();
                _controller.getData();
                await showDialog(
                    context: context, builder: (_) => _successDialog());
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
            "+ ${FormatHelper().moneyFormat(int.parse(_controller.amount))}",
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
