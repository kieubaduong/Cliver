import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/models/model.dart';
import '../../../core/utils/utils.dart';
import '../../../core/values/app_colors.dart';
import 'controller/my_request_controller.dart';
import 'create_request.dart';

class MyRequestScreen extends StatelessWidget {
  MyRequestScreen({Key? key}) : super(key: key);

  final _controller = Get.put(MyRequestController())..getMyRequest();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage request".tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, i) => _buildRequestCardItem(
                      _controller.listMyRequest.value![i]),
                  itemCount: _controller.listMyRequest.value?.length ?? 0,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => CreateRequestScreen()),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  _buildRequestCardItem(ServiceRequest req) {
    return Card(
      child: InkWell(
        onTap: () => markDone(req),
        onLongPress: () => deleteRequest(req),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                req.description ?? "",
              ),
              const SizedBox(height: 10),
              Text(
                req.category?.name ?? "",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                req.subcategory?.name ?? "",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "${'Deadline'.tr}: ${FormatHelper().dateFormat(req.deadline) ?? 'Flexible'.tr}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "${'Budget'.tr}: ${FormatHelper().moneyFormat(req.budget) ?? "Flexible".tr}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (req.doneAt != null)
                Text(
                  "Status: Done",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  markDone(ServiceRequest req) {
    if (req.doneAt != null) return;
    Get.dialog(Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Mark this request as done?"),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _controller.markRequestAsDone(req),
                child: const Text("Yes"),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  deleteRequest(ServiceRequest req) {
    Get.dialog(
      Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Are you sure you want to delete this request?"),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () => _controller.deleteRequest(req),
                  child: const Text("Yes"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
