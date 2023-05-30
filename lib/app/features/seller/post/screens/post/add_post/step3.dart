import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../../../../../data/models/post.dart';
import '../../../../../../../data/services/PostService.dart';
import '../../../../../../common_widgets/common_widgets.dart';
import '../../../controller/post_controller.dart';
import '../../../controller/step_controller.dart';

class Step3 extends StatefulWidget {
  const Step3({Key? key}) : super(key: key);

  @override
  State<Step3> createState() => _Step3State();
}

class _Step3State extends State<Step3> {
  final PostController _controller = Get.find();
  final StepController _stepController = Get.find();
  final desText = TextEditingController();
  Post currentPost = Post();

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
              Post upPost = Post(
                id: _controller.currentPost.id,
                description: desText.text,
              );

              EasyLoading.show();
              var res = await PostService.ins.putPostStep(post: upPost);
              EasyLoading.dismiss();

              if (res.isOk) {
                _stepController.currentIndex.value++;
              } else {
                print(res.body);
              }
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
