import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../data/models/model.dart';
import '../../../../data/services/services.dart';
import '../../../core/core.dart';
import '../../features.dart';

class CustomOrderScreen extends StatefulWidget {
  const CustomOrderScreen({Key? key}) : super(key: key);

  @override
  State<CustomOrderScreen> createState() => _CustomOrderScreenState();
}

class _CustomOrderScreenState extends State<CustomOrderScreen> {
  Post? selectPost;
  final desController = TextEditingController();
  final priceController = TextEditingController();
  int deliveryTime = 1;
  int expirationTime = -1;
  int revision = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create an Offer"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //select a post here
              Row(
                children: [
                  const Text(
                    "Select a post",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () async {
                      Post? res = await Get.to(
                        () => const ListPostScreen(
                          unHideAppBar: true,
                        ),
                      );
                      if (res != null) {
                        setState(() {
                          selectPost = res;
                        });
                      }
                    },
                    child: const Text("Change"),
                  ),
                ],
              ),
              //selected post here
              Visibility(
                visible: selectPost != null ? true : false,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        child: Image.network(
                          selectPost?.images?[0] ??
                              "https://itefix.net/sites/default/files/not_available.png",
                          width: 150,
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  selectPost?.title ?? "nonTitle",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              //const SizedBox(height: 30),
                              const Spacer(),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RichText(
                                    text: TextSpan(
                                      text: "From ",
                                      style: TextStyle(
                                        color: Theme.of(context).hintColor,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: FormatHelper().moneyFormat(
                                              selectPost?.packages?[0].price ??
                                                  0),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              //describe
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Describe your offer",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              TextField(
                controller: desController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'e.g. deliverables, timelines, and more.',
                ),
                maxLength: 1200,
                maxLines: null,
                minLines: 5,
              ),
              const SizedBox(height: 10),
              //payment
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Payment",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Column(
                children: [
                  //price
                  ListTile(
                      dense: true,
                      leading: const Text(
                        "Total price (VND)",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: ConstrainedBox(
                        constraints:
                            const BoxConstraints(minWidth: 125, minHeight: 40),
                        child: IntrinsicWidth(
                          child: TextField(
                            controller: priceController,
                            textDirection: TextDirection.rtl,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      )),
                  const Divider(),
                  //delivery time
                  ListTile(
                    dense: true,
                    leading: const Text(
                      "Delivery time",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: SizedBox(
                      width: context.screenSize.width * 0.3,
                      child: DropdownSearch<String>(
                        selectedItem: "1 day",
                        popupProps: const PopupProps.menu(
                          showSelectedItems: true,
                        ),
                        items: const [
                          "1 day",
                          "2 days",
                          "3 days",
                          "5 days",
                          "1 week",
                          "2 weeks",
                        ],
                        onChanged: (val) {
                          switch (val) {
                            case "1 day":
                              {
                                deliveryTime = 1;
                                break;
                              }
                            case "2 days":
                              {
                                deliveryTime = 2;
                                break;
                              }
                            case "3 days":
                              {
                                deliveryTime = 3;
                                break;
                              }
                            case "5 days":
                              {
                                deliveryTime = 5;
                                break;
                              }
                            case "1 week":
                              {
                                deliveryTime = 7;
                                break;
                              }
                            case "2 weeks":
                              {
                                deliveryTime = 14;
                                break;
                              }
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              //offer setting
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Offer settings",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Column(
                children: [
                  //revision here
                  ListTile(
                    dense: true,
                    leading: const Text(
                      "Number of revisions",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: SizedBox(
                      width: context.screenSize.width * 0.3,
                      child: DropdownSearch<String>(
                        selectedItem: "No revision",
                        popupProps: const PopupProps.menu(
                          showSelectedItems: true,
                          fit: FlexFit.loose,
                        ),
                        items: const [
                          "No revision",
                          "1 ",
                          "2 ",
                          "3 ",
                        ],
                        onChanged: (val) {
                          switch (val) {
                            case "No revision":
                              {
                                revision = 0;
                                break;
                              }
                            case "1":
                              {
                                revision = 1;
                                break;
                              }
                            case "2":
                              {
                                revision = 2;
                                break;
                              }
                            case "3":
                              {
                                revision = 3;
                                break;
                              }
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  //deadline here
                  ListTile(
                    dense: true,
                    leading: const Text(
                      "Expiration time (optional)",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: SizedBox(
                      width: context.screenSize.width * 0.3,
                      child: DropdownSearch<String>(
                        selectedItem: "None",
                        popupProps: const PopupProps.menu(
                          showSelectedItems: true,
                        ),
                        items: const [
                          "None",
                          "1 day",
                          "2 days",
                          "3 days",
                          "5 days",
                          "1 week",
                          "2 weeks",
                        ],
                        onChanged: (val) {
                          switch (val) {
                            case "None":
                              {
                                expirationTime = -1;
                                break;
                              }
                            case "1 day":
                              {
                                expirationTime = 1;
                                break;
                              }
                            case "2 days":
                              {
                                expirationTime = 2;
                                break;
                              }
                            case "3 days":
                              {
                                expirationTime = 3;
                                break;
                              }
                            case "5 days":
                              {
                                expirationTime = 5;
                                break;
                              }
                            case "1 week":
                              {
                                expirationTime = 7;
                                break;
                              }
                            case "2 weeks":
                              {
                                expirationTime = 14;
                                break;
                              }
                          }
                        },
                      ),
                    ),
                  ),
                  const Divider(),
                  //request requirement
                  // ListTile(
                  //   dense: true,
                  //   leading: const Text(
                  //     "Request requirement",
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  //   trailing: Switch(
                  //     onChanged: (val) {},
                  //     value: true,
                  //     activeColor: AppColors.primaryColor,
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () => _createOfferFunc(),
                  child: const Text("Create offer")),
            ],
          ),
        ),
      ),
    );
  }

  _createOfferFunc() async {
    if (!isValidData()) {
      EasyLoading.showToast("Please fill all the fields",
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }

    if (desController.text.trim().length < 20) {
      EasyLoading.showToast("Description must at least 20 characters",
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }

    final chatCon = Get.find<ChatController>();

    CustomOrder customOrder = CustomOrder();
    customOrder.description = desController.text.trim();
    customOrder.postId = selectPost!.id;
    customOrder.buyerId = chatCon.partnerId.value;
    customOrder.roomId = chatCon.room.value?.id;
    customOrder.deliveryDays = deliveryTime;
    customOrder.price = int.parse(priceController.text.trim());
    if (revision != -1) {
      customOrder.numberOfRevisions = revision;
    }
    if (expirationTime != -1) {
      customOrder.expirationDays = expirationTime;
    }

    EasyLoading.show();
    var res =
        await OrderService.ins.createCustomOrder(customOrder: customOrder);
    EasyLoading.dismiss();

    if (res.isOk) {
      Get.back();
      EasyLoading.showToast("Create offer success",
          toastPosition: EasyLoadingToastPosition.bottom);
    } else {
      EasyLoading.showToast("Error",
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  bool isValidData() {
    return desController.text.trim().isNotEmpty &&
        priceController.text.trim().isNotEmpty &&
        selectPost != null;
  }
}
