import 'package:cliver_mobile/app/features/buyer/order/buyer_order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/models/order.dart';
import '../../../../common_widgets/horizontal_order_item.dart';
import '../../../../routes/routes.dart';

class BuyerOrderScreen extends StatefulWidget {
  const BuyerOrderScreen({Key? key}) : super(key: key);

  @override
  State<BuyerOrderScreen> createState() => _BuyerOrderScreenState();
}

class _BuyerOrderScreenState extends State<BuyerOrderScreen> {
  var currentFilter = 0;
  final buyerOrderController = Get.put(BuyerOrderController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => setState(() {}),
          child: Text(
            "Manage orders".tr,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              showBottom();
            },
            child: const Icon(Icons.filter_list),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: buyerOrderController.getAllOrders(),
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  RxList<Order> listOrder = snapshot.data as RxList<Order>;
                  if (listOrder.isNotEmpty) {
                    return Obx(() {
                      if (buyerOrderController.orders.isNotEmpty) {
                        return ListView.builder(
                          itemBuilder: (_, index) {
                            final Order order =
                                buyerOrderController.orders[index];
                            return HorizontalOrderItem(
                              order: order,
                              getImageFuture:
                                  buyerOrderController.getOrderImage(
                                      postId: order.package?.postId as int),
                              onTap: () => toOrderDetailScreen(order.id as int),
                            );
                          },
                          itemCount: buyerOrderController.orders.length,
                        );
                      } else {
                        return Center(child: Text("You have no order yet".tr));
                      }
                    });
                  } else {
                    return Center(child: Text("You have no order yet".tr));
                  }
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  void showBottom() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Wrap(
            children: [
              Text(
                "sort by".tr,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 50),
              buildSelectionRow(Icons.format_list_bulleted_outlined, "All".tr,
                  () {
                currentFilter = 0;
                Navigator.pop(context);
                buyerOrderController.getBuyerOrderByStatus(orderStatus: null);
              }, 0),
              const Divider(height: 20),
              buildSelectionRow(Icons.pending_outlined, "Pending payment".tr,
                  () {
                currentFilter = 1;
                Navigator.pop(context);
                buyerOrderController.getBuyerOrderByStatus(
                    orderStatus: "PendingPayment");
              }, 1),
              const Divider(height: 20),
              buildSelectionRow(Icons.edit_outlined, "Created".tr, () {
                currentFilter = 2;
                Navigator.pop(context);
                buyerOrderController.getBuyerOrderByStatus(
                    orderStatus: "Created");
              }, 2),
              const Divider(height: 20),
              buildSelectionRow(Icons.work_outline, "Doing".tr, () {
                currentFilter = 3;
                Navigator.pop(context);
                buyerOrderController.getBuyerOrderByStatus(
                    orderStatus: "Doing");
              }, 3),
              const Divider(height: 20),
              buildSelectionRow(Icons.local_shipping_outlined, "Delivered".tr,
                  () {
                currentFilter = 4;
                Navigator.pop(context);
                buyerOrderController.getBuyerOrderByStatus(
                    orderStatus: "Delivered");
              }, 4),
              const Divider(height: 20),
              buildSelectionRow(Icons.done_all, "Completed".tr, () {
                currentFilter = 5;
                Navigator.pop(context);
                buyerOrderController.getBuyerOrderByStatus(
                    orderStatus: "Completed");
              }, 5),
              const Divider(height: 20),
              buildSelectionRow(Icons.cancel_outlined, "Cancelled".tr, () {
                currentFilter = 6;
                Navigator.pop(context);
                buyerOrderController.getBuyerOrderByStatus(
                    orderStatus: "Cancelled");
              }, 6),
            ],
          ),
        );
      },
    );
  }

  buildSelectionRow(icon, title, VoidCallback onTap, i) {
    final index = i;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(),
      child: Row(
        children: [
          Icon(
            icon,
          ),
          const SizedBox(width: 20),
          Text(
            title,
          ),
          const Spacer(),
          Visibility(
            visible: currentFilter == index ? true : false,
            child: const Icon(
              Icons.check,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> toOrderDetailScreen(int orderId) async {
    await Get.toNamed(buyerOrderDetailScreenRoute, arguments: [orderId]);
    switch (currentFilter) {
      case 0:
        buyerOrderController.getBuyerOrderByStatus(orderStatus: null);
        break;
      case 1:
        buyerOrderController.getBuyerOrderByStatus(
            orderStatus: "PendingPayment");
        break;
      case 2:
        buyerOrderController.getBuyerOrderByStatus(orderStatus: "Created");
        break;
      case 3:
        buyerOrderController.getBuyerOrderByStatus(orderStatus: "Doing");
        break;
      case 4:
        buyerOrderController.getBuyerOrderByStatus(orderStatus: "Delivered");
        break;
      case 5:
        buyerOrderController.getBuyerOrderByStatus(orderStatus: "Completed");
        break;
      case 6:
        buyerOrderController.getBuyerOrderByStatus(orderStatus: "Cancelled");
        break;
      default:
    }
  }
}
