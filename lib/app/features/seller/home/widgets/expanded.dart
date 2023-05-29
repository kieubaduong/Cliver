import '../../../../core/core.dart';
import 'package:flutter/material.dart';

class myExpandedBar extends StatefulWidget {
  const myExpandedBar({Key? key}) : super(key: key);

  @override
  State<myExpandedBar> createState() => _myExpandedBarState();
}

class _myExpandedBarState extends State<myExpandedBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xff2A2B2E),
        border: Border(
          top: BorderSide(width: 0.2, color: Colors.grey),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.screenSize.width * 0.03,
            vertical: context.screenSize.height * 0.01),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            Text(
              "Reach your next level",
              style: TextStyle(color: Colors.white),
            ),
            Spacer(),
            Icon(
              Icons.keyboard_arrow_up,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
