import 'package:flutter/material.dart';
import '../../../../../data/models/model.dart';
import '../../../../common_widgets/common_widgets.dart';
import '../../../../core/core.dart';
import '../../../features.dart';

class CategoryHistoryItem extends StatefulWidget {
  const CategoryHistoryItem({Key? key, required this.postHistory, this.onChangedStatus, this.onTap, this.getPostsRecent}) : super(key: key);
  final Post postHistory;
  final Function(int)? onChangedStatus;
  final void Function()? onTap;
  final void Function()? getPostsRecent;

  @override
  State<CategoryHistoryItem> createState() => _CategoryHistoryItemState();
}

class _CategoryHistoryItemState extends State<CategoryHistoryItem> {
  late bool isStatus;

  @override
  void initState() {
    super.initState();
    isStatus = widget.postHistory.isSaved ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return InkWellWrapper(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(15),
      color: AppColors.primaryWhite,
      margin: const EdgeInsets.all(5),
      width: getWidth(175),
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
              widget.postHistory.images?[0] ?? "",
              fit: BoxFit.cover,
              width: getWidth(175),
              height: getHeight(105),
              errorBuilder: (_, __, ___) => const SizedBox(),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: getWidth(5), right: getWidth(5), top: getHeight(5), bottom: getHeight(5)),
            height: getHeight(45),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.star, color: AppColors.rajah, size: 16),
                Padding(
                  padding: EdgeInsets.only(left: getWidth(3), right: getWidth(3), top: getHeight(3)),
                  child: Text(
                    widget.postHistory.ratingAvg?.toStringAsFixed(1) ?? '0',
                    style: TextStyle(color: AppColors.rajah, fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: getHeight(3)),
                    child: Text(
                      "(${widget.postHistory.ratingCount})",
                      style: TextStyle(color: AppColors.metallicSilver, fontSize: 14),
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
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                        ),
                        builder: (BuildContext context) {
                          return BottomSaveList(
                            serviceId: widget.postHistory.id,
                            icon: widget.postHistory.images?[0],
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
          Container(
            padding: EdgeInsets.only(bottom: getHeight(20), left: getWidth(10), right: getWidth(10)),
            height: getHeight(75),
            child: Text(
              widget.postHistory.title ?? '',
              style: TextStyle(fontSize: 14, color: AppColors.primaryBlack),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                  child: Text(
                "From",
                style: TextStyle(color: AppColors.metallicSilver, fontSize: 12),
                textAlign: TextAlign.right,
              )),
              Padding(
                padding: EdgeInsets.only(left: getWidth(4.0), right: getWidth(10)),
                child: Text(
                  FormatHelper().moneyFormat(widget.postHistory.minPrice).toString(),
                  style: TextStyle(color: AppColors.primaryBlack, fontSize: 14, fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
