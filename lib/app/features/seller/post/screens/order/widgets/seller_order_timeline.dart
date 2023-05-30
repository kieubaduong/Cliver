import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../../data/enums/enums.dart';
import '../../../../../../../data/models/model.dart';
import '../../../../../../core/utils/utils.dart';
import '../../../../../../core/values/app_colors.dart';
import '../../../../../features.dart';

class SellerOrderTimeline extends StatefulWidget {
  const SellerOrderTimeline({super.key, required this.order});
  final Order order;

  @override
  State<SellerOrderTimeline> createState() => _SellerOrderTimelineState();
}

class _SellerOrderTimelineState extends State<SellerOrderTimeline> {
  final f = DateFormat('dd MMM HH:mm');

  final sellerOrderController = Get.find<SellerOrderController>();

  late RxList<Widget> timeline;
  late Rx<Order> order;

  @override
  void initState() {
    sellerOrderController.initSellerOrderDetailData();
    timeline = sellerOrderController.timeline;
    order = sellerOrderController.order;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        sellerOrderController.isFirstDoing = true;
        timeline.clear();
        bool isEnd = false;
        int index = 0;
        for (var element in order.value.histories as List<OrderHistory>) {
          if (index == order.value.histories!.length - 1) isEnd = true;
          switch (element.status) {
            case Status.PendingPayment:
              buildOrderPendingPayment(createdTime: element.createdAt);
              break;
            case Status.Created:
              buildOrderCreated(createdTime: element.createdAt);
              break;
            case Status.Doing:
              buildOrderDoing(doneTime: element.createdAt, isEnd: isEnd);
              break;
            case Status.Delivered:
              buildOrderDelivered(
                  deliveredTime: element.createdAt,
                  resource: element.resource,
                  isEnd: isEnd);
              break;
            case Status.Completed:
              buildOrderCompleted(completedTime: element.createdAt);
              break;
            default:
          }
          index++;
        }
        buildOrderCanceled();
        return Wrap(children: sellerOrderController.timeline);
      },
    );
  }

  void buildStepper() {
    sellerOrderController.isFirstDoing = true;
    timeline.clear();
    bool isEnd = false;
    int index = 0;
    for (var element in order.value.histories as List<OrderHistory>) {
      if (index == order.value.histories!.length - 1) isEnd = true;
      switch (element.status) {
        case Status.Created:
          buildOrderCreated(createdTime: element.createdAt);
          break;
        case Status.Doing:
          buildOrderDoing(doneTime: element.createdAt, isEnd: isEnd);
          break;
        case Status.Delivered:
          buildOrderDelivered(
              deliveredTime: element.createdAt,
              resource: element.resource,
              isEnd: isEnd);
          break;
        case Status.Completed:
          buildOrderCompleted(completedTime: element.createdAt);
          break;
        default:
      }
      index++;
    }
    if (sellerOrderController.orderStatus == Status.Cancelled) {
      timeline.add(
        Text(
          "Canceled order".tr,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
  }

  void buildOrderPendingPayment({required DateTime? createdTime}) {
    timeline.add(
      StepperItem(
        leading: Icons.pending_actions_outlined,
        title: "Unpaid order".tr,
        subtitle: (createdTime != null)
            ? f.format(FormatHelper().toLocal(createdTime) as DateTime)
            : "Get time by status null",
        color: Colors.blueAccent,
      ),
    );
  }

  void buildOrderCreated({required DateTime? createdTime}) {
    timeline.add(
      StepperItem(
        leading: Icons.start,
        title: "${order.value.buyer?.name} ${'placed an order'.tr}",
        subtitle: (createdTime != null)
            ? f.format(FormatHelper().toLocal(createdTime) as DateTime)
            : "Get time by status null",
        color: Colors.blueAccent,
      ),
    );

    if (sellerOrderController.orderStatus == Status.Created) {
      timeline.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.primaryColor),
                  ),
                  onPressed: () => sellerOrderController.startMakingOrder(),
                  child: Text(
                    "Start".tr,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () => sellerOrderController.cancelOrder(),
                  child: Text(
                    "cancel".tr,
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  void buildOrderDoing({required DateTime? doneTime, required bool isEnd}) {
    timeline.add(
      StepperItem(
        leading: sellerOrderController.isFirstDoing
            ? Icons.rocket
            : Icons.restart_alt,
        title: (sellerOrderController.isFirstDoing)
            ? "You have started work".tr
            : "Reworked the order".tr,
        subtitle: (doneTime != null)
            ? f.format(FormatHelper().toLocal(doneTime) as DateTime)
            : "Get time by status null",
        color: Colors.green,
      ),
    );
    sellerOrderController.isFirstDoing = false;
    if (isEnd) {
      timeline.add(
        Card(
          child: SizedBox(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  const Icon(
                    Icons.folder_zip,
                    size: 30,
                    color: Colors.yellowAccent,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Obx(
                      () => Text(
                        "${sellerOrderController.fileName.value} ${sellerOrderController.fileSizeName.value}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => sellerOrderController.clearZipFile(),
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.redAccent.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      timeline.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.primaryColor),
                  ),
                  onPressed: () => sellerOrderController.deliveryOrder(),
                  child: Text(
                    "Delivery".tr,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: 50,
                child: ButtonIcon(
                  icon: Icons.attach_file_outlined,
                  onPressed: () => sellerOrderController.pickZipFile(),
                ),
              ),
            ],
          ),
        ),
      );
      return;
    }
  }

  void buildOrderDelivered(
      {required DateTime? deliveredTime,
      required Resource? resource,
      required bool isEnd}) {
    timeline.add(
      StepperItem(
          leading: Icons.inventory_2,
          title: "You have delivered the order".tr,
          subtitle: (deliveredTime != null)
              ? f.format(FormatHelper().toLocal(deliveredTime) as DateTime)
              : "Get time by status null",
          color: Colors.pinkAccent),
    );
    if (resource != null) {
      timeline.add(
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                const Icon(
                  Icons.folder_zip,
                  size: 30,
                  color: Colors.yellowAccent,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    resource.name.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => sellerOrderController.downloadZip(
                    url: resource.url.toString(),
                    fileName: resource.name.toString(),
                  ),
                  child: const Icon(
                    Icons.download,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    if (isEnd) {
      timeline.add(
        Text(
          "You have to wait for the buyer to agree".tr,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 18,
          ),
        ),
      );
    }
  }

  void buildOrderCompleted({required DateTime? completedTime}) {
    timeline.add(
      StepperItem(
          leading: Icons.task,
          title: "The order was completed".tr,
          subtitle: (completedTime != null)
              ? f.format(FormatHelper().toLocal(completedTime) as DateTime)
              : "Get time by status null",
          color: Colors.blueAccent),
    );
    if (order.value.reviews!.isEmpty) {
      timeline.add(
        Text(
          "You have to wait for the buyer to review first".tr,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else if (order.value.reviews?.length == 2) {
      for (var element in order.value.reviews!) {
        switch (element.type) {
          case ReviewType.FromBuyer:
            timeline.add(
              StepperItem(
                  leading: Icons.star_rate_rounded,
                  title:
                      "${order.value.buyer?.name} ${'gave you a'.tr} ${element.rating}-${'star review'.tr}",
                  subtitle: element.comment,
                  color: Colors.amberAccent),
            );
            break;
          case ReviewType.FromSeller:
            timeline.add(
              StepperItem(
                  leading: Icons.star_rate_rounded,
                  title:
                      "${'You left this buyer a'.tr} ${element.rating}-${'star review'.tr}",
                  subtitle: element.comment,
                  color: Colors.amberAccent),
            );
            break;
          default:
        }
      }
      timeline.add(const SizedBox(height: 20, width: 10));
      return;
    } else {
      timeline.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Review".tr,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              onChanged: (value) => sellerOrderController.reviewContent = value,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                hintText: "Please leave your comment at least 10 characters".tr,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.primaryColor,
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: RatingBar.builder(
                direction: Axis.horizontal,
                itemCount: 5,
                itemSize: 30,
                initialRating: 1,
                minRating: 1,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star_rate_rounded,
                  color: Colors.amber,
                ),
                onRatingUpdate: (value) =>
                    sellerOrderController.rating = value.round(),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.primaryColor),
                    ),
                    onPressed: () => sellerOrderController.reviewOrder(),
                    child: Text(
                      "Submit your review".tr,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    onPressed: () {},
                    child: Text("Skip".tr),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    }
  }

  void buildOrderCanceled() {
    if (sellerOrderController.orderStatus == Status.Cancelled) {
      timeline.add(
        Text(
          "Canceled order".tr,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
  }
}
