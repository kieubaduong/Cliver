import 'package:cliver_mobile/app/core/utils/size_config.dart';
import 'package:cliver_mobile/app/core/values/app_colors.dart';
import 'package:cliver_mobile/app/features/user_profile/screens/widgets/seller_about.dart';
import 'package:cliver_mobile/data/models/model.dart';
import 'package:cliver_mobile/data/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../controller/user_controller.dart';
import '../../seller/post/screens/post/review_user_screen.dart';

class BuyerProfileScreen extends StatefulWidget {
  const BuyerProfileScreen({Key? key}) : super(key: key);

  @override
  State<BuyerProfileScreen> createState() => _BuyerProfileScreenState();
}

class _BuyerProfileScreenState extends State<BuyerProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late bool isGetData;
  User user = User();
  User tempUser = User();
  final String id = Get.arguments;

  Future<void> loadData() async {
    setState(() => isGetData = false);
    EasyLoading.show();
    var res = await UserService.ins.getUserById(id: id);
    if (res.isOk) {
      user = User.fromJson(res.body['data']);
      tempUser = User.fromJson(res.body['data']);
      final UserController userController = Get.find();
      userController.currentUser.value = user;
    }
    EasyLoading.dismiss();
    setState(() => isGetData = true);
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    loadData();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isGetData
        ? Scaffold(
            appBar: AppBar(
              title: Text(user.name ?? '',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: getFont(20))),
              centerTitle: true,
            ),
            body: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    border: Border(
                      bottom:
                          BorderSide(width: 0.5, color: AppColors.primaryColor),
                    ),
                  ),
                  tabs: [
                    Tab(
                      text: "About".tr,
                    ),
                    Tab(
                      text: "Reviews".tr,
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(10),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SellerAbout(
                      user: user,
                      tempUser: tempUser,
                      onSave: (value) async {
                        EasyLoading.show();
                        await UserService.ins.updateInfoUser(user: value);
                        await loadData();
                      },
                      isEdit: true,
                    ),
                    const UserReviewScreen(),
                  ],
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
