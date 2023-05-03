import 'package:cliver_mobile/app/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../data/models/order.dart';

class CardOrderDetail extends StatelessWidget {
  const CardOrderDetail(
      {super.key, required this.order, required this.isBuyer});
  final Order order;
  final bool isBuyer;

  @override
  Widget build(BuildContext context) {
    final oCcy = NumberFormat("#,##0", "vi_VN");
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        dense: true,
        title: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 20),
              child: Icon(
                Icons.inventory_2_outlined,
                color: Colors.blueAccent,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    order.package?.name as String,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(order.package?.description as String),
                  Row(
                    children: [
                      Text("${'Total'.tr}:"),
                      const Spacer(),
                      Text(FormatHelper()
                          .moneyFormat(order.package?.price)
                          .toString()),
                    ],
                  ),
                  Row(
                    children: [
                      Text(isBuyer ? "${'Seller'.tr}:" : "${'Buyer'.tr}:"),
                      const Spacer(),
                      Text(" ${order.seller?.name}"),
                    ],
                  ),
                  Row(
                    children: [
                      Text("${'Date ordered'.tr}:"),
                      const Spacer(),
                      Text(FormatHelper()
                          .dateFormat(order.createdAt)
                          .toString()),
                    ],
                  ),
                  Row(
                    children: [
                      Text("${'Revision times'.tr}:"),
                      const Spacer(),
                      Text("${order.revisionTimes}"),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "${'Revision times left'.tr}:",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        order.leftRevisionTimes.toString(),
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "${'Payment method'.tr}:",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        order.paymentMethod.toString(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
