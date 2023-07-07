import 'package:cliver_sentiment/app/features/customer_reviews/widgets/reivew_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import '../../../data/models/model.dart';
import '../../../data/services/services.dart';
import '../../common_widgets/common_widgets.dart';
import '../../controller/controller.dart';
import '../../core/core.dart';

class CustomerReviewsScreen extends StatefulWidget {
  const CustomerReviewsScreen({super.key});

  @override
  State<CustomerReviewsScreen> createState() => _CustomerReviewsScreenState();
}

class _CustomerReviewsScreenState extends State<CustomerReviewsScreen> {
  bool isGetData = false;
  List<Review> reviewSentiment = [];
  List<Review> getReviewSentiment = [];
  final UserController _userController = Get.find();
  var tapPosition = const Offset(0.0, 0.0);
  List<String> filterSentiment = [
    'All'.tr,
    'Negative'.tr,
    'Positive'.tr,
  ];
  String itemSelected = 'All'.tr;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    setState(() => isGetData = false);
    EasyLoading.show();
    var res = await UserService.ins
        .getReviewSentimentsById(id: _userController.currentUser.value.id!);
    if (res.isOk) {
      if (res.body["data"] != null) {
        reviewSentiment = <Review>[];
        res.body["data"].forEach((v) {
          if (v != null) {
            reviewSentiment.add(Review.fromJson(v));
          }
        });
      }
    }
    EasyLoading.dismiss();
    getReviewSentiment = reviewSentiment;
    setState(() => isGetData = true);
  }

  @override
  Widget build(BuildContext context) {
    double label0 = 0;
    double label1 = 0;
    for (var element in reviewSentiment) {
      if (element.label == 0) {
        label0++;
      } else{
        label1++;
      }
    }
    final dataMap = <String, double>{
      "Positive".tr: label1 * 100 / reviewSentiment.length,
      "Negative".tr: label0 * 100/ reviewSentiment.length,
    };
    return isGetData
        ? Scaffold(
            appBar: AppBar(
              title: Text(
                'Customer reviews'.tr,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  PieChart(
                    dataMap: dataMap,
                    animationDuration: const Duration(seconds: 2),
                    chartRadius: MediaQuery.of(context).size.width * 2 / 5,
                    colorList: const [
                      Color(0xFF3398F6),
                      Color(0xFFFA4A42),
                      Color(0xFFFE9539),
                      Color(0xFFD95AF3),
                      Color(0xFF3EE094),
                    ],
                    chartValuesOptions: const ChartValuesOptions(
                        showChartValueBackground: false,
                        chartValueStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      'Sentiment Analysis'.tr,
                      style: TextStyle(
                          fontSize: getFont(20),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Comment History'.tr,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: getFont(18),
                          ),
                        ),
                        InkWellWrapper(
                          paddingChild: EdgeInsets.all(getWidth(10)),
                          onTapDown: (details) {
                            tapPosition = details.globalPosition;
                          },
                          onTap: () {
                            final RenderBox overlay = Overlay.of(context)
                                .context
                                .findRenderObject() as RenderBox;
                            showMenu(
                              context: context,
                              position: RelativeRect.fromRect(
                                  tapPosition &
                                  const Size(
                                      40, 40), // smaller rect, the touch area
                                  Offset.zero &
                                  overlay.size // Bigger rect, the entire screen
                              ),
                              items: List.generate(filterSentiment.length, (index) {
                                return PopupMenuItem(
                                  value: index,
                                  onTap: () {
                                    setState(() {
                                      itemSelected = filterSentiment[index];
                                      if(index == 1) {
                                        getReviewSentiment = reviewSentiment.where((element) => element.label == 0).toList();
                                      } else if(index == 2){
                                        getReviewSentiment = reviewSentiment.where((element) => element.label == 1).toList();
                                      } else if(index == 3){
                                        getReviewSentiment = reviewSentiment.where((element) => element.label == 2).toList();
                                      } else {
                                        getReviewSentiment = reviewSentiment;
                                      }
                                    });
                                  },
                                  child: Text(filterSentiment[index]),
                                );
                              }),
                              constraints: BoxConstraints(
                                minWidth: getWidth(20),
                                maxWidth: getWidth(190),
                              ),
                            );
                          },
                          child: Text(
                            itemSelected,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: getFont(16),
                                color: AppColors.greenCrayola),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        return ReviewItem(review: getReviewSentiment[i]);
                      },
                      itemCount: getReviewSentiment.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(height: 20);
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
