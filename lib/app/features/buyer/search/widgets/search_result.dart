import 'package:cliver_mobile/app/common_widgets/inkWell_wrapper.dart';
import 'package:cliver_mobile/app/common_widgets/loading_container.dart';
import 'package:cliver_mobile/app/core/utils/size_config.dart';
import 'package:cliver_mobile/app/core/values/app_colors.dart';
import 'package:cliver_mobile/app/features/buyer/search/widgets/widgets.dart';
import 'package:cliver_mobile/app/routes/routes.dart';
import 'package:cliver_mobile/data/models/post.dart';
import 'package:cliver_mobile/data/services/PostService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../core/utils/utils.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({Key? key, required this.result}) : super(key: key);
  final String result;

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  List<Post> postService = [];
  late bool isGetData;
  List<String> tagFilter = [];
  List<dynamic> statusFilter = [
    0,
    0,
    null,
    null,
    null,
    0,
  ];

  @override
  void initState() {
    loadData(search: widget.result);
    super.initState();
  }

  Future<void> loadData({String? search, int? minPrice, int? maxPrice, int? deliveryTime, String? filter, int? categoryId, int? offset, int? limit, int? subCategoryId}) async {
    setState(() => isGetData = false);
    EasyLoading.show();
    var res = await PostService.ins.getPosts(
      search: widget.result,
      minPrice: minPrice,
      maxPrice: maxPrice,
      deliveryTime: deliveryTime,
      filter: filter,
      categoryId: categoryId,
      subCategoryId: subCategoryId,
      limit: limit,
      offset: offset,
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
          widget.result,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: getFont(22)),
        ),
        backgroundColor: AppColors.primaryWhite,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(searchRoute, (route) => route.isFirst),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.search, size: 24, color: AppColors.primaryBlack.withOpacity(0.8)),
          ),
          IconButton(
            onPressed: () {
              showGeneralDialog(
                context: context,
                pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
                  return FilterDialog(
                      search: widget.result,
                      onSubmit: loadData,
                      saveStatusFilter: (value) {
                        setState(() {
                          statusFilter = value;
                          tagFilter.clear();
                          if (statusFilter[1] != 0) tagFilter.add('Categories');
                          if (statusFilter[2] != null && statusFilter[2] != 0) tagFilter.add('Service type');
                          if (statusFilter[3] != null || statusFilter[4] != null) tagFilter.add('Price');
                          if (statusFilter[5] != 0) tagFilter.add('Delivery Time');
                        });
                      },
                      statusFilterDialog: statusFilter);
                },
                barrierDismissible: true,
                barrierLabel: 'abc',
                barrierColor: AppColors.primaryWhite,
                transitionDuration: const Duration(milliseconds: 200),
              );
            },
            icon: Image.asset("assets/icons/filter.png", color: AppColors.primaryBlack.withOpacity(0.8), width: 24, height: 24),
          )
        ],
      ),
      body: isGetData
          ? postService.isNotEmpty
              ? Container(
                color: AppColors.scaffoldBackgroundColor,
                child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: tagFilter.isNotEmpty,
                          child: Padding(
                            padding: EdgeInsets.only(top: getHeight(20), left: getWidth(15)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Shop by',
                                  style: TextStyle(fontSize: getFont(20), fontWeight: FontWeight.w700),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: getHeight(10)),
                                  height: getHeight(40),
                                  child: ListView.separated(
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: EdgeInsets.symmetric(horizontal: getWidth(10), vertical: getHeight(5)),
                                          decoration:
                                              BoxDecoration(color: AppColors.primaryWhite, border: Border.all(color: AppColors.metallicSilver, width: 0.3), borderRadius: BorderRadius.circular(15)),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.check,
                                                size: getWidth(20),
                                                color: AppColors.greenCrayola,
                                              ),
                                              SizedBox(width: getWidth(5)),
                                              Text(tagFilter[index]),
                                            ],
                                          ),
                                        );
                                      },
                                      scrollDirection: Axis.horizontal,
                                      separatorBuilder: (context, index) => SizedBox(width: getWidth(10)),
                                      itemCount: tagFilter.length),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
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
                      ],
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
