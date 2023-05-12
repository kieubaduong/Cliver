import 'package:cliver_mobile/app/controller/user_controller.dart';
import 'package:cliver_mobile/app/core/utils/utils.dart';
import 'package:cliver_mobile/app/features/payment/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/app_colors.dart';

class BudgetPayment extends StatefulWidget {
  const BudgetPayment({super.key});

  @override
  State<BudgetPayment> createState() => _BudgetPaymentState();
}

class _BudgetPaymentState extends State<BudgetPayment> {
  final paymentController = Get.find<PaymentController>();
  final userController = Get.find<UserController>();

  @override
  void initState() {
    paymentController.balance =
        userController.currentUser.value.wallet?.balance;
    int? temp = paymentController.package?.price;
    paymentController.remaining = paymentController.balance! - temp!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Get.back();
              paymentController.paymentMessage.value = "";
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          title: const Text(
            "Budget Payment",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    "Account balance",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    FormatHelper()
                        .moneyFormat(paymentController.balance)
                        .toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    "Total cost",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    FormatHelper()
                        .moneyFormat(paymentController.package?.price)
                        .toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    "Remaining",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    FormatHelper()
                        .moneyFormat(paymentController.remaining)
                        .toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => paymentController.payWithBudget(),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.primaryColor),
                  ),
                  child: const Text(
                    "Pay",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Obx(
                () => Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    paymentController.paymentMessage.value,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
