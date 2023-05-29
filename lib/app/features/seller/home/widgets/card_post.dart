import '../../../../core/core.dart';
import 'package:flutter/material.dart';

class cardPost extends StatelessWidget {
  const cardPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: context.screenSize.height * 0.02),
        const Text(
          "My posts",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 15),
                Row(
                  children: [
                    Text(
                      "Statistic",
                      style:
                          TextStyle(fontSize: context.screenSize.width * 0.03),
                    ),
                    const Spacer(),
                    Text(
                      "Last 7 days",
                      style:
                          TextStyle(fontSize: context.screenSize.width * 0.03),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Impressions",
                      style:
                          TextStyle(fontSize: context.screenSize.width * 0.03),
                    ),
                    const Spacer(),
                    Text(
                      "87",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: context.screenSize.width * 0.03),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Clicks",
                      style:
                          TextStyle(fontSize: context.screenSize.width * 0.03),
                    ),
                    const Spacer(),
                    Text(
                      "12",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.screenSize.width * 0.03,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
