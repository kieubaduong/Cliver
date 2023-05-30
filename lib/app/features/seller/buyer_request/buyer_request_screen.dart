import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/models/model.dart';
import '../../../core/core.dart';
import 'controller/buyer_request_controller.dart';

class BuyerRequestScreen extends StatelessWidget {
  BuyerRequestScreen({Key? key}) : super(key: key);

  final _controller = Get.put(BuyerRequestController())..getAllRequest();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buyer requests".tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Here you can find buyer's requests that match your skills".tr,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (ctx, i) => _buildRequestItem(context, _controller.listRequest[i]),
                  itemCount: _controller.listRequest.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildRequestItem(context, ServiceRequest ser, {Function? onTap, bool canInput = false}) {
    return Card(
      child: InkWell(
        onTap: () {
          if (onTap != null) {
            onTap();
            return;
          }
          showDialog(context: context, builder: (context) => _openChatDialog(context, ser));
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              //name and avatar
              Row(
                children: [
                  const CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.grey,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    ser.user?.name ?? "",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              //describe
              Text(ser.description ?? ""),
              const SizedBox(height: 10),
              //category
              Text(
                ser.category?.name ?? "",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                ser.subcategory?.name ?? "",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              //timing and price
              Row(
                children: [
                  Text(
                    "${'Deadline'.tr}:  ${FormatHelper().dateFormat(ser.deadline) ?? 'Flexible'.tr}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "${'Budget'.tr}:  ${FormatHelper().moneyFormat(ser.budget) ?? "Flexible".tr}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              if (canInput)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      "Prefer tags",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Wrap(
                      spacing: 10,
                      runSpacing: 5,
                      children: ser.tags?.map((e) => buildTagItem(e)).toList() ?? [],
                    ),
                  ],
                ),
              //inputField
              const SizedBox(height: 10),
              if (canInput)
                TextField(
                  decoration: InputDecoration(
                    hintText: "Give your best offer...",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    suffixIcon: InkWell(
                      onTap: () {
                        print("alo");
                      },
                      child: Icon(
                        Icons.send,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  _openChatDialog(context, ServiceRequest ser) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
      ),
      child: Center(
        child: _buildRequestItem(
          context,
          ser,
          onTap: () {
            return;
          },
          canInput: true,
        ),
      ),
    );
  }

  Widget buildTagItem(title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(title),
      ),
    );
  }
}
