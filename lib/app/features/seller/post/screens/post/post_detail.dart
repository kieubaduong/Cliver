import '../../../../../core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../../../../data/models/model.dart';
import '../../../../../../data/services/services.dart';
import '../../../../../common_widgets/common_widgets.dart';
import '../../../../../controller/controller.dart';
import '../../../../../routes/routes.dart';
import '../../../../features.dart';

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({Key? key}) : super(key: key);

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final controller = PageController();
  final _paymentController = Get.put(PaymentController());
  final _userController = Get.find<UserController>();
  final id = Get.arguments as int;
  Post? post;
  bool isGetPost = true;

  @override
  void initState() {
    super.initState();
    final reviewController = Get.put(ReviewController());
    reviewController.postId = id;
    reviewController.onClose();
    getPostByID();
  }

  Future<void> getPostByID() async {
    setState(() {
      isGetPost = false;
    });
    EasyLoading.show();
    var res = await PostService.ins.getPostById(id: id);
    EasyLoading.dismiss();
    if (res.isOk) {
      if (res.body["data"] != null) {
        post = Post.fromJson(res.body['data']);
        _paymentController.post = post!;
      }
    }
    setState(() {
      isGetPost = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isGetPost
          ? CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  delegate: CustomSliverAppBarDelegate(
                    expandedHeight: context.screenSize.height / 2,
                    images: post?.images,
                  ),
                  pinned: true,
                ),
                buildBody(),
              ],
            )
          : null,
      floatingActionButton: Visibility(
        visible: (post?.userId == _userController.currentUser.value.id)
            ? false
            : true,
        child: FloatingActionButton.extended(
          extendedPadding: const EdgeInsets.symmetric(horizontal: 10),
          backgroundColor: Colors.white,
          label: const Text("Chat"),
          icon: const SizedBox(
            width: 30,
            height: 30,
            child: CircleAvatar(),
          ),
          onPressed: () => _paymentController.toChatScreen(),
        ),
      ),
    );
  }

  Widget buildBody() {
    return SliverToBoxAdapter(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: context.screenSize.height),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWellWrapper(
                onTap: () {
                  Get.toNamed(sellerProfileScreenRoute,
                      arguments: post!.userId);
                },
                border: Border(
                    bottom: BorderSide(
                        width: 0.5, color: AppColors.metallicSilver)),
                paddingChild: EdgeInsets.symmetric(vertical: getHeight(10)),
                margin: EdgeInsets.only(bottom: getHeight(5)),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.network(
                        post?.user?.avatar ?? '',
                        fit: BoxFit.cover,
                        width: getWidth(45),
                        height: getWidth(45),
                        errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                      ),
                    ),
                    SizedBox(width: getWidth(20)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(post?.user?.name ?? '',
                            style: TextStyle(
                                fontSize: getFont(17),
                                fontWeight: FontWeight.w700)),
                        SizedBox(height: getHeight(5)),
                      ],
                    ),
                    Visibility(
                      visible:
                          (post?.userId == _userController.currentUser.value.id)
                              ? false
                              : true,
                      child: Expanded(
                          child: Align(
                        alignment: Alignment.centerRight,
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
                                    serviceId: id,
                                    icon: post?.images?[0],
                                    onTapChangeStatus: (value) async {
                                      EasyLoading.show();
                                      await SaveServiceAPI.ins
                                          .changeStatusServicesSaveListById(
                                              listId: value, serviceId: id);
                                      EasyLoading.dismiss();
                                    },
                                  );
                                },
                              ).then((value) {
                                getPostByID();
                              });
                            },
                            child: post!.isSaved!
                                ? const Icon(Icons.favorite_outlined,
                                    size: 22, color: Colors.red)
                                : const Icon(Icons.favorite_border_outlined,
                                    size: 22)),
                      )),
                    )
                  ],
                ),
              ),
              Text(
                post!.title ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                post!.description ?? "",
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              PostDetailBody(
                post: post!,
                onTabSelected: (value) =>
                    _paymentController.selectedPackage = value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
