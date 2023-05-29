import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common_widgets/common_widgets.dart';
import '../../../../../core/core.dart';
import '../../../../features.dart';

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  CustomSliverAppBarDelegate({
    required this.expandedHeight,
    this.images,
  });

  final double expandedHeight;
  final List<String>? images;

  final SettingController _darkModeController = Get.find();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    const size = 40;
    final top = expandedHeight - shrinkOffset - size / 2;
    return Stack(
      fit: StackFit.expand,
      children: [
        buildBackground(shrinkOffset),
        Positioned(
          top: top,
          left: 0,
          right: 0,
          child: buildRoundedCorner(shrinkOffset),
        ),
        buildAppBar(shrinkOffset),
        Positioned(
          top: 50,
          left: 0,
          right: 0,
          child: buildBackButton(shrinkOffset),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 10;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight;

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;

  buildAppBar(double shrinkOffset) {
    return Opacity(
      opacity: appear(shrinkOffset),
      child: AppBar(
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back),
          onTap: () {
            Get.back();
          },
        ),
      ),
    );
  }

  buildBackground(double shrinkOffset) {
    return Opacity(
      opacity: disappear(shrinkOffset),
      child: Stack(
        children: [
          CarouselSlider.builder(
            options: CarouselOptions(
              height: expandedHeight,
              autoPlay: shrinkOffset == 0 ? true : false,
              autoPlayInterval: const Duration(seconds: 4),
              viewportFraction: 1,
            ),
            itemCount: images?.length,
            itemBuilder: (BuildContext context, int i, int realI) {
              return Image.network(
                images?[i] ?? '',
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: expandedHeight,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return LoadingContainer(
                      width: MediaQuery.of(context).size.width,
                      height: expandedHeight);
                },
                errorBuilder: (_, __, ___) => LoadingContainer(
                    width: MediaQuery.of(context).size.width,
                    height: expandedHeight),
              );
            },
          ),
        ],
      ),
    );
  }

  buildRoundedCorner(double shrinkOffset) {
    return Opacity(
      opacity: disappear(shrinkOffset),
      child: Container(
        height: expandedHeight,
        decoration: BoxDecoration(
          color: _darkModeController.isDarkMode.value
              ? Colors.black
              : AppColors.backgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
      ),
    );
  }

  buildBackButton(double shrinkOffset) {
    return Opacity(
      opacity: shrinkOffset == 0 ? 1 : 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            GestureDetector(
              child: const Icon(Icons.arrow_back),
              onTap: () {
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
