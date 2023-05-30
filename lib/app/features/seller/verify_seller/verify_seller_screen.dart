import 'dart:io';
import '../../../core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../data/services/services.dart';
import '../../../controller/controller.dart';

class VerifySellerScreen extends StatefulWidget {
  const VerifySellerScreen({Key? key}) : super(key: key);

  @override
  State<VerifySellerScreen> createState() => _VerifySellerScreenState();
}

class _VerifySellerScreenState extends State<VerifySellerScreen> {
  final UserController _userController = Get.find();

  final ImagePicker _imgPicker = ImagePicker();

  Map<String, File?>? photoData = {};

  void selectIdPhoto(target) async {
    final XFile? iDPhotoTemp =
        await _imgPicker.pickImage(source: ImageSource.camera);

    if (iDPhotoTemp != null) {
      photoData![target] = File(iDPhotoTemp.path);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      child: const Icon(Icons.close),
                      onTap: () {
                        Get.back();
                      },
                    ),
                    SizedBox(
                      width: context.screenSize.width * 0.25,
                    ),
                    const Text(
                      "Become a Seller",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  "Before you start",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                const ListTile(
                  dense: true,
                  leading: Icon(Icons.info_outline),
                  title: Text(
                      "Cliver commits to only use your data for the purpose of user authentication. All acts of leaking personal information, causing harm to individuals will be held legally responsible."),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Your information",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                photoData!["id"] == null
                    ? GestureDetector(
                        onTap: () {
                          selectIdPhoto("id");
                        },
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.secondaryColor),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.grey,
                                size: 50,
                              ),
                              Text(
                                "Take one of the following documents (passport, driving license, ID card,...) containing your face.",
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      )
                    : Stack(
                        children: [
                          Image.file(
                            width: context.screenSize.width,
                            photoData!["id"]!,
                            fit: BoxFit.contain,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                photoData!["id"] = null;
                              });
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(Icons.close),
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    photoData!["face1"] == null
                        ? GestureDetector(
                            onTap: () {
                              selectIdPhoto("face1");
                            },
                            child: Container(
                              height: 250,
                              width: context.screenSize.width * 0.45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: AppColors.secondaryColor),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.grey,
                                    size: 50,
                                  ),
                                  Text(
                                    "Your face 1",
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Stack(
                            children: [
                              Image.file(
                                width: context.screenSize.width * 0.45,
                                photoData!["face1"]!,
                                fit: BoxFit.contain,
                                height: 250,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    photoData!["face1"] = null;
                                  });
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Icon(Icons.close),
                                ),
                              ),
                            ],
                          ),
                    const Spacer(),
                    photoData!["face2"] == null
                        ? GestureDetector(
                            onTap: () {
                              selectIdPhoto("face2");
                            },
                            child: Container(
                              height: 250,
                              width: context.screenSize.width * 0.45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: AppColors.secondaryColor),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.grey,
                                    size: 50,
                                  ),
                                  Text(
                                    "Your face 2",
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Stack(
                            children: [
                              Image.file(
                                width: context.screenSize.width * 0.45,
                                height: 250,
                                photoData!["face2"]!,
                                fit: BoxFit.contain,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    photoData!["face2"] = null;
                                  });
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Icon(Icons.close),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () async {
                      EasyLoading.show();
                      var res = await AuthService.instance
                          .verifySeller(token: _userController.userToken);
                      if (res.isOk) {
                        _userController.currentUser.value.isVerified = true;
                        Get.back();
                      }
                      EasyLoading.dismiss();
                    },
                    child: const Text("Confirm"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
