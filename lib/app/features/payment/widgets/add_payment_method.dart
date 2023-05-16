import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/app_colors.dart';
import '../payment_controller.dart';

class AddPaymentMethod extends StatelessWidget {
  AddPaymentMethod({super.key});
  final paymentController = Get.find<PaymentController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 20, left: 20),
          child: Text(
            "Add payment method",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: SizedBox(
            width: double.infinity,
            child: Obx(
              () => Column(
                children: [
                  Row(
                    children: [
                      Transform.scale(
                        scale: 1.4,
                        child: Checkbox(
                          shape: const CircleBorder(),
                          fillColor:
                              MaterialStateProperty.all(AppColors.primaryColor),
                          value: paymentController.isYourBudget.value,
                          onChanged: (value) =>
                              paymentController.selectYourBudget(value!),
                        ),
                      ),
                      const SizedBox(width: 5),
                      SizedBox(
                          width: 50,
                          height: 30,
                          child: Image.asset("assets/images/wallet.png")),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          "Your budget",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Transform.scale(
                        scale: 1.4,
                        child: Checkbox(
                          shape: const CircleBorder(),
                          fillColor:
                              MaterialStateProperty.all(AppColors.primaryColor),
                          value: paymentController.isVNPay.value,
                          onChanged: (value) =>
                              paymentController.selectVNPay(value!),
                        ),
                      ),
                      const SizedBox(width: 5),
                      SizedBox(
                        width: 50,
                        height: 30,
                        child: Image.asset("assets/images/vnpay.png"),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          "VNPAY",
                          style: TextStyle(fontSize: 18, color: Colors.black),
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
    );
  }
}
