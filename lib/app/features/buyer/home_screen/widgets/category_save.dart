import 'package:cliver_mobile/app/common_widgets/inkWell_wrapper.dart';
import 'package:cliver_mobile/app/core/utils/size_config.dart';
import 'package:cliver_mobile/app/core/values/app_colors.dart';
import 'package:cliver_mobile/app/features/buyer/home_screen/widgets/widgets.dart';
import 'package:cliver_mobile/data/models/model.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/utils.dart';

class CategorySave extends StatefulWidget {
  const CategorySave({Key? key, required this.postSave, this.onChangedStatus, this.onTap, this.getPostsRecent}) : super(key: key);
  final Post postSave;
  final Function(int)? onChangedStatus;
  final void Function()? onTap;
  final void Function()? getPostsRecent;

  @override
  State<CategorySave> createState() => _CategorySaveState();
}

class _CategorySaveState extends State<CategorySave> {
  late bool isStatus;

  @override
  void initState() {
    super.initState();
    isStatus = widget.postSave.isSaved ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return InkWellWrapper(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(15),
      color: AppColors.primaryWhite,
      margin: const EdgeInsets.all(5),
      width: getWidth(280),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            child: Image.network(
              widget.postSave.images?[0] ?? "",
              fit: BoxFit.cover,
              width: getWidth(280),
              height: getHeight(190),
              errorBuilder: (_, __, ___) => const SizedBox(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: getWidth(10), right: getWidth(10), top: getHeight(10), bottom: getHeight(5)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(radius: 15, backgroundImage: NetworkImage(widget.postSave.user?.avatar ?? "")),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: getWidth(10), right: getWidth(3), top: getHeight(3)),
                    child: Text(
                      widget.postSave.user?.name ?? '',
                      style: TextStyle(color: AppColors.primaryBlack, fontSize: 12, fontWeight: FontWeight.w700),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                InkWellWrapper(
                    paddingChild: const EdgeInsets.all(5),
                    borderRadius: BorderRadius.circular(20),
                    onTap: () async {
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        backgroundColor: AppColors.primaryWhite,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                        ),
                        builder: (BuildContext context) {
                          return BottomSaveList(
                            serviceId: widget.postSave.id,
                            icon: widget.postSave.images?[0],
                            onTapChangeStatus: (value) async {
                              widget.onChangedStatus?.call(value);
                            },
                          );
                        },
                      ).then((value) {
                        widget.getPostsRecent?.call();
                      });
                    },
                    child: isStatus ? const Icon(Icons.favorite_outlined, size: 22, color: Colors.red) : const Icon(Icons.favorite_border_outlined, size: 22))
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: getWidth(10), right: getWidth(10)),
              child: Text(
                widget.postSave.title ?? '',
                style: TextStyle(fontSize: 14, color: AppColors.primaryBlack),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: getHeight(10), right: getWidth(10), top: getHeight(10)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: getWidth(10)),
                  child: Icon(Icons.star, color: AppColors.rajah, size: 16),
                ),
                Padding(
                  padding: EdgeInsets.only(left: getWidth(3), right: getWidth(3), top: getHeight(3)),
                  child: Text(
                    widget.postSave.ratingAvg?.toStringAsFixed(1) ?? '0',
                    style: TextStyle(color: AppColors.rajah, fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: getHeight(3)),
                  child: Text(
                    "(${widget.postSave.ratingCount ?? 0})",
                    style: TextStyle(color: AppColors.metallicSilver, fontSize: 14),
                  ),
                ),
                Expanded(
                    child: Text(
                  "From",
                  style: TextStyle(color: AppColors.metallicSilver, fontSize: 12),
                  textAlign: TextAlign.right,
                )),
                Padding(
                  padding: EdgeInsets.only(left: getWidth(4.0), right: getWidth(10)),
                  child: Text(FormatHelper().moneyFormat(widget.postSave.minPrice).toString(), style: TextStyle(color: AppColors.primaryBlack, fontSize: 14, fontWeight: FontWeight.w700)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}