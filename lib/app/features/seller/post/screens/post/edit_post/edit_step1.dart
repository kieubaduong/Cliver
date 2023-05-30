import '../../../../../../core/core.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:textfield_tags/textfield_tags.dart';
import '../../../../../../../data/models/model.dart';
import '../../../../../../../data/services/services.dart';
import '../../../../../../common_widgets/common_widgets.dart';
import '../../../../../features.dart';

class EditStep1 extends StatefulWidget {
  const EditStep1({Key? key, this.changeWidgetPackage}) : super(key: key);
  final void Function(bool)? changeWidgetPackage;

  @override
  State<EditStep1> createState() => _EditStep1State();
}

class _EditStep1State extends State<EditStep1> {
  //DATA FROM API
  late List<Category> categoryList = [];
  late List<String> categoryNameList = [];

  late List<SubCategory>? subCategoryList = [];
  late List<String> subCategoryNameList = [];

  late String mainSelect = '';
  late String subSelect = '';

  //LOGIC UI
  bool isGetData = true;

  //----------------------------------------------------

  final PostController controller = Get.find();
  final StepController stepController = Get.find();
  final TextfieldTagsController _tagController = TextfieldTagsController();
  late final titleCtrl =
      TextEditingController(text: controller.currentPost.title);

  Post currentPost = Post();

  @override
  void initState() {
    getAllCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isGetData
        ? const SizedBox.shrink()
        : Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "(*)",
                          style:
                              TextStyle(fontSize: 13, color: Colors.redAccent),
                        ),
                        Text(
                          "Post title",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    CustomTextField(
                      controller: titleCtrl,
                      hintText: "I will...",
                      length: 80,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "(*)",
                          style:
                              TextStyle(fontSize: 13, color: Colors.redAccent),
                        ),
                        Text(
                          "Category",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        SizedBox(
                          width: context.screenSize.width * 0.4,
                          child: DropdownSearch<String>(
                            popupProps: const PopupProps.menu(
                              showSelectedItems: true,
                              showSearchBox: true,
                            ),
                            items: categoryNameList,
                            onChanged: (val) {
                              changeCategory(val!);
                            },
                            selectedItem: mainSelect,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: context.screenSize.width * 0.45,
                          child: DropdownSearch<String>(
                            popupProps: const PopupProps.menu(
                              showSelectedItems: true,
                              showSearchBox: true,
                            ),
                            items: subCategoryNameList,
                            onChanged: (val) {
                              subSelect = val!;
                            },
                            selectedItem: subSelect,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "(*)",
                          style:
                              TextStyle(fontSize: 13, color: Colors.redAccent),
                        ),
                        Text(
                          "Tags",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    TextFieldTags(
                      textfieldTagsController: _tagController,
                      initialTags: controller.currentPost.tags,
                      inputfieldBuilder:
                          (context, tec, fn, error, onChanged, onSubmitted) {
                        return ((context, sc, tags, onTagDelete) {
                          return TextField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[a-zA-Z]")),
                            ],
                            controller: tec,
                            focusNode: fn,
                            decoration: InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1.0,
                                ),
                              ),
                              hintText:
                                  _tagController.hasTags ? '' : "Enter tag...",
                              errorText: error,
                              prefixIconConstraints: BoxConstraints(
                                  maxWidth: context.screenSize.width * 0.74),
                              prefixIcon: tags.isNotEmpty
                                  ? SingleChildScrollView(
                                      controller: sc,
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: tags.map((String tag) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(20.0),
                                              ),
                                              color: AppColors.primaryColor,
                                            ),
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0,
                                                vertical: 5.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  child: Text(
                                                    '#$tag',
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  onTap: () {
                                                    print("$tag selected");
                                                  },
                                                ),
                                                const SizedBox(width: 4.0),
                                                InkWell(
                                                  child: const Icon(
                                                    Icons.cancel,
                                                    size: 14.0,
                                                    color: Colors.white,
                                                  ),
                                                  onTap: () {
                                                    onTagDelete(tag);
                                                  },
                                                )
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    )
                                  : null,
                            ),
                            onChanged: onChanged,
                            onSubmitted: onSubmitted,
                          );
                        });
                      },
                    ),
                    const Text(
                        "Choose the right keywords to help increase post engagement"),
                    const SizedBox(height: 80),
                    ElevatedButton(
                      onPressed: () async {
                        if (checkData()) {
                          SubCategory subCate = subCategoryList!.firstWhere(
                              (element) => element.name == subSelect);
                          controller.currentPost.title = titleCtrl.text;
                          controller.currentPost.subcategoryId = subCate.id;
                          controller.currentPost.tags = _tagController.getTags;
                          widget.changeWidgetPackage?.call(
                              controller.currentPost.packages!.length == 3);
                          stepController.currentIndex.value++;
                        } else {
                          EasyLoading.showToast('enterAllInformation'.tr,
                              toastPosition: EasyLoadingToastPosition.bottom);
                        }
                      },
                      child: const Text("Next"),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
  }

  void getAllCategory() async {
    EasyLoading.show();
    var res = await CategoriesService.ins.getAllCategory();
    if (res.isOk) {
      for (int i = 0; i < res.data.length; i++) {
        categoryList.add(Category.fromJson(res.data[i]));
        categoryNameList.add(Category.fromJson(res.data[i]).name!);
      }
      for (var category in categoryList) {
        for (var sub in category.subcategories!) {
          if (sub.id == controller.currentPost.subcategoryId) {
            mainSelect = category.name!;
            subSelect = sub.name!;
            subCategoryList = category.subcategories;
            for (int i = 0; i < subCategoryList!.length; i++) {
              subCategoryNameList.add(subCategoryList![i].name!);
            }
            break;
          }
        }
      }
      if (mainSelect.isEmpty || subSelect.isEmpty) {
        subCategoryList = categoryList[0].subcategories;
        for (int i = 0; i < subCategoryList!.length; i++) {
          subCategoryNameList.add(subCategoryList![i].name!);
        }
        mainSelect = categoryNameList[0];
        subSelect = subCategoryNameList[0];
      }
    }
    setState(() {
      isGetData = false;
    });
    EasyLoading.dismiss();
  }

  void changeCategory(String val) {
    mainSelect = val;
    for (int i = 0; i < categoryList.length; i++) {
      if (categoryList[i].name == val) {
        subCategoryList = categoryList[i].subcategories;
        subCategoryNameList.clear();
        for (int m = 0; m < subCategoryList!.length; m++) {
          subCategoryNameList.add(subCategoryList![m].name!);
        }
        setState(() {
          subSelect = subCategoryNameList[0];
        });
        return;
      }
    }
  }

  bool checkData() {
    return titleCtrl.text.isNotEmpty && _tagController.getTags!.isNotEmpty;
  }
}
