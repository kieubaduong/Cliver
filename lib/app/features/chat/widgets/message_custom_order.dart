import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/enums/enums.dart';
import '../../../../data/models/model.dart';
import '../../../core/core.dart';
import '../../../routes/routes.dart';
import '../../features.dart';

class MessageCustomOrder extends StatefulWidget {
  const MessageCustomOrder({super.key, required this.message});
  final Message message;

  @override
  State<MessageCustomOrder> createState() => _MessageCustomOrderState();
}

class _MessageCustomOrderState extends State<MessageCustomOrder> {
  late ChatController chatController;
  late BottomBarController bottomBarController;

  @override
  Widget build(BuildContext context) {
    chatController = Get.find<ChatController>();
    bottomBarController = Get.find<BottomBarController>();
    return Container(
      width: 300,
      constraints: BoxConstraints(maxWidth: context.width * 0.8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (widget.message.customPackage?.name != "")
                  ? Text(
                      widget.message.customPackage?.name ??
                          "custom package name null",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )
                  : const SizedBox.shrink(),
              Center(
                child: SizedBox(
                  height: 100,
                  width: 300,
                  child: Image.network(
                      fit: BoxFit.fill,
                      widget.message.customPackage!.post!.images![0]),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.message.customPackage?.description ?? "description null",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.paid_outlined,
                    size: 20,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Offer price: ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    FormatHelper()
                            .moneyFormat(widget.message.customPackage!.price) ??
                        "money null",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.schedule_outlined,
                    size: 20,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "${widget.message.customPackage?.deliveryDays} day delivery",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
              const Divider(
                color: Colors.black,
                thickness: 1,
              ),
              // action widget
              actionWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget actionWidget() {
    if (widget.message.customPackage?.status == CustomOrderStatus.Closed) {
      // Offer Withdrawn
      return Row(
        children: [
          Expanded(
            child: Text(
              "Offer Withdrawn".tr,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      );
    }
    if (widget.message.customPackage?.post?.userId ==
        chatController.senderId) // nếu mình là người tạo order
    {
      if (widget.message.customPackage?.status == CustomOrderStatus.Declined) {
        // partner denied this offer
        return Row(
          children: [
            Expanded(
              child: Text(
                "${chatController.partnerName.value} denied this offer",
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ],
        );
      } else if (widget.message.customPackage?.status ==
          CustomOrderStatus.Ordered) {
        // partner accept this offer
        return Row(
          children: [
            Expanded(
              child: Text(
                "${chatController.partnerName.value} accept this offer",
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ],
        );
      }
      // withdraw the offer
      return Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () async {
                bool result = await chatController.changeCustomOrderStatus(
                  customOrderId: widget.message.customPackage?.id as int,
                  status: CustomOrderStatus.Closed,
                );
                if (result) {
                  widget.message.customPackage?.status =
                      CustomOrderStatus.Closed;
                  setState(() {});
                }
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.primaryColor)),
              child: Text(
                "Withdraw the Offer".tr,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      );
    }
    if (!bottomBarController.isSeller.value) {
      if (widget.message.customPackage?.status == CustomOrderStatus.Ordered) {
        // view this offer
        return Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => chatController.viewThisOffer(
                    customOrderId: widget.message.customPackage?.id as int),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.primaryColor)),
                child: const Text(
                  "View this offer",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      } else if (widget.message.customPackage?.status ==
          CustomOrderStatus.Declined) {
        // you denied this offer
        return Row(
          children: const [
            Expanded(
              child: Text(
                "You denied this offer",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        );
      }
      // accept or deny
      return Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () async {
                // navigate to payment method screen
                Package package = Package();
                Post post = Post();
                SimplePost simplePost =
                    widget.message.customPackage?.post as SimplePost;
                CustomOrder customOrder =
                    widget.message.customPackage as CustomOrder;
                // convert custom package to package
                package.id = customOrder.id;
                package.name = customOrder.name;
                package.description = customOrder.description;
                package.postId = customOrder.postId;
                package.post = customOrder.post;
                package.deliveryDays = customOrder.deliveryDays;
                package.numberOfRevisions = customOrder.numberOfRevisions;
                package.price = customOrder.price;
                // convert simple post to post
                post.title = simplePost.title;
                post.description = simplePost.description;
                post.userId = simplePost.userId;
                post.images = simplePost.images;
                Get.toNamed(paymentMethodRoute,
                    arguments: [package, true, post, false]);
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.primaryColor)),
              child: Text(
                "Accept".tr,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.lightGreenColor)),
              onPressed: () async {
                bool result = await chatController.changeCustomOrderStatus(
                  customOrderId: widget.message.customPackage?.id as int,
                  status: CustomOrderStatus.Declined,
                );
                if (result) {
                  widget.message.customPackage?.status =
                      CustomOrderStatus.Declined;
                  setState(() {});
                }
              },
              child: Text("Deny".tr),
            ),
          ),
        ],
      );
    }
    // switch to buyer mode to view action
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              bottomBarController.changeToSeller();
              setState(() {});
            },
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColors.primaryColor)),
            child: Text(
              "Switch to buyer mode to view action".tr,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
