import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/core.dart';
import 'widgets/search_user_result.dart';
import 'widgets/widgets.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  late TextEditingController controller;
  late TabController tabController = TabController(length: 2, vsync: this);

  @override
  void initState() {
    controller = TextEditingController();
    tabController.addListener(() {
      setState(() {});
      controller.clear();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryWhite,
        title: TextField(
          controller: controller,
          autofocus: true,
          onSubmitted: (value) async {
            final prefs = await SharedPreferences.getInstance();
            if (tabController.index == 0) {
              List<String> listServiceHistory =
                  prefs.getStringList('ServiceHistory') ?? [];
              if (!listServiceHistory.contains(value)) {
                listServiceHistory.insert(0, value);
              }
              await prefs.setStringList('ServiceHistory', listServiceHistory);
              showGeneralDialog(
                context: context,
                pageBuilder: (BuildContext buildContext,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return SearchResult(result: controller.text);
                },
                barrierDismissible: true,
                barrierLabel: 'abc',
                barrierColor: AppColors.primaryWhite,
                transitionDuration: const Duration(milliseconds: 200),
              ).then((value) => controller.clear());
            } else {
              showGeneralDialog(
                context: context,
                pageBuilder: (BuildContext buildContext,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return SearchUserResult(result: controller.text);
                },
                barrierDismissible: true,
                barrierLabel: 'abc',
                barrierColor: AppColors.primaryWhite,
                transitionDuration: const Duration(milliseconds: 200),
              );
            }
          },
          decoration: InputDecoration(
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintText: tabController.index == 0
                  ? 'Search your services'.tr
                  : 'Search your sellers'.tr,
              hintStyle: TextStyle(
                  color: AppColors.metallicSilver,
                  fontWeight: FontWeight.w700,
                  fontSize: getFont(20))),
        ),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(text: 'service'.tr),
            Tab(text: 'seller'.tr),
          ],
          indicatorColor: AppColors.greenCrayola,
        ),
      ),
      backgroundColor: AppColors.metallicSilver.withOpacity(0.01),
      body: TabBarView(
        controller: tabController,
        children: [
          ServiceHistory(
            onTapGetValueHistory: (value) {
              controller.text = value;
              controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller.text.length));
            },
            onTapValueHistory: (value) {
              showGeneralDialog(
                context: context,
                pageBuilder: (BuildContext buildContext,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return SearchResult(result: value);
                },
                barrierDismissible: true,
                barrierLabel: 'abc',
                barrierColor: Colors.transparent,
                transitionDuration: const Duration(milliseconds: 200),
              ).then((value) => controller.clear());
            },
          ),
          const SellerHistory()
        ],
      ),
    );
  }
}
