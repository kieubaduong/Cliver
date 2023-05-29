import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/models/model.dart';
import '../../../../common_widgets/common_widgets.dart';
import '../../../../core/core.dart';
import '../../../features.dart';

class SellerAbout extends StatefulWidget {
  const SellerAbout(
      {Key? key,
      required this.user,
      required this.tempUser,
      this.onSave,
      this.isEdit = false})
      : super(key: key);
  final User user;
  final User tempUser;
  final void Function(User)? onSave;
  final bool isEdit;

  @override
  State<SellerAbout> createState() => _SellerAboutState();
}

class _SellerAboutState extends State<SellerAbout> {
  final BottomBarController _bottomController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //information
            Text(
              "User information".tr,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(widget.user.description ?? ''),
            const Divider(),
            Row(
              children: [
                const Icon(Icons.location_on_outlined),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("From".tr),
                    const Text("Vietnam (15:30)"),
                  ],
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Icon(Icons.person_outline),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Member since".tr),
                    Text("Jun 2021".tr),
                  ],
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Icon(Icons.message_outlined),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Avg. response time".tr),
                    Text("1 hours".tr),
                  ],
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Icon(Icons.remove_red_eye_outlined),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Last active".tr),
                    Text("1 hour ago".tr),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            //languages
            Text(
              "Languages".tr,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                  widget.user.languages?.length ?? 0,
                  (index) => Container(
                        padding: EdgeInsets.symmetric(vertical: getHeight(5)),
                        decoration: BoxDecoration(
                            border: index != widget.user.languages!.length - 1
                                ? Border(
                                    bottom: BorderSide(
                                        color: AppColors.metallicSilver,
                                        width: 0.5))
                                : null),
                        child: Row(
                          children: [
                            const Icon(Icons.translate),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.user.languages?[index].name?.tr ??
                                    ''),
                                Text(widget.user.languages?[index].level?.tr ??
                                    ''),
                              ],
                            ),
                          ],
                        ),
                      )),
            ),
            const SizedBox(height: 30),
            //Skill
            Text(
              "Skills".tr,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 5,
              children: List.generate(widget.user.skills?.length ?? 0,
                  (index) => buildSkillItem(widget.user.skills?[index] ?? '')),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: _bottomController.isSeller.value || widget.isEdit
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              height: getHeight(80),
              child: InkWellWrapper(
                margin: EdgeInsets.symmetric(
                    horizontal: getWidth(10), vertical: getHeight(15)),
                color: AppColors.greenCrayola,
                onTap: () async {
                  await showGeneralDialog(
                    context: context,
                    pageBuilder: (BuildContext buildContext,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation) {
                      return EditProfile(
                          user: widget.tempUser, onSave: widget.onSave);
                    },
                    barrierDismissible: true,
                    barrierLabel: 'abc',
                    barrierColor: Colors.transparent,
                    transitionDuration: const Duration(milliseconds: 200),
                  );
                },
                child: Center(
                  child: Text(
                    'Edit profile'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.primaryWhite,
                      fontSize: getFont(18),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  buildSkillItem(title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(title),
      ),
    );
  }
}
