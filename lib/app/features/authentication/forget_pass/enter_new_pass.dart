import 'package:cliver_mobile/app/common_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/auth/signup_controller.dart';

class EnterPassScreen extends StatefulWidget {
  const EnterPassScreen({Key? key}) : super(key: key);

  @override
  State<EnterPassScreen> createState() => _EnterPassScreenState();
}

class _EnterPassScreenState extends State<EnterPassScreen> {
  final _controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 35).copyWith(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Forget Password".tr,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Please enter new password".tr,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _controller.pass,
                  hintText: "Password".tr,
                  type: "pass",
                  secureText: true,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _controller.repass,
                  hintText: "Confirm Password".tr,
                  type: "pass",
                  secureText: true,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Reset".tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
