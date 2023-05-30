import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../data/models/model.dart';
import '../../../../../core/core.dart';
import '../../../../../routes/routes.dart';
import '../../../../features.dart';

class PostPackage extends StatefulWidget {
  const PostPackage({Key? key, this.package, required this.type, this.canBuy})
      : super(key: key);

  @override
  State<PostPackage> createState() => _PostPackageState();

  final Package? package;
  final String type;
  final bool? canBuy;
}

class _PostPackageState extends State<PostPackage> {
  final BottomBarController _bottomController = Get.find();
  final PaymentController _paymentController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10),
        Text(
          widget.package?.name ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(widget.package?.description ?? ''),
        const SizedBox(height: 10),
        Row(
          children: [
            Text("Delivery days".tr),
            const Spacer(),
            Text(
              widget.package?.deliveryDays.toString() ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Text("Revisions".tr),
            const Spacer(),
            Text(
              widget.package?.numberOfRevisions.toString() ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _bottomController.isSeller.value
            ? ElevatedButton(
                onPressed: () => Get.toNamed(editPostScreenRoute),
                child: Text("Edit your post".tr),
              )
            : ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: (widget.canBuy != null)
                        ? MaterialStateProperty.all(AppColors.primaryColor)
                        : MaterialStateProperty.all(Colors.grey)),
                onPressed: () {
                  (widget.canBuy != null)
                      ? Get.toNamed(
                          paymentMethodRoute,
                          arguments: [
                            _paymentController.post
                                ?.packages![_paymentController.selectedPackage],
                            false,
                            null,
                            false,
                          ],
                        )
                      : Get.defaultDialog(
                          title: "Warning",
                          content: const Text("You can't buy your service"),
                        );
                },
                child: Text("Continue ${widget.type}"),
              ),
      ],
    );
  }
}
