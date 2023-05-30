import 'dart:convert';
import '../../../common_widgets/buyer_view_seller_post.dart';
import '../../../common_widgets/inkWell_wrapper.dart';
import '../../../controller/user_controller.dart';
import '../../../core/utils/size_config.dart';
import '../../bottom_navigation_bar/bottom_bar_controller.dart';
import '../../buyer/home_screen/widgets/widgets.dart';
import '../../seller/post/screens/post/seller_post.dart';
import 'widgets/seller_about.dart';
import '../../../../data/models/model.dart';
import '../../../../data/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/values/app_colors.dart';
import '../../seller/post/screens/post/review_user_screen.dart';

class SellerProfileScreen extends StatefulWidget {
  const SellerProfileScreen({Key? key}) : super(key: key);

  @override
  State<SellerProfileScreen> createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late bool isGetData;
  User user = User();
  late final String id = Get.arguments ?? _userController.currentUser.value.id!;
  final UserController _userController = Get.find();
  final BottomBarController _bottomController = Get.find();

  Future<void> loadData() async {
    setState(() => isGetData = false);
    EasyLoading.show();
    var res = await UserService.ins.getUserById(id: id);
    if (res.isOk) {
      user = User.fromJson(res.body['data']);
    }
    setState(() => isGetData = true);
    final prefs = await SharedPreferences.getInstance();
    String listSellerHistory = prefs.getString('SellerHistory') ?? '';
    List<User> users;
    if (listSellerHistory.isNotEmpty) {
      users = (json.decode(listSellerHistory) as List<dynamic>)
          .map<User>((item) => User.fromJson(item))
          .toList();
      if (!users.any((element) => user.id == element.id)) {
        users.insert(0, user);
      }
    } else {
      users = [user];
    }
    final String encodedData = json.encode(
      users.map<Map<String, dynamic>>((value) => value.toJson()).toList(),
    );
    await prefs.setString('SellerHistory', encodedData);
    EasyLoading.dismiss();
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
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
              actions: [
                Visibility(
                  visible: !_bottomController.isSeller.value,
                  child: Visibility(
                    visible: _userController.currentUser.value.id != user.id,
                    child: InkWellWrapper(
                        paddingChild: const EdgeInsets.all(5),
                        borderRadius: BorderRadius.circular(20),
                        onTap: () async {
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            backgroundColor: AppColors.primaryWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                            ),
                            builder: (BuildContext context) {
                              return BottomSaveList(
                                sellerId: user.id!,
                                icon: user.avatar,
                                onTapChangeStatus: (value) async {
                                  await SaveServiceAPI.ins
                                      .changeStatusSellerSaveListById(
                                          listId: value, sellerId: user.id!);
                                },
                              );
                            },
                          ).then((value) {
                            loadData();
                          });
                        },
                        child: user.isSaved!
                            ? const Icon(Icons.favorite_outlined,
                                size: 22, color: Colors.red)
                            : const Icon(Icons.favorite_border_outlined,
                                size: 22)),
                  ),
                )
              ],
            ),
            body: DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: 0.5, color: AppColors.primaryColor),
                      ),
                    ),
                    tabs: [
                      Tab(
                        text: "About".tr,
                      ),
                      Tab(
                        text: "Posts".tr,
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
                        tempUser: user,
                        onSave: (value) async {
                          EasyLoading.show();
                          await UserService.ins.updateInfoUser(user: value);
                          await loadData();
                        },
                      ),
                      _bottomController.isSeller.value
                          ? const SellerPostScreen(unHideAppBar: false)
                          : const BuyerViewSellerPostScreen(),
                      const UserReviewScreen(),
                    ],
                  ),
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
