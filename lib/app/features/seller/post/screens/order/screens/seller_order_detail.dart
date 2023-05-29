import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../data/models/model.dart';
import '../../../../../features.dart';

class SellerOrderDetail extends StatefulWidget {
  const SellerOrderDetail({Key? key}) : super(key: key);

  @override
  State<SellerOrderDetail> createState() => _SellerOrderDetailState();
}

class _SellerOrderDetailState extends State<SellerOrderDetail> {
  final orderId = Get.arguments[0];
  final orderController = Get.find<SellerOrderController>();

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
        future: orderController.getOrder(orderId: orderId),
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
                      isBuyer: false,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Time line".tr,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Divider(thickness: 1),
                    SellerOrderTimeline(order: snapshot.data as Order)
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
