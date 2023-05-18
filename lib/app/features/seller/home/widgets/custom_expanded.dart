import 'package:cliver_mobile/app/core/utils/utils.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/values/app_colors.dart';

const loremIpsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

class CustomExpanded extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: ScrollOnExpand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expandable(
              expanded: buildExpanded(context),
              collapsed: Container(),
            ),
            // Builder(
            //   builder: (context) {
            //     var controller =
            //         ExpandableController.of(context, required: true)!;
            //     return GestureDetector(
            //         onTap: () {
            //           controller.toggle();
            //         },
            //         child: !controller.expanded
            //             ? const myCollapseBar()
            //             : const myExpandedBar());
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildExpanded(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xff2A2B2E),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.screenSize.width * 0.03,
            vertical: context.screenSize.height * 0.01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Text(
                  "Next level".tr,
                  style: const TextStyle(color: Colors.white),
                ),
                const Spacer(),
                Text(
                  "Seller level 1".tr,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "Response rate higher than 80%".tr,
                  style: const TextStyle(color: Colors.white),
                ),
                const Spacer(),
                Text(
                  "Done".tr,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "No warning received within 60 days".tr,
                  style: const TextStyle(color: Colors.white),
                ),
                const Spacer(),
                Text(
                  "54/60".tr,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "Total amount earned is \$2000".tr,
                  style: const TextStyle(color: Colors.white),
                ),
                const Spacer(),
                Text(
                  "\$400/\$2000",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
