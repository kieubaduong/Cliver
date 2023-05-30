import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../data/enums/review_type.dart';
import '../../../../../data/enums/status.dart';
import '../../../../../data/models/model.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../routes/routes.dart';
import '../../../features.dart';

class BuyerOrderTimeline extends StatefulWidget {
  const BuyerOrderTimeline({super.key, required this.order});
  final Order order;

  @override
  State<BuyerOrderTimeline> createState() => _BuyerOrderTimelineState();
}

class _BuyerOrderTimelineState extends State<BuyerOrderTimeline> {
  final f = DateFormat('dd MMM HH:mm');

  final buyerOrderController = Get.find<BuyerOrderController>();
  late RxList<Widget> timeline;
  late Rx<Order> order;

  @override
  void initState() {
    buyerOrderController.initBuyerOrderDetailData();
    timeline = buyerOrderController.timeline;
    order = buyerOrderController.order;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      timeline.clear();
      buyerOrderController.isFirstDoing = true;
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
            String? fileName;
            if (element.resource != null) {
              fileName = element.resource?.name;
              buyerOrderController.url = element.resource?.url as String;
            }
            buildOrderDelivered(
                deliveredTime: element.createdAt,
                fileName: fileName,
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
      return Wrap(children: buyerOrderController.timeline);
    });
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
    if (buyerOrderController.orderStatus == Status.PendingPayment) {
      timeline.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Pending payment".tr,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.primaryColor),
                      ),
                      onPressed: () async {
                        Post post = Post();
                        SimplePost simplePost =
                            order.value.package?.post as SimplePost;
                        // convert simple post to post
                        post.title = simplePost.title;
                        post.description = simplePost.description;
                        post.userId = simplePost.userId;
                        post.images = simplePost.images;

                        await Get.toNamed(paymentMethodRoute, arguments: [
                          order.value.package,
                          true,
                          post,
                          true,
                          order.value
                        ]);
                      },
                      child: Text(
                        "Continue payment".tr,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: () => buyerOrderController.cancelOrder(),
                      child: Text("cancel".tr),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }

  void buildOrderCreated({required DateTime? createdTime}) {
    log(createdTime.toString());
    timeline.add(
      StepperItem(
        leading: Icons.start,
        title: "You placed an order".tr,
        subtitle: (createdTime != null)
            ? f.format(FormatHelper().toLocal(createdTime) as DateTime)
            : "Get time by status null",
        color: Colors.blueAccent,
      ),
    );

    if (buyerOrderController.orderStatus == Status.Created) {
      timeline.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: double.infinity,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () => buyerOrderController.cancelOrder(),
              child: Text(
                "cancel".tr,
                style: TextStyle(color: AppColors.primaryColor),
              ),
            ),
          ),
        ),
      );
      return;
    }
  }

  void buildOrderDoing({required DateTime? doneTime, required bool isEnd}) {
    timeline.add(
      StepperItem(
        leading: buyerOrderController.isFirstDoing
            ? Icons.rocket
            : Icons.restart_alt,
        title: buyerOrderController.isFirstDoing
            ? "The order started".tr
            : "${order.value.seller?.name} ${'reworked the order'.tr}",
        subtitle: (doneTime != null)
            ? f.format(FormatHelper().toLocal(doneTime) as DateTime)
            : "Get time by status null",
        color: Colors.green,
      ),
    );
    buyerOrderController.isFirstDoing = false;
    if (isEnd) {
      timeline.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            "Your order is being processed".tr,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
      return;
    }
  }

  void buildOrderDelivered(
      {required DateTime? deliveredTime,
      required bool isEnd,
      String? fileName}) {
    String subtitle = (deliveredTime != null)
        ? f.format(FormatHelper().toLocal(deliveredTime) as DateTime)
        : "Get time by status null";
    timeline.add(
      StepperItem(
          leading: Icons.inventory_2,
          title: "${order.value.seller?.name} ${'delivered the order'.tr}",
          subtitle: subtitle,
          color: Colors.pinkAccent),
    );
    if (fileName != null) {
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
                    fileName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => buyerOrderController.downloadZip(fileName),
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
      if (order.value.leftRevisionTimes == 0) {
        timeline.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.primaryColor),
                ),
                onPressed: () => buyerOrderController.acceptDeliveredOrder(),
                child: Text(
                  "Ok".tr,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        );
      } else {
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
                    onPressed: () =>
                        buyerOrderController.acceptDeliveredOrder(),
                    child: Text(
                      "Ok".tr,
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
                    onPressed: () => buyerOrderController.denyDeliveredOrder(),
                    child: Text("Rework".tr),
                  ),
                ),
              ],
            ),
          ),
        );
      }
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
    if (order.value.reviews!.isNotEmpty) {
      for (var element in order.value.reviews!) {
        switch (element.type) {
          case ReviewType.FromBuyer:
            timeline.add(
              StepperItem(
                  leading: Icons.star_rate_rounded,
                  title:
                      "${'You left this seller a'.tr} ${element.rating}-${'star review'.tr}",
                  subtitle: element.comment,
                  color: Colors.amberAccent),
            );
            break;
          case ReviewType.FromSeller:
            timeline.add(
              StepperItem(
                  leading: Icons.star_rate_rounded,
                  title:
                      "${order.value.seller?.name} ${'gave you a'.tr} ${element.rating}-${'star review'.tr}",
                  subtitle: element.comment,
                  color: Colors.amberAccent),
            );
            break;
          default:
        }
      }
      timeline.add(const SizedBox(height: 20, width: 10));
      return;
    }
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
            onChanged: (value) => buyerOrderController.reviewContent = value,
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
                  buyerOrderController.rating = value.round(),
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
                  onPressed: () => buyerOrderController.reviewOrder(),
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

  void buildOrderCanceled() {
    if (buyerOrderController.orderStatus == Status.Cancelled) {
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
