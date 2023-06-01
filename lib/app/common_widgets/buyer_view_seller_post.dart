import 'package:cliver_mobile/app/core/utils/utils.dart';
import 'package:cliver_mobile/app/features/seller/post/controller/post_controller.dart';
import 'package:cliver_mobile/app/features/seller/post/screens/post/controller/manage_post_controller.dart';
import 'package:cliver_mobile/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/utils/size_config.dart';
import '../core/values/app_colors.dart';
import 'loading_container.dart';

class BuyerViewSellerPostScreen extends StatefulWidget {
  const BuyerViewSellerPostScreen({Key? key}) : super(key: key);

  @override
  State<BuyerViewSellerPostScreen> createState() => _BuyerViewSellerPostScreenState();
}

class _BuyerViewSellerPostScreenState extends State<BuyerViewSellerPostScreen> {
  final managePostController = Get.put(ManagePostController());
  final postController = Get.put(PostController());
  var currentFilter = 0;

  @override
  void initState() {
    super.initState();
    managePostController.getAllMyPost(postStatus: 'Active');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: Obx(() {
              if (managePostController.myPostList.isEmpty) {
                return Center(child: Text(managePostController.statusListPost.value));
              } else {
                return ListView.builder(
                  itemBuilder: (context, i) {
                    var post = managePostController.myPostList[i];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 20),
                      padding: const EdgeInsets.symmetric().copyWith(bottom: 10),
                      decoration: BoxDecoration(
                        color: AppColors.primaryWhite,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 2,
                            spreadRadius: 1,
                            offset: const Offset(0, 1),
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 1,
                            spreadRadius: 0,
                            offset: const Offset(0, 1),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              postController.currentPost = managePostController.myPostList[i];
                              Get.toNamed(postDetailScreenRoute, arguments: managePostController.myPostList[i].id);
                            },
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                              child: Image.network(
                                post.images != null ? (post.images!.isNotEmpty ? post.images![0] : '') : '',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 180,
                                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const LoadingContainer(width: double.infinity, height: 180);
                                },
                                errorBuilder: (_, __, ___) => const LoadingContainer(width: double.infinity, height: 180),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: context.screenSize.width * 2 / 3),
                                  child: Text(
                                    post.title ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.star_outlined,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              post.ratingAvg?.toStringAsFixed(2) ?? '0',
                                              style: const TextStyle(color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 3),
                                    Text(
                                      "(${post.ratingCount} ratings)",
                                      style: const TextStyle(color: Colors.grey),
                                    ),
                                    Spacer(),
                                    Text(
                                      FormatHelper().moneyFormat(post.minPrice) ?? "0 VNĐ",
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                                SizedBox(height: getHeight(5)),
                                Text(
                                  post.status ?? '',
                                  style: TextStyle(fontSize: getFont(18), fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: managePostController.myPostList.length,
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
