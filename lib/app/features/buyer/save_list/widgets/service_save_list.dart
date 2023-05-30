import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../../data/models/model.dart';
import '../../../../../data/services/services.dart';
import '../../../../common_widgets/common_widgets.dart';
import '../../../../core/core.dart';

class ServiceSaveList extends StatefulWidget {
  const ServiceSaveList({Key? key, required this.saveListId}) : super(key: key);
  final int saveListId;

  @override
  State<ServiceSaveList> createState() => _ServiceSaveListState();
}

class _ServiceSaveListState extends State<ServiceSaveList> {
  late bool isGetData;
  late List<Post> postService = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() => isGetData = false);
    EasyLoading.show();
    var res = await SaveServiceAPI.ins.getSaveListServiceById(id: widget.saveListId);
    if (res.isOk) {
      postService.clear();
      if (res.body["data"] is Iterable<dynamic> && res.body["data"].isNotEmpty) {
        postService = <Post>[];
        res.body["data"].forEach((v) {
          if (v != null) {
            postService.add(Post.fromJson(v));
          }
        });
      }
    }
    EasyLoading.dismiss();
    setState(() => isGetData = true);
  }

  @override
  Widget build(BuildContext context) {
    return isGetData
        ? SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: List.generate(
                postService.length,
                (index) => InkWellWrapper(
                  onTap: () {},
                  margin: EdgeInsets.symmetric(horizontal: getWidth(15), vertical: getHeight(10)),
                  height: getHeight(125),
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.primaryWhite,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 3,
                      spreadRadius: 1,
                      offset: const Offset(0, 1),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 2,
                      spreadRadius: 0,
                      offset: const Offset(0, 1),
                    )
                  ],
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                        child: Image.network(
                          postService[index].images?[0] ?? '',
                          height: getHeight(125),
                          width: getWidth(155),
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return LoadingContainer(
                              width: getWidth(MediaQuery.of(context).size.width),
                            );
                          },
                          errorBuilder: (_, __, ___) => LoadingContainer(
                            height: getHeight(125),
                            width: getWidth(155),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: getHeight(5), left: getWidth(10), right: getWidth(10)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.star, color: AppColors.rajah, size: 16),
                                  Padding(
                                    padding: EdgeInsets.only(left: getWidth(3), right: getWidth(3)),
                                    child: Text(
                                      postService[index].ratingAvg?.toStringAsFixed(2) ?? '0',
                                      style: TextStyle(color: AppColors.rajah, fontSize: 14, fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Expanded(child: Text("(${postService[index].ratingCount ?? 0})", style: TextStyle(color: AppColors.metallicSilver, fontSize: 14))),
                                  InkWellWrapper(
                                    paddingChild: const EdgeInsets.all(5),
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () async {
                                      EasyLoading.show();
                                      await SaveServiceAPI.ins.changeStatusServicesSaveListById(listId: widget.saveListId, serviceId: postService[index].id!);
                                      await loadData();
                                    },
                                    child: postService[index].isSaved! ? const Icon(Icons.favorite_outlined, size: 22, color: Colors.red) : const Icon(Icons.favorite_border_outlined, size: 22),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: getWidth(10), right: getWidth(10)),
                                child: Text(
                                  postService[index].title ?? '',
                                  style: TextStyle(color: AppColors.primaryBlack, fontSize: 12, fontWeight: FontWeight.w700),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.only(left: getWidth(10), right: getWidth(10)),
                                child: Text(
                                  postService[index].description ?? '',
                                  style: TextStyle(color: AppColors.primaryBlack, fontSize: 12, fontWeight: FontWeight.w700),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                margin: EdgeInsets.only(left: getWidth(10), right: getWidth(15), bottom: getHeight(10)),
                                child: RichText(
                                  text: TextSpan(text: 'From'.tr, style: TextStyle(color: AppColors.metallicSilver, fontSize: 12), children: [
                                    TextSpan(
                                      text: " ${postService[index].minPrice} VNĐ",
                                      style: TextStyle(color: AppColors.primaryBlack, fontSize: 14, fontWeight: FontWeight.w700),
                                    )
                                  ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
