import 'package:cliver_mobile/app/common_widgets/inkWell_wrapper.dart';
import 'package:cliver_mobile/app/common_widgets/loading_container.dart';
import 'package:cliver_mobile/app/core/utils/size_config.dart';
import 'package:cliver_mobile/app/core/values/app_colors.dart';
import 'package:cliver_mobile/app/routes/routes.dart';
import 'package:cliver_mobile/data/services/PostService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../../data/models/model.dart';
import '../../../../core/utils/utils.dart';

class SearchResultCategory extends StatefulWidget {
  const SearchResultCategory({Key? key, required this.result}) : super(key: key);
  final SubCategory result;

  @override
  State<SearchResultCategory> createState() => _SearchResultCategoryState();
}

class _SearchResultCategoryState extends State<SearchResultCategory> {
  List<Post> postService = [];
  late bool isGetData;

  @override
  void initState() {
    loadData(subCategoryId: widget.result.id);
    super.initState();
  }

  Future<void> loadData({int? subCategoryId}) async {
    setState(() => isGetData = false);
    EasyLoading.show();
    var res = await PostService.ins.getPosts(
      subCategoryId: subCategoryId,
    );
    if (res.isOk) {
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
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: AppBar(
        title: Text(
          widget.result.name ?? '',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: getFont(22)),
        ),
        backgroundColor: AppColors.primaryWhite,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(searchRoute, (route) => route.isFirst),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: isGetData
          ? postService.isNotEmpty
          ? Container(
        color: AppColors.scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(
              postService.length,
                  (index) => InkWellWrapper(
                onTap: () => Get.toNamed(postDetailScreenRoute, arguments: postService[index].id),
                margin: EdgeInsets.symmetric(horizontal: getWidth(15), vertical: getHeight(10)),
                height: getHeight(140),
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
                        height: getHeight(140),
                        width: getWidth(155),
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return LoadingContainer(
                            height: getHeight(140),
                            width: getWidth(155),
                          );
                        },
                        errorBuilder: (_, __, ___) => LoadingContainer(
                          height: getHeight(140),
                          width: getWidth(155),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: getHeight(10), horizontal: getWidth(10)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.star, color: AppColors.rajah, size: 16),
                                Padding(
                                    padding: EdgeInsets.only(left: getWidth(3), right: getWidth(3)),
                                    child: Text(postService[index].ratingAvg?.toStringAsFixed(2) ?? '0', style: TextStyle(color: AppColors.rajah, fontSize: 14, fontWeight: FontWeight.w700))),
                                Expanded(child: Text("(${postService[index].ratingCount ?? 0})", style: TextStyle(color: AppColors.metallicSilver, fontSize: 14))),
                                InkWellWrapper(
                                    paddingChild: const EdgeInsets.all(5),
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () {},
                                    child: const Icon(Icons.favorite_outlined, size: 22, color: Colors.redAccent))
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: getWidth(10), right: getWidth(10)),
                              child: Text(
                                postService[index].title ?? '',
                                style: TextStyle(color: AppColors.primaryBlack, fontSize: 12, fontWeight: FontWeight.w700),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: getWidth(10), right: getWidth(10)),
                              child: Text(
                                postService[index].description ?? '',
                                style: TextStyle(color: AppColors.primaryBlack, fontSize: 12, fontWeight: FontWeight.w700),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              margin: EdgeInsets.only(left: getWidth(10), right: getWidth(15), bottom: getHeight(5), top: getHeight(5)),
                              child: RichText(
                                text: TextSpan(text: 'From ', style:  TextStyle(color: AppColors.metallicSilver, fontSize: 12), children: [
                                  TextSpan(
                                    text: FormatHelper().moneyFormat(postService[index].minPrice).toString(),
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
        ),
      )
          : Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.search,
              size: 24,
            ),
            Text('No result'),
          ],
        ),
      )
          : null,
    );
  }
}