import 'package:flutter/material.dart';

import '../../../../../../data/models/model.dart';
import '../../../../../common_widgets/common_widgets.dart';
import '../../../../../core/core.dart';

class CustomReviewCardItem extends StatefulWidget {
  final Review review;
  const CustomReviewCardItem({Key? key, required this.review})
      : super(key: key);

  @override
  State<CustomReviewCardItem> createState() => _CustomReviewCardItemState();
}

class _CustomReviewCardItemState extends State<CustomReviewCardItem> {
  late String date = '';

  @override
  void initState() {
    var result = DateTime.now().difference(widget.review.createdAt!).inDays;
    if (result >= 0 && result < 7) {
      date = result == 1 ? '$result day ago' : '$result days ago';
    } else if (result >= 7 && result < 28) {
      date =
          result >= 7 && result < 14 ? '$result week ago' : '$result weeks ago';
    } else if (result >= 28) {
      date = result / 30 == 1 ? '$result month ago' : '$result months ago';
      if (result / 30 == 0) {
        date = '$result month ago';
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
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
                const SizedBox(width: 10),
                Text(
                  widget.review.user?.name ?? '',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              widget.review.comment ?? '',
              maxLines: 3,
              style: TextStyle(fontSize: getFont(18)),
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                Text(widget.review.rating?.toStringAsFixed(1) ?? ''),
                const Spacer(),
                Text(
                  date,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
