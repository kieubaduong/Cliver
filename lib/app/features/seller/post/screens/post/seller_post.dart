import 'dart:developer';

import '../../../../../common_widgets/horizontal_post_item.dart';
import '../../../../../common_widgets/inkWell_wrapper.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../../core/values/app_colors.dart';
import '../../../../bottom_navigation_bar/bottom_bar_controller.dart';
import '../../controller/post_controller.dart';
import 'controller/manage_post_controller.dart';
import '../../../../../routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerPostScreen extends StatefulWidget {
  const SellerPostScreen({Key? key, this.unHideAppBar = false})
      : super(key: key);

  final bool unHideAppBar;

  @override
  State<SellerPostScreen> createState() => _SellerPostScreenState();
}

class _SellerPostScreenState extends State<SellerPostScreen> {
  final managePostController = Get.put(ManagePostController());
  final postController = Get.put(PostController());
  final BottomBarController _bottomController = Get.find();
  var currentFilter = 1;

  @override
  void initState() {
    super.initState();
    managePostController.getAllMyPost(postStatus: 'Active');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: widget.unHideAppBar,
        title: const Text(
          "Manage post",
        ),
        actions: [
          Visibility(
            visible: _bottomController.isSeller.value,
            child: GestureDetector(
              onTap: () {
                Get.toNamed(addPostScreenRoute);
              },
              child: const Icon(Icons.add),
            ),
          ),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: () {
              showBottom();
            },
            child: const Icon(Icons.filter_list),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: Obx(() {
              if (managePostController.myPostList.isEmpty) {
                return Center(
                    child: Text(managePostController.statusListPost.value));
              } else {
                return ListView.builder(
                  itemBuilder: (context, i) {
                    return HorizontalPostItem(
                      onTap: widget.unHideAppBar
                          ? () => Get.back(
                              result: managePostController.myPostList[i])
                          : () {
                              postController.currentPost =
                                  managePostController.myPostList[i];
                              Get.toNamed(postDetailScreenRoute,
                                  arguments:
                                      managePostController.myPostList[i].id);
                            },
                      loadPost: () {
                        setState(() {
                          switch (currentFilter) {
                            case 0:
                              managePostController.getAllMyPost();
                              break;
                            case 1:
                              managePostController.getAllMyPost(
                                  postStatus: 'Active');
                              break;
                            default:
                              break;
                          }
                        });
                      },
                      deleteDraft: () {
                        setState(() {
                          switch (currentFilter) {
                            case 0:
                              managePostController.getAllMyPost();
                              break;
                            case 1:
                              managePostController.getAllMyPost(
                                  postStatus: 'Active');
                              break;
                            case 3:
                              managePostController.getAllMyPost(
                                  postStatus: 'Draft');
                              break;
                            default:
                              break;
                          }
                        });
                      },
                      thisPost: managePostController.myPostList[i],
                    );
                  },
                  itemCount: managePostController.myPostList.length,
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  void showBottom() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Wrap(
            children: [
              const Text(
                "Sort by",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              buildSelectionRow(Icons.format_list_bulleted_outlined, "All", () {
                currentFilter = 0;
                Navigator.pop(context);
                managePostController.getAllMyPost();
              }, 0),
              buildSelectionRow(Icons.done_all, "Active", () {
                currentFilter = 1;
                Navigator.pop(context);
                managePostController.getAllMyPost(postStatus: "Active");
              }, 1),
              buildSelectionRow(Icons.pause_circle, "Paused", () {
                currentFilter = 2;
                Navigator.pop(context);
                managePostController.getAllMyPost(postStatus: "Paused");
              }, 2),
              buildSelectionRow(Icons.work_outline, "Draft", () {
                currentFilter = 3;
                Navigator.pop(context);
                managePostController.getAllMyPost(postStatus: "Draft");
              }, 3),
            ],
          ),
        );
      },
    );
  }

  buildSelectionRow(icon, title, VoidCallback onTap, i) {
    final index = i;

    return InkWellWrapper(
      border: index != 3
          ? Border(
              bottom: BorderSide(color: AppColors.metallicSilver, width: 0.5))
          : null,
      paddingChild: EdgeInsets.symmetric(
          vertical: getHeight(10), horizontal: getWidth(10)),
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.start,
            ),
          ),
          Visibility(
            visible: currentFilter == index ? true : false,
            child: const Icon(
              Icons.check,
            ),
          ),
        ],
      ),
    );
  }
}
