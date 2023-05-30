import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../data/models/model.dart';
import '../../../../../common_widgets/common_widgets.dart';

class PostReviewItem extends StatefulWidget {
  final Review review;
  const PostReviewItem({Key? key, required this.review}) : super(key: key);

  @override
  State<PostReviewItem> createState() => _PostReviewItemState();
}

class _PostReviewItemState extends State<PostReviewItem> {
  late String date = '';

  @override
  void initState() {
    var result = DateTime.now().difference(widget.review.createdAt!).inDays;
    if (result >= 0 && result < 7) {
      date =
          result == 1 ? '$result ${'day ago'.tr}' : '$result ${'days ago'.tr}';
    } else if (result >= 7 && result < 28) {
      date = result >= 7 && result < 14
          ? '$result ${'week ago'.tr}'
          : '$result ${'weeks ago'.tr}';
    } else if (result >= 28) {
      date = result / 30 == 1
          ? '$result ${'month ago'.tr}'
          : '$result ${'months ago'.tr}';
      if (result / 30 == 0) {
        date = '$result ${'month ago'.tr}';
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      horizontalTitleGap: 20,
      dense: true,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.network(
          widget.review.user?.avatar ?? '',
          fit: BoxFit.fill,
          width: 40,
          height: 40,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return const LoadingContainer(width: 40, height: 40);
          },
          errorBuilder: (_, __, ___) =>
              const LoadingContainer(width: 40, height: 40),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.review.user?.name ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  Text(widget.review.rating?.toStringAsFixed(1) ?? ''),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(date),
            ],
          ),
          const SizedBox(height: 10),
          Text(widget.review.comment ?? ''),
        ],
      ),
    );
  }
}
