import '../../../../../core/core.dart';
import '../../../../features.dart';
import '../../../../../../data/models/model.dart';
import '../../../../../../data/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class PostReviewScreen extends StatefulWidget {
  const PostReviewScreen({Key? key}) : super(key: key);

  @override
  State<PostReviewScreen> createState() => _PostReviewScreenState();
}

class _PostReviewScreenState extends State<PostReviewScreen> {
  late List<Review> reviews = [];
  late List<Rating> ratings = [];
  int currentFilter = 0;
  bool isGetData = false;
  final bool arg = Get.arguments ?? true;
  final reviewController = Get.find<ReviewController>();

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    setState(() {
      isGetData = false;
    });
    EasyLoading.show();
    var res = await PostService.ins.getReviewById(id: reviewController.postId);
    if (res.isOk) {
      if (res.body["data"] != null) {
        reviews = <Review>[];
        res.body["data"].forEach((v) {
          if (v != null) {
            reviews.add(Review.fromJson(v));
          }
        });
      }
    }
    res = await PostService.ins
        .getReviewStatisticById(id: reviewController.postId);
    if (res.isOk) {
      if (res.body["data"] != null) {
        ratings = <Rating>[];
        res.body["data"].forEach((v) {
          if (v != null) {
            ratings.add(Rating.fromJson(v));
          }
        });
      }
    }
    EasyLoading.dismiss();
    setState(() {
      isGetData = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    int avgRating = 0;
    var sumRating = 0;
    for (var element in ratings) {
      avgRating += element.rating! * element.count!;
      sumRating += element.count!;
    }
    return isGetData
        ? Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: arg,
              title: Text("Review".tr),
              centerTitle: true,
            ),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 20),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 60,
                          ),
                          Text(
                            (avgRating / sumRating).toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: getFont(18),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          5,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              children: [
                                Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    fontSize: getFont(12),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(width: 3),
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 24,
                                ),
                                const SizedBox(width: 5),
                                Stack(
                                  children: [
                                    Container(
                                      height: 15,
                                      width: 200,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: AppColors.primaryWhite),
                                    ),
                                    Container(
                                      height: 15,
                                      width: 200 *
                                          ratings[index].count! /
                                          sumRating,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.amber),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  ratings[index].count.toString(),
                                  style: TextStyle(
                                    fontSize: getFont(12),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text('${reviews.length} ${'Ratings'.tr}',
                      style: TextStyle(
                        fontSize: getFont(20),
                        fontWeight: FontWeight.w700,
                      )),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 0.5, color: Colors.grey),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, i) {
                        return PostReviewItem(review: reviews[i]);
                      },
                      itemCount: reviews.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(height: 20);
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  void showBottom(context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Wrap(
            children: [
              Text(
                "sort by".tr,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 50),
              buildSelectionRow(Icons.message_outlined, "Most relevant".tr, () {
                currentFilter = 0;
                Navigator.pop(context);
              }, 0),
              const Divider(height: 20),
              buildSelectionRow(Icons.access_time, "Most recent".tr, () {
                currentFilter = 1;
                Navigator.pop(context);
              }, 1),
              const Divider(height: 20),
              buildSelectionRow(Icons.thumb_up_outlined, "Most favorable".tr,
                  () {
                currentFilter = 2;
                Navigator.pop(context);
              }, 2),
              const Divider(height: 20),
              buildSelectionRow(Icons.thumb_down_outlined, "Most critical".tr,
                  () {
                currentFilter = 3;
                Navigator.pop(context);
              }, 3),
            ],
          ),
        );
      },
    );
  }

  buildSelectionRow(icon, title, VoidCallback onTap, i) {
    final index = i;

    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
          ),
          const SizedBox(width: 20),
          Text(
            title,
          ),
          const Spacer(),
          Visibility(
            visible: currentFilter == index ? true : false,
            child: const Icon(
              Icons.check,
            ),
          ),
        ],
      ),
    );
  }
}
