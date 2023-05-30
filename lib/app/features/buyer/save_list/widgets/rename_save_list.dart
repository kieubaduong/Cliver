import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../../../data/services/services.dart';
import '../../../../common_widgets/common_widgets.dart';
import '../../../../core/core.dart';
import '../../../../routes/routes.dart';

class RenameSaveList extends StatefulWidget {
  const RenameSaveList({Key? key, required this.name, required this.id}) : super(key: key);
  final int id;
  final String? name;

  @override
  State<RenameSaveList> createState() => _RenameSaveListState();
}

class _RenameSaveListState extends State<RenameSaveList> {
  late String _name = widget.name ?? '';
  late TextEditingController controller = TextEditingController(text: widget.name ?? '');

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: getWidth(200),
        height: getHeight(150),
        color: AppColors.primaryWhite,
        padding: EdgeInsets.symmetric(vertical: getHeight(10), horizontal: getWidth(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Edit name',
              style: TextStyle(
                fontSize: getFont(18),
                fontWeight: FontWeight.w700,
                letterSpacing: 0.75,
              ),
            ),
            SizedBox(height: getHeight(20)),
            TextField(
              controller: controller,
              autofocus: true,
              onChanged: (value) {
                setState(() => _name = value);
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: getWidth(15), vertical: getHeight(15)),
                filled: true,
                fillColor: AppColors.primaryWhite,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: AppColors.primaryBlack,
                      width: 1,
                    )),
                enabledBorder: InputBorder.none,
                suffixIcon: InkWellWrapper(
                  onTap: () {},
                  width: getWidth(25),
                  height: getWidth(25),
                  borderRadius: BorderRadius.circular(20),
                  margin: EdgeInsets.only(right: getWidth(10)),
                  color: AppColors.primaryBlack.withOpacity(0.7),
                  child: Icon(
                    Icons.clear,
                    size: 15,
                    color: AppColors.primaryWhite,
                  ),
                ),
                suffixIconConstraints: const BoxConstraints(minWidth: 15, minHeight: 15),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWellWrapper(
                      paddingChild: EdgeInsets.all(getHeight(8)),
                      onTap: () => Get.back(),
                      child: Text(
                        'cancel'.tr,
                        style: TextStyle(color: AppColors.metallicSilver, fontSize: getFont(15), fontWeight: FontWeight.w700),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: getWidth(20)),
                InkWellWrapper(
                  onTap: _name.isNotEmpty && _name != widget.name ? () async {
                    EasyLoading.show();
                    await SaveServiceAPI.ins.renameSaveListServiceById(id: widget.id, name: _name);
                    EasyLoading.dismiss();
                    if (!mounted) {
                      return;
                    }
                    Navigator.of(context)
                      ..pop()
                      ..pop()
                      ..pop()
                      ..pushNamed(saveListRoute);
                  } : null,
                  paddingChild: EdgeInsets.all(getHeight(8)),
                  child: Text(
                    'rename'.tr,
                    style: TextStyle(
                      color: _name.isNotEmpty && _name != widget.name ? AppColors.greenCrayola : AppColors.metallicSilver,
                      fontSize: getFont(15),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
