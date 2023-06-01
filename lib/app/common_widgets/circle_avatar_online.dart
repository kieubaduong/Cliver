import 'package:cliver_mobile/app/core/utils/utils.dart';
import 'package:cliver_mobile/app/core/values/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatefulWidget {
  const CustomCircleAvatar({Key? key, required this.isOnline})
      : super(key: key);

  final bool isOnline;

  @override
  State<CustomCircleAvatar> createState() => _CustomCircleAvatarState();
}

class _CustomCircleAvatarState extends State<CustomCircleAvatar> {
  @override
  Widget build(context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        CircleAvatar(
          backgroundColor: AppColors.secondaryColor,
          radius: context.screenSize.width * 0.035,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            height: context.screenSize.width * 0.022,
            width: context.screenSize.width * 0.022,
            decoration: BoxDecoration(
                color: widget.isOnline
                    ? AppColors.primaryColor
                    : AppColors.secondaryColor,
                border: Border.all(
                  color: Colors.white,
                  width: 0.5,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
          ),
        ),
      ],
    );
  }
}
