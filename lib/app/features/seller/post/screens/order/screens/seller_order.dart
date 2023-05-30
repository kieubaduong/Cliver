import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../data/models/order.dart';
import '../../../../../../common_widgets/horizontal_order_item.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../features.dart';

class SellerOrderScreen extends StatefulWidget {
  const SellerOrderScreen({Key? key}) : super(key: key);

  @override
  State<SellerOrderScreen> createState() => _SellerOrderScreenState();
}

class _SellerOrderScreenState extends State<SellerOrderScreen> {
  var currentFilter = 0;
  final sellerOrderController = Get.put(SellerOrderController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage orders".tr),
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
              future: sellerOrderController.getAllOrders(),
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  RxList<Order> listOrder = snapshot.data as RxList<Order>;
                  if (listOrder.isNotEmpty) {
                    return Obx(() {
                      if (sellerOrderController.orders.isNotEmpty) {
                        return ListView.builder(
                          itemBuilder: (_, index) {
                            final Order order =
                                sellerOrderController.orders[index];
                            return HorizontalOrderItem(
                              order: order,
                              getImageFuture:
                                  sellerOrderController.getOrderImage(
                                      postId: order.package?.postId as int),
                              onTap: () =>
                                  toOrderDetailScreen(orderId: order.id as int),
                            );
                          },
                          itemCount: sellerOrderController.orders.length,
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
      shape: RoundedRectangleBorder(
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
                sellerOrderController.getSellerOrderByStatus(orderStatus: null);
              }, 0),
              const Divider(height: 20),
              buildSelectionRow(Icons.edit_outlined, "Created".tr, () {
                currentFilter = 1;
                Navigator.pop(context);
                sellerOrderController.getSellerOrderByStatus(
                    orderStatus: "Created");
              }, 1),
              const Divider(height: 20),
              buildSelectionRow(Icons.work_outline, "Doing".tr, () {
                currentFilter = 2;
                Navigator.pop(context);
                sellerOrderController.getSellerOrderByStatus(
                    orderStatus: "Doing");
              }, 2),
              const Divider(height: 20),
              buildSelectionRow(Icons.local_shipping_outlined, "Delivered".tr,
                  () {
                currentFilter = 3;
                Navigator.pop(context);
                sellerOrderController.getSellerOrderByStatus(
                    orderStatus: "Delivered");
              }, 3),
              const Divider(height: 20),
              buildSelectionRow(Icons.done_all, "Completed".tr, () {
                currentFilter = 4;
                Navigator.pop(context);
                sellerOrderController.getSellerOrderByStatus(
                    orderStatus: "Completed");
              }, 4),
              const Divider(height: 20),
              buildSelectionRow(Icons.cancel_outlined, "Cancelled".tr, () {
                currentFilter = 5;
                Navigator.pop(context);
                sellerOrderController.getSellerOrderByStatus(
                    orderStatus: "Cancelled");
              }, 5),
            ],
          ),
        );
      },
    );
  }

  buildSelectionRow(icon, title, VoidCallback onTap, i) {
    final index = i;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.max,
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

  Future<void> toOrderDetailScreen({required int orderId}) async {
    await Get.toNamed(sellerOrderDetailScreenRoute, arguments: [orderId]);
    switch (currentFilter) {
      case 0:
        sellerOrderController.getSellerOrderByStatus(orderStatus: null);
        break;
      case 1:
        sellerOrderController.getSellerOrderByStatus(orderStatus: "Created");
        break;
      case 2:
        sellerOrderController.getSellerOrderByStatus(orderStatus: "Doing");
        break;
      case 3:
        sellerOrderController.getSellerOrderByStatus(orderStatus: "Delivered");
        break;
      case 4:
        sellerOrderController.getSellerOrderByStatus(orderStatus: "Completed");
        break;
      case 5:
        sellerOrderController.getSellerOrderByStatus(orderStatus: "Cancelled");
        break;
      default:
    }
  }
}
