import 'package:cliver_mobile/app/common_widgets/custom_textfield.dart';
import 'package:cliver_mobile/app/core/values/app_colors.dart';
import 'package:cliver_mobile/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/auth/login_controller.dart';
import '../../../core/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 35).copyWith(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "login".tr,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showLanguageDialog(context);
                      },
                      child: const Icon(
                        Icons.language_outlined,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // const GGFBBtn(),
                // const SizedBox(height: 50),
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
                    controller: _loginController.email, hintText: "Email".tr),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _loginController.pass,
                  hintText: "Password".tr,
                  secureText: true,
                  type: "pass",
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      _loginController.toForgetPassScreen();
                    },
                    child: Text(
                      "Forget Password?".tr,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _loginController.loginFunc();
                  },
                  child: Text(
                    "login".tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Center(child: Text("Don’t Have An Account?".tr)),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () {
                    Get.toNamed(signUpScreenRoute);
                  },
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "Register".tr.toUpperCase(),
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
