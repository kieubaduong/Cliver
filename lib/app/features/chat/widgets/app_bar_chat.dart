import '../../../core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarChat extends StatelessWidget {
  final String username;
  final String? partnerAvt;

  const AppBarChat({
    Key? key,
    required this.username,
    required this.partnerAvt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              height: context.screenSize.width * 0.12,
              width: context.screenSize.width * 0.12,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(90),
                child: Image.network(
                  fit: BoxFit.cover,
                  partnerAvt ??
                      "https://d2v9ipibika81v.cloudfront.net/uploads/sites/210/Profile-Icon.png",
                ),
              ),
            ),
            SizedBox(
              width: context.screenSize.width * 0.05,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Tooltip(
                    message: username,
                    child: Text(
                      username,
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: context.screenSize.height * 0.025,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  Text(
                    'Offline'.tr,
                    style: TextStyle(
                      color: AppColors.lightGreyColor,
                      fontSize: context.screenSize.height * 0.018,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
