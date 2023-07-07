import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../data/models/model.dart';
import '../../../common_widgets/common_widgets.dart';
import '../../../core/core.dart';

class ReviewItem extends StatefulWidget {
  final Review review;

  const ReviewItem({Key? key, required this.review}) : super(key: key);

  @override
  State<ReviewItem> createState() => _ReviewItemState();
}

class _ReviewItemState extends State<ReviewItem> {
  late String date = '';

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String date = FormatHelper().toLocal(widget.review.createdAt).toString();
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      horizontalTitleGap: 20,
      dense: true,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.review.user?.name ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                date.substring(0, date.length - 4),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: getFont(14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(widget.review.comment ?? ''),
        ],
      ),
    );
  }
}
