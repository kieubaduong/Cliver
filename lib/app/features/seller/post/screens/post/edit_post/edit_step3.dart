import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../../../../../data/models/post.dart';
import '../../../../../../common_widgets/common_widgets.dart';
import '../../../controller/post_controller.dart';
import '../../../controller/step_controller.dart';

class EditStep3 extends StatefulWidget {
  const EditStep3({Key? key}) : super(key: key);

  @override
  State<EditStep3> createState() => _EditStep3State();
}

class _EditStep3State extends State<EditStep3> {
  final PostController _controller = Get.find();
  final StepController _stepController = Get.find();
  late final desText =
      TextEditingController(text: _controller.currentPost.description);
  Post currentPost = Post();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "(*)",
                    style: TextStyle(fontSize: 13, color: Colors.redAccent),
                  ),
                  Text(
                    "Full description",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: desText,
                hintText:
                    "This is where you introduce your products to customers",
                maxLines: 20,
                length: 1000,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ElevatedButton(
          onPressed: () async {
            if (desText.text.isNotEmpty) {
              if (desText.text.length > 1000 || desText.text.length < 10) {
                EasyLoading.showToast(
                    'Description must be less than 1000 character and must be greater than or equal to 10 characters',
                    toastPosition: EasyLoadingToastPosition.bottom);
                return;
              }
              _controller.currentPost.description = desText.text;
              _stepController.currentIndex.value++;
            } else {
              EasyLoading.showToast('enterAllInformation'.tr,
                  toastPosition: EasyLoadingToastPosition.bottom);
            }
          },
          child: const Text("Next"),
        ),
      ),
    );
  }
}
