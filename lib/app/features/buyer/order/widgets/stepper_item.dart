import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StepperItem extends StatelessWidget {
  const StepperItem({
    super.key,
    required this.leading,
    required this.color,
    required this.title,
    required this.subtitle,
    isReview,
  });

  final IconData leading;
  final Color color;
  final String title;
  final String? subtitle;
  final bool isReview = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  leading,
                  color: color,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(left: 17),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: color.withOpacity(0.2),
              ),
            ),
          ),
          child: !isReview
              ? Text(subtitle ?? "")
              : ListTile(
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
                ),
        ),
      ],
    );
  }
}
