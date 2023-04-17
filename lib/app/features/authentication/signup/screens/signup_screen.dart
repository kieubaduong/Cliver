import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/custom_textfield.dart';
import '../../../../controller/auth/signup_controller.dart';
import '../../../../core/values/app_colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 35).copyWith(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Register".tr,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                const SizedBox(height: 30),
                // const GGFBBtn(),
                const SizedBox(height: 30),
                // Center(
                //   child: Text(
                //     "OR".tr,
                //     style: TextStyle(
                //       color: AppColors.secondaryColor,
                //       fontSize: 14,
                //     ),
                //   ),
                // ),
                const SizedBox(height: 30),
                CustomTextField(
                    controller: _controller.fullName, hintText: "Full name".tr),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _controller.email,
                  hintText: "Email".tr,
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
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _controller.toEmailScreen();
                  },
                  child: Text(
                    "Register".tr,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 30),
                Center(child: Text("Already Have An Account?".tr)),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "login".tr.toUpperCase(),
                          style: TextStyle(
                              letterSpacing: 2, color: AppColors.primaryColor),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                        child: Divider(
                          color: AppColors.primaryColor,
                          height: 9,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
