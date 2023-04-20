import 'package:flutter/material.dart';

import '../../../core/values/app_colors.dart';

buildPage({required title, required image, required des}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        height: 280,
        width: 280,
        child: Image.asset(image),
      ),
      const SizedBox(height: 20),
      Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 28,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 20),
      Text(
        des,
        style: TextStyle(
          fontSize: 16,
          color: AppColors.secondaryColor,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}
