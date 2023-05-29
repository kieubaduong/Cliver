import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../data/models/model.dart';
import '../../../../../data/services/services.dart';
import '../../../../common_widgets/common_widgets.dart';
import '../../../../core/core.dart';
import '../../../../routes/routes.dart';
import '../../../features.dart';

class ServiceHistory extends StatefulWidget {
  const ServiceHistory({Key? key, this.onTapValueHistory, this.onTapGetValueHistory}) : super(key: key);
  final void Function(String)? onTapGetValueHistory;
  final void Function(String)? onTapValueHistory;

  @override
  State<ServiceHistory> createState() => _ServiceHistoryState();
}

class _ServiceHistoryState extends State<ServiceHistory> {
  late List<Post> post = [];
  late List<String> listServiceHistory = [];
  late bool isGetDataPostsRecent;

  @override
  void initState() {
    getPostsRecent();
    getDataHistory();
    super.initState();
  }

  void getDataHistory() async {
    final prefs = await SharedPreferences.getInstance();
    listServiceHistory = prefs.getStringList('ServiceHistory') ?? [];
  }

  void getPostsRecent() async {
    setState(() {
      isGetDataPostsRecent = false;
    });
    EasyLoading.show();
    var res = await PostService.ins.getPostsRecently();
    EasyLoading.dismiss();
    if (res.isOk) {
      if (res.body["data"] is Iterable<dynamic> && res.body["data"].isNotEmpty) {
        post = <Post>[];
        res.body["data"].forEach((v) {
          if (v != null) {
            post.add(Post.fromJson(v));
          }
        });
      }
    }
    setState(() {
      isGetDataPostsRecent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: listServiceHistory.isNotEmpty,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: getHeight(10), horizontal: getWidth(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'search service history'.tr,
                    style: TextStyle(fontSize: getFont(18), fontWeight: FontWeight.w700),
                  ),
                  InkWellWrapper(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.remove('ServiceHistory');
                      getDataHistory();
                      setState(() {});
                    },
                    paddingChild: EdgeInsets.all(getWidth(5)),
                    child: Text(
                      'clear history'.tr,
                      style: TextStyle(fontSize: getFont(18), color: Colors.redAccent),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: listServiceHistory.isNotEmpty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                listServiceHistory.length <= 10 ? listServiceHistory.length : 10,
                (index) => InkWellWrapper(
                    onTap: () => widget.onTapValueHistory?.call(listServiceHistory[index]),
                    paddingChild: EdgeInsets.symmetric(horizontal: getWidth(5), vertical: getHeight(5)),
                    border: Border.symmetric(horizontal: BorderSide(color: AppColors.metallicSilver, width: 0.1)),
                    color: AppColors.primaryWhite,
                    child: Row(
                      children: [
                        Icon(Icons.schedule_outlined, size: getWidth(22)),
                        SizedBox(width: getWidth(10)),
                        Text(
                          listServiceHistory[index],
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: getFont(18),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InkWellWrapper(
                              paddingChild: EdgeInsets.all(getWidth(10)),
                              borderRadius: BorderRadius.circular(20),
                              onTap: () => widget.onTapGetValueHistory?.call(listServiceHistory[index]),
                              child: Icon(
                                Icons.north_west,
                                size: getWidth(24),
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: getHeight(10), horizontal: getWidth(15)),
            child: Text(
              'recently view service'.tr,
              style: TextStyle(fontSize: getFont(18), fontWeight: FontWeight.w700),
            ),
          ),
          if (isGetDataPostsRecent)
          SizedBox(
            height: getHeight(280),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: getWidth(20), vertical: getHeight(10)),
              itemBuilder: (BuildContext context, int index) {
                return CategoryHistoryItem(
                  postHistory: post[index],
                  getPostsRecent: getPostsRecent,
                  onTap: () => Get.toNamed(postDetailScreenRoute, arguments: post[index].id),
                  onChangedStatus: (value) async {
                    EasyLoading.show();
                    await SaveServiceAPI.ins.changeStatusServicesSaveListById(listId: value, serviceId: post[index].id!);
                    EasyLoading.dismiss();
                  },
                );
              },
              itemCount: post.length,
              separatorBuilder: (context, index) => const SizedBox(width: 5),
            ),
          ),
        ],
      ),
    );
  }
}
