import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common_widgets/common_widgets.dart';
import '../../../controller/auth/fotget_pass_controller.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  final _controller = Get.put(ForgetPassController());

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
                  "Please enter your email address to reset your password".tr,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 30),
                CustomTextField(
                    controller: _controller.email, hintText: "Email"),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    _controller.toVerifyEmailScreen();
                  },
                  child: Text(
                    "Send Code".tr,
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
