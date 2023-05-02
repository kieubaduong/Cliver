import 'dart:convert';
import 'package:cliver_mobile/app/common_widgets/inkWell_wrapper.dart';
import 'package:cliver_mobile/app/common_widgets/loading_container.dart';
import 'package:cliver_mobile/app/core/utils/size_config.dart';
import 'package:cliver_mobile/app/core/values/app_colors.dart';
import 'package:cliver_mobile/app/routes/routes.dart';
import 'package:cliver_mobile/data/models/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SellerHistory extends StatefulWidget {
  const SellerHistory({Key? key, this.onTapValueHistory}) : super(key: key);
  final void Function(String)? onTapValueHistory;

  @override
  State<SellerHistory> createState() => _SellerHistoryState();
}

class _SellerHistoryState extends State<SellerHistory> {
  late bool isGetDataAllCategory;
  List<User>? listSellerHistory;

  @override
  void initState() {
    getDataHistory();
    super.initState();
  }

  void getDataHistory() async {
    final prefs = await SharedPreferences.getInstance();
    String sellerHistory = prefs.getString('SellerHistory') ?? '';
    listSellerHistory = sellerHistory.isNotEmpty ? (json.decode(sellerHistory) as List<dynamic>).map<User>((item) => User.fromJson(item)).toList() : null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: listSellerHistory?.isNotEmpty ?? false,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: getHeight(10), horizontal: getWidth(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'recently view seller'.tr,
                    style: TextStyle(fontSize: getFont(18), fontWeight: FontWeight.w700),
                  ),
                  InkWellWrapper(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.remove('SellerHistory');
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
            visible: listSellerHistory?.isNotEmpty ?? false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                listSellerHistory?.length ?? 0,
                (index) => InkWellWrapper(
                    onTap: () => Get.toNamed(sellerProfileScreenRoute, arguments: listSellerHistory?[index].id),
                    paddingChild: EdgeInsets.symmetric(horizontal: getWidth(15), vertical: getHeight(15)),
                    border: Border.symmetric(horizontal: BorderSide(color: AppColors.metallicSilver, width: 0.1)),
                    color: Colors.white,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            listSellerHistory?[index].avatar ?? '',
                            width: getWidth(40),
                            height: getWidth(40),
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return LoadingContainer(width: getWidth(40), height: getWidth(40), borderRadius: BorderRadius.circular(20));
                            },
                            errorBuilder: (_, __, ___) => LoadingContainer(width: getWidth(40), height: getWidth(40), borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                        SizedBox(width: getWidth(15)),
                        Text(
                          listSellerHistory?[index].name ?? '',
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
        ],
      ),
    );
  }
}
