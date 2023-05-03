import 'package:cliver_mobile/app/features/buyer/order/buyer_order_controller.dart';
import 'package:cliver_mobile/app/features/buyer/order/widgets/card_order_detail.dart';
import 'package:cliver_mobile/app/features/buyer/order/widgets/buyer_order_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/models/order.dart';

class BuyerOrderDetail extends StatefulWidget {
  const BuyerOrderDetail({Key? key}) : super(key: key);

  @override
  State<BuyerOrderDetail> createState() => _BuyerOrderDetailState();
}

class _BuyerOrderDetailState extends State<BuyerOrderDetail> {
  final orderId = Get.arguments[0];
  final buyerOrderController = Get.find<BuyerOrderController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Icon(Icons.message_sharp),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: FutureBuilder(
        future: buyerOrderController.getOrder(orderId: orderId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == null) {
              return const Center(child: Text("Server error"));
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CardOrderDetail(
                      order: snapshot.data as Order,
                      isBuyer: true,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Time line".tr,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Divider(thickness: 1),
                    BuyerOrderTimeline(order: snapshot.data as Order)
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
