import 'package:flutter/material.dart';
import '../../../../common_widgets/loading_container.dart';
import '../../../../core/core.dart';

class PageImageAnimation extends StatefulWidget {
  const PageImageAnimation({Key? key}) : super(key: key);

  @override
  State<PageImageAnimation> createState() => _PageImageAnimation();
}

class _PageImageAnimation extends State<PageImageAnimation>
    with TickerProviderStateMixin {
  late PageController pageController;
  int _selectedIndex = 1;

  List<String> images = [
    'https://tanduy.vn/wp-content/uploads/2020/06/product-1636762945-dich-vu-fb-1-750x375.png',
    'https://dichvuvietcontent.com/wp-content/uploads/2021/05/dich-vu-viet-content-ban-hang-online-1-min.jpg',
    'https://www.hanoistudio.vn/wp-content/uploads/2020/02/dich-vu-quay-phim-1024x558.jpg',
    'https://applelegacy.com/media/posts/16/responsive/dich-vu-facebook-youtube-tiktok-instagram-xxl.png',
    'https://qph.cf2.quoracdn.net/main-qimg-f45f134cfda7a7f1c86fa13eb389f354-lq',
    'https://www.ezoic.com/wp-content/uploads/2021/03/Untitled-design-1.jpg?ezimgfmt=ng%3Awebp%2Fngcb251',
    'https://blog.thinkdm2.com/hs-fs/hubfs/Customer_Language_Blog_Post.png?width=3508&name=Customer_Language_Blog_Post.png'
  ];

  @override
  void initState() {
    pageController =
        PageController(initialPage: 1, keepPage: true, viewportFraction: 0.7);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: getHeight(15)),
      height: getHeight(320),
      child: PageView.builder(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        itemBuilder: (BuildContext context, int index) {
          var scale = _selectedIndex == index ? 1.0 : 0.8;
          return TweenAnimationBuilder(
            tween: Tween(begin: scale, end: scale),
            duration: const Duration(milliseconds: 350),
            builder: (BuildContext context, double value, Widget? child) {
              return Transform.scale(
                scale: value,
                child: child,
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                images[index],
                width: getWidth(MediaQuery.of(context).size.width),
                height: getHeight(320),
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const LoadingContainer();
                },
                errorBuilder: (_, __, ___) => const LoadingContainer(),
              ),
            ),
          );
        },
        itemCount: images.length,
      ),
    );
  }
}
