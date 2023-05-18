import 'package:cliver_mobile/app/core/utils/utils.dart';
import 'package:flutter/material.dart';

class cardTodo extends StatelessWidget {
  const cardTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: context.screenSize.height * 0.02),
        const Text(
          "To-dos",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "0 unread messasges",
                      style: TextStyle(
                        fontSize: context.screenSize.width * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Your response time is good. Keep up the \ngreate work!",
                      style: TextStyle(
                        fontSize: context.screenSize.width * 0.03,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  width: 40,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(20)),
                  child: GestureDetector(
                    onTap: () {},
                    child: const Center(
                      child: Text("0"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
