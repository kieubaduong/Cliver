import 'package:cliver_mobile/app/core/utils/utils.dart';
import 'package:cliver_mobile/app/features/payment/payment_controller.dart';
import 'package:cliver_mobile/app/features/payment/widgets/add_payment_method.dart';
import 'package:cliver_mobile/app/features/payment/widgets/order_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/values/app_colors.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  late PaymentController paymentController;
  final f = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    bool isCustomPackage = Get.arguments[1];
    if (isCustomPackage) {
      paymentController = Get.put(PaymentController());
      paymentController.post = Get.arguments[2];
      paymentController.order = Get.arguments[4];
    } else {
      paymentController = Get.find<PaymentController>();
    }
    paymentController.isContinueOrder = Get.arguments[3];

    paymentController.package = Get.arguments[0];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            ),
          ),
          title: const Text(
            "Order Review",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 1,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Image and text about order
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    SizedBox(
                      height: context.height * 0.1,
                      width: context.width * 0.3,
                      child: Image.network(
                        paymentController.post!.images![0],
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Text(
                        paymentController.post?.title ?? "title null",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 1,
                color: Colors.black,
              ),
              AddPaymentMethod(),
              const Divider(
                height: 1,
                color: Colors.black,
              ),
              //Order details
              OrderDetails(),
              const Divider(
                height: 1,
                color: Colors.black,
              ),
              const Divider(
                height: 1,
                color: Colors.black,
              ),
              //Total & Delivery Date
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Total",
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
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Delivery Date",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          f.format(DateTime.now()
                            ..add(Duration(
                                days: paymentController.package?.deliveryDays ??
                                    -10))),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Button add payment method
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => paymentController.addPaymentMethod(),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.primaryColor),
                    ),
                    child: const Text(
                      "Add payment method",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                "Your payment information is secure",
                style: TextStyle(
                  color: AppColors.lightGreyColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
