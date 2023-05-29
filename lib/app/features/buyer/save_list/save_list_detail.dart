import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../../data/models/model.dart';
import '../../../../data/services/services.dart';
import '../../../common_widgets/common_widgets.dart';
import '../../../controller/user_controller.dart';
import '../../../core/core.dart';
import '../../../routes/routes.dart';
import '../../features.dart';

class SaveListDetail extends StatefulWidget {
  const SaveListDetail({Key? key}) : super(key: key);

  @override
  State<SaveListDetail> createState() => _SaveListDetailState();
}

class _SaveListDetailState extends State<SaveListDetail> {
  SaveService saveService = Get.arguments;
  late ScrollController _controller;
  final UserController _userController = Get.find();
  bool sliverActionsHidden = false;
  List<Post> postService = [];
  late bool isGetData;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    loadData();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_controller.offset >=
        _controller.position.maxScrollExtent -
            AppBar().preferredSize.height -
            85) {
      setState(() {
        sliverActionsHidden = true;
      });
    } else {
      setState(() {
        sliverActionsHidden = false;
      });
    }
  }

  Future<void> loadData() async {
    setState(() => isGetData = false);
    EasyLoading.show();
    var res =
        await SaveServiceAPI.ins.getSaveListServiceById(id: saveService.id!);
    if (res.isOk) {
      if (res.body["data"] is Iterable<dynamic> &&
          res.body["data"].isNotEmpty) {
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
    return SafeArea(
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            controller: _controller,
            headerSliverBuilder: (context, isCollab) {
              return [
                SliverAppBar(
                  expandedHeight: getHeight(260),
                  pinned: true,
                  forceElevated: true,
                  snap: false,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Visibility(
                      visible: sliverActionsHidden,
                      child: Text(
                        saveService.name ?? '',
                        style: TextStyle(
                            fontSize: getFont(23)),
                      ),
                    ),
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          'https://images.pexels.com/photos/206359/pexels-photo-206359.jpeg?auto=compress&cs=tinysrgb&w=1600',
                          width: getWidth(MediaQuery.of(context).size.width),
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return LoadingContainer(
                              width:
                                  getWidth(MediaQuery.of(context).size.width),
                            );
                          },
                          errorBuilder: (_, __, ___) => LoadingContainer(
                            height: getHeight(175),
                            width: getWidth(MediaQuery.of(context).size.width),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              saveService.name ?? '',
                              style: TextStyle(
                                  color: AppColors.primaryWhite,
                                  fontSize: getFont(23)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: getHeight(35), bottom: getHeight(20)),
                              child: Text(
                                '${'Created'.tr} ${'by'.tr} ${_userController.currentUser.value.name}',
                                style: TextStyle(
                                  color: AppColors.primaryWhite,
                                  fontSize: getFont(16),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  actions: [
                    IconButton(
                      iconSize: 30.0,
                      onPressed: () async {
                        await showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          backgroundColor: AppColors.primaryWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                          ),
                          builder: (BuildContext context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: getWidth(60),
                                  height: getHeight(2),
                                  margin: EdgeInsets.symmetric(
                                      vertical: getHeight(10)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: AppColors.metallicSilver,
                                  ),
                                ),
                                InkWellWrapper(
                                  onTap: () {
                                    showGeneralDialog(
                                      context: context,
                                      pageBuilder: (BuildContext buildContext,
                                          Animation<double> animation,
                                          Animation<double>
                                              secondaryAnimation) {
                                        return RenameSaveList(
                                            name: saveService.name,
                                            id: saveService.id!);
                                      },
                                      barrierDismissible: true,
                                      barrierLabel:
                                          MaterialLocalizations.of(context)
                                              .modalBarrierDismissLabel,
                                      barrierColor: Colors.transparent,
                                      transitionDuration:
                                          const Duration(milliseconds: 200),
                                    );
                                  },
                                  paddingChild: EdgeInsets.symmetric(
                                      vertical: getHeight(20),
                                      horizontal: getHeight(15)),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.border_color_outlined,
                                          size: 24),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: getWidth(20)),
                                          child: Text(
                                            'Edit name'.tr,
                                            style: TextStyle(
                                                fontSize: getFont(20)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWellWrapper(
                                  onTap: () async {
                                    EasyLoading.show();
                                    await SaveServiceAPI.ins
                                        .deleteSaveListServiceById(
                                            id: saveService.id!);
                                    EasyLoading.dismiss();
                                    if (!mounted) {
                                      return;
                                    }
                                    Navigator.of(context)
                                      ..pop()
                                      ..pop()
                                      ..pop()
                                      ..pushNamed(saveListRoute);
                                  },
                                  paddingChild: EdgeInsets.symmetric(
                                      vertical: getHeight(20),
                                      horizontal: getHeight(15)),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.delete,
                                        size: 24,
                                        color: Colors.redAccent,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: getWidth(20)),
                                          child: Text(
                                            'Delete list'.tr,
                                            style: TextStyle(
                                                fontSize: getFont(20),
                                                color: Colors.redAccent),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.more_vert),
                    )
                  ],
                  iconTheme: IconThemeData(
                      color: sliverActionsHidden
                          ? AppColors.primaryBlack
                          : AppColors.primaryWhite),
                ),
                SliverPersistentHeader(
                  delegate: MyDelegate(
                    TabBar(
                      tabs: [
                        Tab(text: 'service'.tr),
                        Tab(text: 'seller'.tr),
                      ],
                      indicatorColor: AppColors.greenCrayola,
                      unselectedLabelColor: AppColors.primaryBlack,
                      labelColor: AppColors.greenCrayola,
                    ),
                  ),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(
              children: [
                ServiceSaveList(saveListId: saveService.id!),
                SellerSaveList(saveListId: saveService.id!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyDelegate extends SliverPersistentHeaderDelegate {
  MyDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.primaryWhite,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
