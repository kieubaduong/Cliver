import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../../data/models/post.dart';
import '../../data/services/services.dart';
import '../core/core.dart';
import '../features/seller/post/controller/post_controller.dart';
import '../routes/routes.dart';
import 'common_widgets.dart';

class HorizontalPostItem extends StatefulWidget {
  const HorizontalPostItem(
      {Key? key,
      required this.onTap,
      required this.thisPost,
      this.loadPost,
      this.deleteDraft})
      : super(key: key);

  final VoidCallback onTap;
  final void Function()? loadPost;
  final void Function()? deleteDraft;
  final Post thisPost;

  @override
  State<HorizontalPostItem> createState() => _HorizontalPostItemState();
}

class _HorizontalPostItemState extends State<HorizontalPostItem> {
  final postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.4,
        motion: const ScrollMotion(),
        children: [
          Visibility(
            visible: widget.thisPost.status == 'Paused',
            child: InkWellWrapper(
              onTap: () async {
                await PostService.ins
                    .putPostStatus(id: widget.thisPost.id!, status: 'Active');
                widget.loadPost?.call();
              },
              color: const Color(0xFF7BC043),
              paddingChild: EdgeInsets.symmetric(
                  horizontal: getWidth(20), vertical: getHeight(30)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.archive, color: AppColors.primaryWhite),
                  Text(
                    'Active',
                    style: TextStyle(color: AppColors.primaryWhite),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: widget.thisPost.status == 'Active',
            child: InkWellWrapper(
              onTap: () async {
                await PostService.ins
                    .putPostStatus(id: widget.thisPost.id!, status: "Paused");
                widget.loadPost?.call();
              },
              color: Colors.amber,
              paddingChild: EdgeInsets.symmetric(
                  horizontal: getWidth(20), vertical: getHeight(30)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.save, color: AppColors.primaryWhite),
                  Text(
                    'Paused',
                    style: TextStyle(color: AppColors.primaryWhite),
                  ),
                ],
              ),
            ),
          ),
          InkWellWrapper(
            onTap: () {
              postController.currentPost = widget.thisPost;
              Get.toNamed(editPostScreenRoute);
            },
            color: const Color(0xFF0392CF),
            paddingChild: EdgeInsets.symmetric(
                horizontal: getWidth(20), vertical: getHeight(30)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.edit, color: AppColors.primaryWhite),
                Text(
                  'Edit',
                  style: TextStyle(color: AppColors.primaryWhite),
                ),
              ],
            ),
          ),
          Visibility(
            visible: widget.thisPost.status == 'Draft',
            child: InkWellWrapper(
              onTap: () async {
                EasyLoading.show();
                EasyLoading.dismiss();
                widget.deleteDraft?.call();
              },
              color: Colors.pink,
              paddingChild: EdgeInsets.symmetric(
                  horizontal: getWidth(20), vertical: getHeight(30)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.delete, color: AppColors.primaryWhite),
                  Text(
                    'Delete',
                    style: TextStyle(color: AppColors.primaryWhite),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      child: Container(
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
              onTap: widget.thisPost.status != 'Draft' ? widget.onTap : null,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                child: Image.network(
                  widget.thisPost.images != null
                      ? (widget.thisPost.images!.isNotEmpty
                          ? widget.thisPost.images![0]
                          : '')
                      : '',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 180,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const LoadingContainer(
                        width: double.infinity, height: 180);
                  },
                  errorBuilder: (_, __, ___) => const LoadingContainer(
                      width: double.infinity, height: 180),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10).copyWith(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: context.screenSize.width * 2 / 3),
                    child: Text(
                      widget.thisPost.title ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star_outlined,
                                color: Colors.white,
                                size: 20,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                widget.thisPost.ratingAvg?.toStringAsFixed(2) ??
                                    '0',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        "(${widget.thisPost.ratingCount} ${'ratings'.tr})",
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const Spacer(),
                      Text(
                        FormatHelper().moneyFormat(widget.thisPost.minPrice) ??
                            "0 VNĐ",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(height: getHeight(5)),
                  Text(
                    widget.thisPost.status?.tr ?? '',
                    style: TextStyle(
                        fontSize: getFont(18), fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
