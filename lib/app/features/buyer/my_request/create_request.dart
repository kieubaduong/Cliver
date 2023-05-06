import 'package:cliver_mobile/app/core/utils/utils.dart';
import 'package:cliver_mobile/app/core/values/app_colors.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'controller/my_request_controller.dart';

class CreateRequestScreen extends StatelessWidget {
  CreateRequestScreen({Key? key}) : super(key: key);

  final _controller = Get.find<MyRequestController>()..getAllCategory();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create request".tr),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //describe here
              Text(
                "Describe your needs".tr,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              TextField(
                controller: _controller.desController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'e.g. website, design something, and more.'.tr,
                ),
                maxLength: 1200,
                maxLines: null,
                minLines: 5,
              ),
              const SizedBox(height: 20),
              //category of this request
              Text(
                "${'Which category best fits your project'.tr}?",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  SizedBox(
                    width: context.screenSize.width * 0.4,
                    child: Obx(
                      () => DropdownSearch<String>(
                        popupProps: const PopupProps.menu(
                          showSelectedItems: true,
                          showSearchBox: true,
                        ),
                        items: _controller.categoryNameList,
                        onChanged: (val) {
                          _controller.changeCategory(val!);
                        },
                        selectedItem: _controller.mainSelect.value,
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: context.screenSize.width * 0.45,
                    child: Obx(
                      () => DropdownSearch<String>(
                        popupProps: const PopupProps.menu(
                          showSelectedItems: true,
                          showSearchBox: true,
                        ),
                        items: _controller.subCategoryNameList,
                        onChanged: (val) {
                          _controller.subSelect.value = val!;
                        },
                        selectedItem: _controller.subSelect.value,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              //deadline
              Text(
                "Let’s talk timing".tr,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  ToggleSwitch(
                    initialLabelIndex: 0,
                    totalSwitches: 2,
                    minWidth: context.screenSize.width,
                    minHeight: 50,
                    labels: [('I have a deadline'.tr), "I'm flexible".tr],
                    borderColor: [AppColors.primaryColor],
                    borderWidth: 1.5,
                    activeBgColor: [AppColors.primaryColor],
                    activeFgColor: Colors.white,
                    inactiveBgColor: AppColors.backgroundColor,
                    fontSize: 18,
                    onToggle: (index) {
                      _controller.toggleDeadline(index);
                    },
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 20),
              //calendar here
              Obx(
                () => Visibility(
                  visible: _controller.isHaveDeadline.value,
                  child: TextField(
                    enableInteractiveSelection: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: _controller.selectedDate.value == null
                          ? "${'I need it by'.tr}..."
                          : DateFormat.yMMMd()
                              .format(_controller.selectedDate.value!),
                    ),
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      var res = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2001, 3, 25),
                        lastDate: DateTime(2100, 3, 25),
                      );
                      if (res != null) {
                        _controller.selectedDate.value = res;
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),
              //money here
              Text(
                "Let’s talk money".tr,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  ToggleSwitch(
                    initialLabelIndex: 0,
                    totalSwitches: 2,
                    minWidth: context.screenSize.width,
                    minHeight: 50,
                    labels: ["I'm on a budget".tr, "I'm not sure".tr],
                    borderColor: [AppColors.primaryColor],
                    borderWidth: 1.5,
                    fontSize: 18,
                    activeBgColor: [AppColors.primaryColor],
                    inactiveBgColor: AppColors.backgroundColor,
                    onToggle: (index) {
                      _controller.toggleMoney(index);
                    },
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 20),
              //input money here
              Obx(
                () => Visibility(
                  visible: _controller.isHaveMoney.value,
                  child: TextField(
                    controller: _controller.inputMoney,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "${'My budget is'.tr}...",
                      suffixText: "VND",
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              //tag here
              Text(
                "Tags".tr,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              buildTextFieldTags(),
              const SizedBox(height: 50),
              //create button here
              ElevatedButton(
                onPressed: () => _controller.createNewRequest(),
                child: Text("Create request".tr),
              )
            ],
          ),
        ),
      ),
    );
  }

  TextFieldTags buildTextFieldTags() {
    return TextFieldTags(
      textfieldTagsController: _controller.tagController,
      inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {
        return ((context, sc, tags, onTagDelete) {
          return TextField(
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
            ],
            controller: tec,
            focusNode: fn,
            decoration: InputDecoration(
              isDense: true,
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              hintText: _controller.tagController.hasTags
                  ? ''
                  : "${'Enter tag'.tr}...",
              errorText: error,
              prefixIconConstraints:
                  BoxConstraints(maxWidth: context.screenSize.width * 0.74),
              prefixIcon: tags.isNotEmpty
                  ? SingleChildScrollView(
                      controller: sc,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: tags.map((String tag) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                              color: AppColors.primaryColor,
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  child: Text(
                                    '#$tag',
                                    style: const TextStyle(color: Colors.white),
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
    );
  }
}
