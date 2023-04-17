import 'package:cliver_mobile/app/features/authentication/forget_pass/enter_new_pass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:get/get.dart';

import '../../../controller/auth/fotget_pass_controller.dart';
import '../../../core/values/app_colors.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool _onEditing = true;
  final ForgetPassController _controller = Get.find();

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
                  "Verify Code".tr,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Check your email inbox".tr + _controller.email.text,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 30),
                Center(
                  child: VerificationCode(
                    itemSize: 80,
                    fillColor: Colors.transparent,
                    digitsOnly: true,
                    textStyle: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                    underlineColor: AppColors.primaryColor,
                    onEditing: (bool value) {
                      setState(() {
                        _onEditing = value;
                      });
                      if (!_onEditing) FocusScope.of(context).unfocus();
                    },
                    onCompleted: (String value) {
                      setState(() {
                        _controller.code = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "${"Didn’t Receive A Code?".tr}  ",
                      style: const TextStyle(fontSize: 14),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "Resend Code".tr,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EnterPassScreen()));
                  },
                  child: Text(
                    "Confirm".tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
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
