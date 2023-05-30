import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../../data/models/model.dart';
import '../../../../../../../data/services/services.dart';
import '../../../../../../core/core.dart';
import '../../../../../../routes/routes.dart';
import '../../../controller/post_controller.dart';

class Step4 extends StatefulWidget {
  const Step4({Key? key}) : super(key: key);

  @override
  State<Step4> createState() => _Step4State();
}

class _Step4State extends State<Step4> {
  final ImagePicker imgPicker = ImagePicker();

  List<String> imageFileList = [];

  final PostController _controller = Get.find();

  void selectMultiImages() async {
    final List<XFile> selected = await imgPicker.pickMultiImage();

    imageFileList.addAll(selected.map((e) => e.path).toList());
    if (imageFileList.length > 6) {
      imageFileList.removeRange(6, imageFileList.length);
    }
    setState(() {});
  }

  void selectImages(int i) async {
    final XFile? selected =
        await imgPicker.pickImage(source: ImageSource.gallery);

    if (selected != null) {
      imageFileList[i] = selected.path;
    }
    setState(() {});
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
              const Text(
                "Showcase your service in a Gallery",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const ListTile(
                horizontalTitleGap: 0,
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.info_outline),
                dense: true,
                title: Text(
                  "To comply with Cliver Terms of service, make sure to upload only content you either own or you have the permission or license to use.",
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "(*)",
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.redAccent
                        ),
                      ),
                      Text(
                        "Images (up to 6)",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Visibility(
                    visible: imageFileList.isNotEmpty ? true : false,
                    child: GestureDetector(
                      onTap: () => selectMultiImages(),
                      child: Text(
                        "More",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              imageFileList.isEmpty
                  ? GestureDetector(
                      onTap: () {
                        selectMultiImages();
                      },
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.secondaryColor),
                        ),
                        child: const Icon(
                          Icons.panorama_outlined,
                          color: Colors.grey,
                          size: 50,
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: imageFileList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) {
                          return GestureDetector(
                            onTap: () {
                              selectImages(i);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  Image.file(
                                    width: context.screenSize.width * 0.75,
                                    File(imageFileList[i]),
                                    fit: BoxFit.cover,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        imageFileList.removeAt(i);
                                      });
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Icon(Icons.close),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ElevatedButton(
          onPressed: () async {
            if (imageFileList.isNotEmpty) {
              EasyLoading.show();
              var listLink = await StorageService.ins.uploadPostImages(
                  imageFileList.map((e) => File(e)).toList(),
                  _controller.currentPost.id!);

              Post upPost = Post(
                id: _controller.currentPost.id,
                images: listLink,
                isPublish: true,
              );

              EasyLoading.show();
              var res = await PostService.ins.putPostStep(post: upPost);
              EasyLoading.dismiss();
              if (res.isOk) {
                _controller.currentPost.id = null;
                Get.offAllNamed(sellerProfileScreenRoute);
              } else {
                EasyLoading.showToast(res.body["message"], toastPosition: EasyLoadingToastPosition.bottom);
              }
            } else {
              EasyLoading.showToast('enterAllInformation'.tr, toastPosition: EasyLoadingToastPosition.bottom);
            }
          },
          child: const Text("Finish"),
        ),
      ),
    );
  }
}
