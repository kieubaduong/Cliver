import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/core.dart';
import '../../features.dart';

class OrderDetails extends StatelessWidget {
  OrderDetails({super.key});
  final paymentController = Get.find<PaymentController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                "Order details",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => paymentController.showOrderDetails(),
                child: Obx(
                  () => Transform.rotate(
                    angle: (paymentController.isOrderDetailsClosed.value)
                        ? -math.pi / 180.0 * -90
                        : -math.pi / 180.0 * 90,
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(
            () => Visibility(
              visible: !paymentController.isOrderDetailsClosed.value,
              child: SizedBox(
                height: context.height * 0.08,
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Icon(
                        Icons.check,
                        color: AppColors.primaryColor,
                        size: 25,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            paymentController.package?.name as String,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "Revisions",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          FormatHelper()
                              .moneyFormat(paymentController.package?.price)
                              .toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "${paymentController.package?.numberOfRevisions}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
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
    );
  }
}
