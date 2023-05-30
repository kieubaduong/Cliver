import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../data/models/model.dart';
import '../../../../common_widgets/common_widgets.dart';
import '../../../../core/core.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key, required this.user, this.onSave}) : super(key: key);
  final User user;
  final void Function(User)? onSave;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController nameController = TextEditingController(text: widget.user.name);
  late TextEditingController descriptionController = TextEditingController(text: widget.user.description);
  TextEditingController languageController = TextEditingController();
  TextEditingController levelController = TextEditingController();
  TextEditingController skillController = TextEditingController();
  File? imageFile;
  final _formKey = GlobalKey<FormState>();
  late User userTemp;
  bool isInitData = false;
  bool editLanguage = false;
  bool editSkills = false;
  int indexEditIcon = -1;

  @override
  void initState() {
    userTemp = widget.user;
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    languageController.dispose();
    levelController.dispose();
    skillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primaryWhite,
      ),
      body: UnFocusWidget(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 80),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: getHeight(20)),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: 'Enter your name',
                        contentPadding: const EdgeInsets.all(16),
                        fillColor: AppColors.metallicSilver.withOpacity(0.1),
                        filled: true,
                        hintStyle: TextStyle(fontSize: getFont(15)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryBlack, width: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Description",
                      style: TextStyle(color: AppColors.primaryBlack, fontSize: getFont(18)),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: descriptionController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Enter your description',
                        contentPadding: const EdgeInsets.all(16),
                        fillColor: AppColors.metallicSilver.withOpacity(0.1),
                        filled: true,
                        hintStyle: TextStyle(fontSize: getFont(15)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryBlack, width: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Languages',
                      style: TextStyle(color: AppColors.primaryBlack, fontSize: getFont(18)),
                    ),
                    const SizedBox(height: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                          userTemp.languages?.length ?? 0,
                          (index) => Container(
                                padding: EdgeInsets.symmetric(horizontal: getWidth(10)),
                                margin: EdgeInsets.symmetric(vertical: getWidth(5)),
                                decoration: BoxDecoration(color: AppColors.metallicSilver.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  children: [
                                    const Icon(Icons.translate),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(userTemp.languages?[index].name ?? ''),
                                        Text(userTemp.languages?[index].level ?? ''),
                                      ],
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              languageController.text = userTemp.languages![index].name!;
                                              levelController.text = userTemp.languages![index].level!;
                                              editLanguage = true;
                                              indexEditIcon = index;
                                            });
                                          },
                                          icon: const Icon(Icons.edit, size: 24),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          userTemp.languages?.removeAt(index);
                                        });
                                      },
                                      icon: const Icon(Icons.delete, size: 24),
                                    ),
                                  ],
                                ),
                              )),
                    ),
                    if (editLanguage)
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              controller: languageController,
                              decoration: InputDecoration(
                                hintText: 'Enter your language name',
                                contentPadding: const EdgeInsets.all(12),
                                fillColor: AppColors.metallicSilver.withOpacity(0.1),
                                filled: true,
                                hintStyle: TextStyle(fontSize: getFont(13)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.primaryBlack, width: 0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: getWidth(20)),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: levelController,
                              decoration: InputDecoration(
                                hintText: 'Enter your level',
                                contentPadding: const EdgeInsets.all(16),
                                fillColor: AppColors.metallicSilver.withOpacity(0.1),
                                filled: true,
                                hintStyle: TextStyle(fontSize: getFont(13)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.primaryBlack, width: 0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWellWrapper(
                            onTap: !editLanguage || (languageController.text.isNotEmpty && levelController.text.isNotEmpty)
                                ? () {
                                    if (editLanguage) {
                                      var index = userTemp.languages!.indexWhere((element) => element.name == languageController.text);
                                      if (indexEditIcon != -1 && index == -1) {
                                        setState(() {
                                          userTemp.languages?[indexEditIcon].name = languageController.text;
                                          userTemp.languages?[indexEditIcon].level = levelController.text;
                                          indexEditIcon = -1;
                                          languageController.clear();
                                          levelController.clear();
                                          editLanguage = false;
                                        });
                                        return;
                                      }
                                      if (index != -1) {
                                        setState(() {
                                          languageController.clear();
                                          levelController.clear();
                                          editLanguage = false;
                                        });
                                      } else {
                                        setState(() {
                                          editLanguage = false;
                                          userTemp.languages?.add(Language(name: languageController.text, level: levelController.text));
                                          languageController.clear();
                                          levelController.clear();
                                        });
                                      }
                                    } else {
                                      setState(() => editLanguage = true);
                                    }
                                  }
                                : null,
                            color: AppColors.greenCrayola,
                            paddingChild: EdgeInsets.symmetric(vertical: getHeight(5)),
                            borderRadius: BorderRadius.circular(8),
                            margin: EdgeInsets.only(top: getHeight(10)),
                            child: editLanguage
                                ? Padding(
                                    padding: EdgeInsets.symmetric(vertical: getHeight(5)),
                                    child: Text(
                                      'Add',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: AppColors.primaryWhite, fontSize: getFont(18)),
                                    ),
                                  )
                                : Icon(Icons.add, size: 30, color: AppColors.primaryWhite),
                          ),
                        ),
                        if(editLanguage)
                        SizedBox(width: getWidth(15)),
                        if(editLanguage)
                        Expanded(
                          child: InkWellWrapper(
                            onTap: () {
                              setState(() => editLanguage = false);
                              languageController.clear();
                              levelController.clear();
                            },
                            color: AppColors.metallicSilver,
                            paddingChild: EdgeInsets.symmetric(vertical: getHeight(5)),
                            borderRadius: BorderRadius.circular(8),
                            margin: EdgeInsets.only(top: getHeight(10)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: getHeight(5)),
                              child: Text(
                                'Cancel',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: AppColors.primaryWhite, fontSize: getFont(18)),
                              ),
                            )
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),
                    Text(
                      'Skills',
                      style: TextStyle(color: AppColors.primaryBlack, fontSize: getFont(18)),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 10,
                      runSpacing: 5,
                      children: List.generate(userTemp.skills!.length + 1, (index) {
                        if (index == userTemp.skills!.length) {
                          return InkWellWrapper(
                            onTap: () => setState(() => editSkills = true),
                            borderRadius: BorderRadius.circular(10),
                            paddingChild: const EdgeInsets.all(6),
                            color: Colors.grey.withOpacity(0.5),
                            child: const Icon(Icons.add, size: 25),
                          );
                        } else {
                          return buildSkillItem(index);
                        }
                      }),
                    ),
                    const SizedBox(height: 15),
                    if (editSkills)
                      SizedBox(
                        height: getHeight(40),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: skillController,
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintText: 'Enter your skill',
                                  contentPadding: EdgeInsets.symmetric(horizontal: getWidth(16), vertical: getHeight(5)),
                                  fillColor: AppColors.metallicSilver.withOpacity(0.1),
                                  filled: true,
                                  hintStyle: TextStyle(fontSize: getFont(15)),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.primaryBlack, width: 0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: getHeight(10)),
                            InkWellWrapper(
                              onTap: () {
                                if(!userTemp.skills!.contains(skillController.text)) {
                                  setState(() {
                                    userTemp.skills!.add(skillController.text);
                                    editSkills = false;
                                    skillController.clear();
                                  });
                                } else {
                                  setState(() {
                                    editSkills = false;
                                    skillController.clear();
                                  });
                                }
                              },
                              borderRadius: BorderRadius.circular(10),
                              paddingChild: EdgeInsets.symmetric(vertical: getHeight(12), horizontal: getWidth(15)),
                              color: AppColors.greenCrayola,
                              child: Text(
                                'Add',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: AppColors.primaryWhite, fontSize: getFont(14)),
                              ),
                            ),
                            SizedBox(width: getHeight(10)),
                            InkWellWrapper(
                              onTap: () {
                                setState(() => editSkills = false);
                                skillController.clear();
                              },
                              borderRadius: BorderRadius.circular(10),
                              paddingChild: EdgeInsets.symmetric(vertical: getHeight(12), horizontal: getWidth(15)),
                              color: AppColors.metallicSilver,
                              child: Text(
                                'Cancel',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: AppColors.primaryWhite, fontSize: getFont(14)),
                              ),
                            )
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: getHeight(80),
        child: InkWellWrapper(
          margin: EdgeInsets.symmetric(horizontal: getWidth(10), vertical: getHeight(15)),
          color: AppColors.greenCrayola,
          onTap: () {
            userTemp.name = nameController.text;
            userTemp.description = descriptionController.text;
            widget.onSave?.call(userTemp);
            Navigator.of(context).pop();
          },
          child: Center(
            child: Text(
              'Save'.tr,
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

  buildSkillItem(index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(userTemp.skills?[index] ?? ''),
            InkWellWrapper(
              onTap: () => setState(() => userTemp.skills?.removeAt(index)),
              borderRadius: BorderRadius.circular(15),
              paddingChild: const EdgeInsets.all(5),
              child: const Icon(
                Icons.close,
                size: 18,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget avatarView() {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 20),
      child: Center(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: GestureDetector(
                  onTap: () => onAvatarClick(),
                  child: imageFile == null
                      ? Image.network(
                          'https://haycafe.vn/wp-content/uploads/2022/02/Anh-gai-xinh-Viet-Nam.jpg',
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, event) {
                            if (event == null) return child;
                            return const LoadingContainer(height: 120, width: 120);
                          },
                          errorBuilder: (context, object, stacktrace) {
                            return Image.asset('assets/images/wallet.png', height: 120, width: 120, fit: BoxFit.cover);
                          },
                        )
                      : Image.file(
                          imageFile!,
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                          errorBuilder: (context, object, stacktrace) {
                            return Image.asset('assets/images/wallet.png', height: 120, width: 120, fit: BoxFit.cover);
                          },
                        ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: GestureDetector(
                onTap: () => onAvatarClick(),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryBlack,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Image.asset('assets/images/wallet.png', height: 12, width: 12, fit: BoxFit.cover),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> onAvatarClick() async {
    bool isGranted = await PermissionHelper().checkPermission(Permission.storage);

    if (isGranted) {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

      if (result != null && result.files.isNotEmpty && result.files.single.path != null) {
        setState(() => imageFile = File(result.files.single.path!));
      }
    }
  }
}
