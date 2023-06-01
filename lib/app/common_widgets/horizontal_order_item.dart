import 'package:cliver_mobile/app/core/utils/utils.dart';
import 'package:cliver_mobile/app/features/bottom_navigation_bar/bottom_bar_controller.dart';
import 'package:cliver_mobile/data/models/order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../core/values/app_colors.dart';

class HorizontalOrderItem extends StatelessWidget {
  const HorizontalOrderItem(
      {Key? key,
      required this.onTap,
      required this.order,
      required this.getImageFuture})
      : super(key: key);
  final VoidCallback onTap;
  final Order order;
  final Future<String?> getImageFuture;

  @override
  Widget build(BuildContext context) {
    final oCcy = NumberFormat("#,##0", "vi_VN");
    return GestureDetector(
      onTap: () => onTap(),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        color: AppColors.primaryWhite,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: (!Get.find<BottomBarController>().isSeller.value)
                    ? Text(
                        order.seller!.name.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        textWidthBasis: TextWidthBasis.longestLine,
                      )
                    : const SizedBox.shrink(),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: context.height * 0.17,
                    height: context.height * 0.15,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(13.0),
                      child: FutureBuilder(
                        future: getImageFuture,
                        builder: (_, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            return Image.network(
                              snapshot.data,
                              fit: BoxFit.fill,
                            );
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: context.height * 0.15,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: AppColors.lightGreenColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                order.status.toString().substring(7).tr,
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: context.width * 0.55,
                                        child: Text(
                                          order.package!.post!.title.toString(),
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        width: context.width * 0.55,
                                        child: Text(
                                          order.package?.name as String,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 20,
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text(
                      FormatHelper().dateFormat(order.updatedAt).toString(),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "${oCcy.format(order.package?.price)} VNĐ",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
