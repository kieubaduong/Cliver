import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../../../data/models/model.dart';
import '../../../../../data/services/services.dart';
import '../../../../common_widgets/common_widgets.dart';
import '../../../../core/core.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog(
      {Key? key,
      this.onSubmit,
      required this.search,
      this.saveStatusFilter,
      required this.statusFilterDialog})
      : super(key: key);
  final String search;
  final List<dynamic> statusFilterDialog;
  final void Function(List<dynamic>)? saveStatusFilter;
  final void Function(
      {String? search,
      int? minPrice,
      int? maxPrice,
      int? deliveryTime,
      String? filter,
      int? categoryId,
      int? offset,
      int? limit,
      int? subCategoryId})? onSubmit;

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  bool isCheckSelect = false;
  late bool isGetDataAllCategory;
  late int indexCheckBox;
  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();
  late List<Category> categoryList = [];
  late List<SubCategory> subCategoryList = [];
  late Category itemSelectCategory = Category();
  late SubCategory itemSubCategory;
  late String itemSelectDelivery;
  var tapPosition = const Offset(0.0, 0.0);
  late List<dynamic> statusFilter = [...widget.statusFilterDialog];
  final delivery = ['any'.tr, '24 hours'.tr, '3 days'.tr, '7 days'.tr];

  @override
  void initState() {
    getPopularCategory();
    indexCheckBox = statusFilter[0];
    itemSubCategory = SubCategory(id: -1, name: '');
    minController.text = statusFilter[3] ?? '';
    maxController.text = statusFilter[4] ?? '';
    itemSelectDelivery = delivery[statusFilter[5]];
    if (statusFilter[0] != 0 ||
        statusFilter[1] != 0 ||
        statusFilter[3] != null ||
        statusFilter[4] != null ||
        statusFilter[5] != 0) {
      setState(() => isCheckSelect = true);
    }
    super.initState();
  }

  void getPopularCategory() async {
    setState(() {
      isGetDataAllCategory = false;
    });
    EasyLoading.show();
    var res = await CategoriesService.ins.getAllCategory();
    EasyLoading.dismiss();
    if (res.isOk) {
      categoryList = <Category>[Category(id: -1, name: 'all category'.tr)];
      if (res.body["data"] is Iterable<dynamic> &&
          res.body["data"].isNotEmpty) {
        res.body["data"].forEach((v) {
          if (v != null) {
            categoryList.add(Category.fromJson(v));
          }
        });
      }
      itemSelectCategory = categoryList[statusFilter[1]];
      if (statusFilter[1] != 0) {
        subCategoryList.clear();
        subCategoryList.add(SubCategory(
            id: -1, name: '${'all'.tr} ${itemSelectCategory.name}'));
        itemSelectCategory.subcategories
            ?.forEach((e) => subCategoryList.add(e));
        itemSubCategory = subCategoryList[statusFilter[2] ?? 0];
      }
    }
    setState(() {
      isGetDataAllCategory = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sort = {
      Icons.feed: 'Relevance'.tr,
      Icons.star_border: 'Best selling'.tr,
      Icons.newspaper: 'New arrivals'.tr,
    }.entries.toList();
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: AppColors.primaryWhite,
        title: Text(
          'filter'.tr,
          style: TextStyle(
            fontSize: getFont(20),
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.close,
              size: 24, color: AppColors.primaryBlack.withOpacity(0.8)),
        ),
        actions: [
          InkWellWrapper(
            onTap: isCheckSelect
                ? () {
                    setState(() {
                      isCheckSelect = false;
                      indexCheckBox = 0;
                      itemSelectCategory =
                          Category(id: -1, name: 'all category'.tr);
                      itemSelectDelivery = 'any'.tr;
                      maxController.clear();
                      minController.clear();
                      statusFilter = [
                        0,
                        0,
                        null,
                        null,
                        null,
                        0,
                      ];
                    });
                  }
                : null,
            margin: EdgeInsets.symmetric(
                vertical: getHeight(15), horizontal: getWidth(10)),
            paddingChild: EdgeInsets.symmetric(
                vertical: getHeight(5), horizontal: getWidth(10)),
            child: Text(
              'clear'.tr,
              style: TextStyle(
                  fontSize: getFont(18),
                  color: isCheckSelect
                      ? AppColors.greenCrayola
                      : AppColors.greenCrayola.withOpacity(0.4),
                  fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
      body: Container(
        color: AppColors.scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: getHeight(20),
                  horizontal: getWidth(20),
                ),
                child: Text(
                  'sort by'.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: getFont(20),
                  ),
                ),
              ),
              Column(
                children: List.generate(
                  sort.length,
                  (index) => InkWellWrapper(
                      onTap: () {
                        if (indexCheckBox != index) {
                          setState(() {
                            indexCheckBox = index;
                            if (isCheckSelect == false) {
                              setState(() {
                                isCheckSelect = true;
                              });
                            }
                          });
                          statusFilter[0] = index;
                        }
                      },
                      paddingChild: EdgeInsets.symmetric(
                          horizontal: getWidth(5), vertical: getHeight(7)),
                      border: Border.symmetric(
                          horizontal: BorderSide(
                              color: AppColors.metallicSilver, width: 0.1)),
                      color: AppColors.primaryWhite,
                      child: Row(
                        children: [
                          SizedBox(width: getWidth(10)),
                          Icon(sort[index].key, size: getWidth(22)),
                          SizedBox(width: getWidth(15)),
                          Text(
                            sort[index].value,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: getFont(18),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: index == indexCheckBox
                                  ? Padding(
                                      padding: EdgeInsets.all(getWidth(10)),
                                      child: Icon(
                                        Icons.check,
                                        size: getWidth(24),
                                        color: AppColors.greenCrayola,
                                      ),
                                    )
                                  : Container(
                                      padding: EdgeInsets.all(getWidth(10)),
                                      child: const SizedBox(
                                          width: 24, height: 24)),
                            ),
                          )
                        ],
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: getHeight(20),
                  horizontal: getWidth(20),
                ),
                child: Text(
                  'categories'.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: getFont(20),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: getWidth(15),
                    right: getWidth(5),
                    top: getHeight(7),
                    bottom: getHeight(7)),
                decoration: BoxDecoration(
                  border: Border.symmetric(
                      horizontal: BorderSide(
                          color: AppColors.metallicSilver, width: 0.1)),
                  color: AppColors.primaryWhite,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'category'.tr,
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
                          items: List.generate(categoryList.length, (index) {
                            return PopupMenuItem(
                              value: index,
                              onTap: () {
                                setState(() {
                                  itemSelectCategory = categoryList[index];
                                  statusFilter[1] = index;
                                  if (index != 0) {
                                    itemSubCategory = SubCategory(
                                        id: -1,
                                        name:
                                            '${'all'.tr} ${itemSelectCategory.name}');
                                    subCategoryList.clear();
                                    subCategoryList.add(SubCategory(
                                        id: -1,
                                        name:
                                            '${'all'.tr} ${itemSelectCategory.name}'));
                                    itemSelectCategory.subcategories?.forEach(
                                        (e) => subCategoryList.add(e));
                                  }
                                });
                                if (isCheckSelect == false) {
                                  setState(() {
                                    isCheckSelect = true;
                                  });
                                }
                              },
                              child: Text(categoryList[index].name ?? ''),
                            );
                          }),
                          constraints: BoxConstraints(
                            minWidth: getWidth(20),
                            maxWidth: getWidth(190),
                          ),
                        );
                      },
                      child: Text(
                        itemSelectCategory.name ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: getFont(16),
                            color: AppColors.greenCrayola),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: itemSelectCategory.name != 'all category'.tr,
                child: Container(
                  padding: EdgeInsets.only(
                      left: getWidth(15),
                      right: getWidth(5),
                      top: getHeight(7),
                      bottom: getHeight(7)),
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                        horizontal: BorderSide(
                            color: AppColors.metallicSilver, width: 0.1)),
                    color: AppColors.primaryWhite,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'service type'.tr,
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
                                    overlay
                                        .size // Bigger rect, the entire screen
                                ),
                            items:
                                List.generate(subCategoryList.length, (index) {
                              return PopupMenuItem(
                                value: index,
                                onTap: () {
                                  setState(() {
                                    itemSubCategory = subCategoryList[index];
                                    statusFilter[2] = index;
                                  });

                                  if (isCheckSelect == false) {
                                    setState(() {
                                      isCheckSelect = true;
                                    });
                                  }
                                },
                                child: Text(subCategoryList[index].name!),
                              );
                            }),
                            constraints: BoxConstraints(
                              minWidth: getWidth(20),
                              maxWidth: getWidth(190),
                            ),
                          );
                        },
                        child: Text(
                          itemSubCategory.name ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: getFont(16),
                              color: AppColors.greenCrayola),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: getHeight(20),
                  horizontal: getWidth(20),
                ),
                child: Text(
                  'option'.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: getFont(20),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: getWidth(5), vertical: getHeight(7)),
                    decoration: BoxDecoration(
                      border: Border.symmetric(
                          horizontal: BorderSide(
                              color: AppColors.metallicSilver, width: 0.1)),
                      color: AppColors.primaryWhite,
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: getWidth(10)),
                        Expanded(
                          child: Text(
                            'Price'.tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: getFont(18),
                            ),
                          ),
                        ),
                        SizedBox(width: getWidth(15)),
                        Text(
                          '\$',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: getFont(18),
                          ),
                        ),
                        SizedBox(width: getWidth(5)),
                        SizedBox(
                          width: getWidth(70),
                          height: getHeight(40),
                          child: TextField(
                            controller: minController,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              if (value.isEmpty) {
                                statusFilter[3] = null;
                              } else {
                                statusFilter[3] = value;
                              }
                              if (isCheckSelect == false) {
                                setState(() {
                                  isCheckSelect = true;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              fillColor: AppColors.primaryWhite,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: getWidth(10)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.metallicSilver,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.metallicSilver,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          '  ${'to'.tr}  \$',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: getFont(18),
                          ),
                        ),
                        SizedBox(width: getWidth(5)),
                        SizedBox(
                          width: getWidth(70),
                          height: getHeight(40),
                          child: TextField(
                            controller: maxController,
                            keyboardType: TextInputType.number,
                            textAlignVertical: TextAlignVertical.center,
                            onChanged: (value) {
                              if (value.isEmpty) {
                                statusFilter[4] = null;
                              } else {
                                statusFilter[4] = value;
                              }
                              if (isCheckSelect == false) {
                                setState(() {
                                  isCheckSelect = true;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              fillColor: AppColors.primaryWhite,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: getWidth(10)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.metallicSilver,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.metallicSilver,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: getWidth(5))
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: getWidth(5), vertical: getHeight(7)),
                    decoration: BoxDecoration(
                      border: Border.symmetric(
                          horizontal: BorderSide(
                              color: AppColors.metallicSilver, width: 0.1)),
                      color: AppColors.primaryWhite,
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: getWidth(10)),
                        Text(
                          'delivery time'.tr,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: getFont(18),
                          ),
                        ),
                        SizedBox(width: getWidth(15)),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InkWellWrapper(
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
                                          const Size(40,
                                              40), // smaller rect, the touch area
                                      Offset.zero &
                                          overlay
                                              .size // Bigger rect, the entire screen
                                      ),
                                  items:
                                      List.generate(delivery.length, (index) {
                                    return PopupMenuItem(
                                      value: index,
                                      onTap: () {
                                        setState(() => itemSelectDelivery =
                                            delivery[index]);
                                        statusFilter[5] = index;
                                        if (isCheckSelect == false) {
                                          setState(() {
                                            isCheckSelect = true;
                                          });
                                        }
                                      },
                                      child: Text(delivery[index]),
                                    );
                                  }),
                                  constraints: BoxConstraints(
                                    minWidth: getWidth(20),
                                    maxWidth: getWidth(190),
                                  ),
                                );
                              },
                              child: Text(
                                itemSelectDelivery,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: getFont(18),
                                    color: AppColors.greenCrayola),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: getHeight(80),
        color: AppColors.primaryWhite,
        child: InkWellWrapper(
          margin: EdgeInsets.symmetric(
              horizontal: getWidth(10), vertical: getHeight(15)),
          color: AppColors.greenCrayola,
          onTap: () {
            widget.saveStatusFilter?.call(statusFilter);
            widget.onSubmit?.call(
                search: widget.search,
                filter: sort[indexCheckBox].value,
                minPrice: minController.text.isNotEmpty
                    ? int.parse(minController.text)
                    : null,
                maxPrice: maxController.text.isNotEmpty
                    ? int.parse(maxController.text)
                    : null,
                offset: 0,
                limit: 15,
                categoryId:
                    itemSelectCategory.id != -1 ? itemSelectCategory.id : null,
                subCategoryId:
                    itemSubCategory.id != -1 ? itemSubCategory.id : null,
                deliveryTime: 0);
            Navigator.of(context).pop();
          },
          child: Center(
            child: Text(
              'apply'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryWhite,
                fontSize: getFont(18),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
