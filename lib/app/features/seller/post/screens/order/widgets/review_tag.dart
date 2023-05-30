import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewTag extends StatelessWidget {
  const ReviewTag({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      leading: const CircleAvatar(),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text("Datdo79 messsage"),
              const Spacer(),
              RatingBarIndicator(
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                rating: 5,
                direction: Axis.horizontal,
                unratedColor: Colors.grey,
                itemCount: 5,
                itemSize: 20.0,
              ),
            ],
          ),
          const Text("This buyer is awesome, will hire him again!")
        ],
      ),
    );
  }
}
