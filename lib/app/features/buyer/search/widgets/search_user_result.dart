import 'package:get/get.dart';

import '../../../../common_widgets/inkWell_wrapper.dart';
import '../../../../common_widgets/loading_container.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../routes/routes.dart';
import '../../../../../data/models/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../../data/services/services.dart';

class SearchUserResult extends StatefulWidget {
  const SearchUserResult({Key? key, required this.result}) : super(key: key);
  final String result;

  @override
  State<SearchUserResult> createState() => _SearchUserResultState();
}

class _SearchUserResultState extends State<SearchUserResult> {
  List<User> sellers = [];
  late bool isGetData;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    setState(() => isGetData = false);
    EasyLoading.show();
    var res = await UserService.ins.getUser(text: widget.result);
    if (res.isOk) {
      if (res.body["data"] is Iterable<dynamic> &&
          res.body["data"].isNotEmpty) {
        sellers = <User>[];
        res.body["data"].forEach((v) {
          if (v != null) {
            sellers.add(User.fromJson(v));
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
          onPressed: () => Navigator.of(context)
              .pushNamedAndRemoveUntil(searchRoute, (route) => route.isFirst),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.search,
                size: 24, color: AppColors.primaryBlack.withOpacity(0.8)),
          ),
        ],
      ),
      body: isGetData
          ? sellers.isNotEmpty
              ? Container(
                  color: AppColors.scaffoldBackgroundColor,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        sellers.length,
                        (index) => InkWellWrapper(
                            onTap: () => Get.toNamed(sellerProfileScreenRoute,
                                arguments: sellers[index].id),
                            paddingChild: EdgeInsets.symmetric(
                                horizontal: getWidth(15),
                                vertical: getHeight(15)),
                            border: Border.symmetric(
                                horizontal: BorderSide(
                                    color: AppColors.metallicSilver,
                                    width: 0.1)),
                            color: Colors.white,
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    sellers[index].avatar ?? '',
                                    width: getWidth(40),
                                    height: getWidth(40),
                                    fit: BoxFit.cover,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return LoadingContainer(
                                          width: getWidth(40),
                                          height: getWidth(40),
                                          borderRadius:
                                              BorderRadius.circular(20));
                                    },
                                    errorBuilder: (_, __, ___) =>
                                        LoadingContainer(
                                            width: getWidth(40),
                                            height: getWidth(40),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                  ),
                                ),
                                SizedBox(width: getWidth(15)),
                                Text(
                                  sellers[index].name ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: getFont(18),
                                  ),
                                ),
                              ],
                            )),
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
