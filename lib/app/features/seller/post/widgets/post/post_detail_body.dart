import '../../../../../core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../data/models/model.dart';
import '../../../../../../data/services/services.dart';
import '../../../../../controller/controller.dart';
import '../../../../../routes/routes.dart';
import '../../../../features.dart';

class PostDetailBody extends StatefulWidget {
  const PostDetailBody(
      {Key? key, required this.post, required this.onTabSelected})
      : super(key: key);
  final Post post;
  final Function(int) onTabSelected;

  @override
  State<PostDetailBody> createState() => _PostDetailBodyState();
}

class _PostDetailBodyState extends State<PostDetailBody>
    with SingleTickerProviderStateMixin {
  late List<Review> reviews = [];
  late TabController _tabController;
  final oCcy = NumberFormat("#,##0", "vi_VN");
  bool isGetReview = false;

  @override
  void initState() {
    _tabController = TabController(
        length: widget.post.packages?.length == 1 ? 1 : 3, vsync: this);
    getReview();
    super.initState();
  }

  void getReview() async {
    setState(() {
      isGetReview = false;
    });
    EasyLoading.show();
    var res = await PostService.ins.getReviewById(id: widget.post.id!);
    EasyLoading.dismiss();
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
    setState(() {
      isGetReview = true;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TabBar(
          onTap: (value) => widget.onTabSelected(value),
          controller: _tabController,
          indicatorColor: AppColors.primaryColor,
          labelColor: Colors.green,
          unselectedLabelColor: AppColors.secondaryColor,
          indicator: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 0.5, color: AppColors.primaryColor),
            ),
          ),
          tabs: List.generate(
            widget.post.packages!.length,
            (index) => Tab(
              text: "${oCcy.format(widget.post.packages?[index].price)} VNĐ",
            ),
          ),
        ),
        SizedBox(
          height: context.screenSize.height / 3.5,
          child: TabBarView(
            controller: _tabController,
            children: List.generate(
              widget.post.packages!.length,
              (index) => PostPackage(
                package: widget.post.packages?[index],
                type: "${oCcy.format(widget.post.packages?[index].price)} VNĐ",
                canBuy: (widget.post.userId !=
                        Get.find<UserController>().currentUser.value.id)
                    ? true
                    : null,
              ),
            ),
          ),
        ),

        //REVIEW AREA
        Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 0.5, color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            Text(
              "${reviews.length} ${"reviews".tr}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Spacer(),
            TextButton(
              onPressed: () =>
                  Get.toNamed(postReviewScreenRoute, arguments: true),
              child: Text(
                "See All".tr,
                style: TextStyle(color: AppColors.primaryColor),
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        if (isGetReview)
          SizedBox(
            height: 200,
            child: ListView.builder(
              itemBuilder: (context, i) {
                return SizedBox(
                  width: context.screenSize.width * 0.8,
                  child: CustomReviewCardItem(review: reviews[i]),
                );
              },
              itemCount: reviews.length > 5 ? 5 : reviews.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
        const SizedBox(height: 80)
      ],
    );
  }
}
