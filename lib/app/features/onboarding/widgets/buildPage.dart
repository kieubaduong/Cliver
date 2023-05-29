import 'package:flutter/material.dart';
import '../../../core/values/app_colors.dart';

class BuildPage extends StatefulWidget {
  const BuildPage({Key? key, required this.title, required this.image, required this.des}) : super(key: key);
  final String title;
  final String image;
  final String des;

  @override
  State<BuildPage> createState() => _BuildPageState();
}

class _BuildPageState extends State<BuildPage> with SingleTickerProviderStateMixin{
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      lowerBound: -1,
      upperBound: 1,
    );
    animationController.animateTo(
      0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 1500),
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, _) {
            return Transform.translate(
              offset: Offset(0, animationController.value * 400),
              child: _,
            );
          },
          child: SizedBox(
            height: 280,
            width: 280,
            child: Image.asset(widget.image),
          ),
        ),
        const SizedBox(height: 20),
        AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, _) {
            return Transform.translate(
              offset: Offset(animationController.value * 400, 0),
              child: _,
            );
          },
          child: Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),
        AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, _) {
            return Transform.translate(
              offset: Offset(0, animationController.value * -400),
              child: _,
            );
          },
          child: Text(
            widget.des,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.secondaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
