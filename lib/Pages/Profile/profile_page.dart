import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sampark/Controller/profile_controller.dart';
import 'package:sampark/Controller/status_controller.dart';
import 'package:sampark/Widgets/primary_button.dart';

import '../../Controller/auth_controller.dart';
import '../../Controller/image_picker.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    RxBool isEdit = false.obs;
    ProfileController profileController = Get.put(ProfileController());
    TextEditingController name =
        TextEditingController(text: profileController.currentUser.value.name);
    TextEditingController email =
        TextEditingController(text: profileController.currentUser.value.email);
    TextEditingController phone = TextEditingController(
        text: profileController.currentUser.value.phoneNumber);
    TextEditingController about =
        TextEditingController(text: profileController.currentUser.value.about);
    ImagePickerController imagePickerController =
        Get.put(ImagePickerController());
    RxString imagePath = "".obs;
    StatusController statusController = Get.put(StatusController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
              onPressed: () {
                authController.logoutUser();
              },
              icon: const Icon(Icons.logout_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(() => isEdit.value
                                ? InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      imagePath.value =
                                          await imagePickerController
                                              .pickImage(ImageSource.gallery);
                                    },
                                    child: Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: imagePath.value == ""
                                          ? const Icon(Icons.add)
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: Image.file(
                                                  File(imagePath.value),
                                                  fit: BoxFit.cover),
                                            ),
                                    ))
                                : Container(
                                    height: 200,
                                    width: 200,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: profileController.currentUser.value
                                                    .profileImage ==
                                                "" ||
                                            profileController.currentUser.value
                                                    .profileImage ==
                                                null
                                        ? const Icon(Icons.image)
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: CachedNetworkImage(
                                              imageUrl: profileController
                                                  .currentUser
                                                  .value
                                                  .profileImage!,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  const CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            )),
                                  ))
                          ],
                        ),
                        const SizedBox(height: 20),
                        Obx(
                          () => TextField(
                            enabled: isEdit.value,
                            controller: name,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              filled: isEdit.value,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              labelText: "Họ và tên",
                              labelStyle: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              prefixIcon: const Icon(Icons.person_rounded),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Obx(
                          () => TextField(
                            enabled: isEdit.value,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            controller: about,
                            decoration: InputDecoration(
                              filled: isEdit.value,
                              labelText: "Mô tả",
                              labelStyle: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              prefixIcon: const Icon(Icons.info_rounded),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          enabled: isEdit.value,
                          controller: email,
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          decoration: const InputDecoration(
                            filled: false,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            labelText: "Email",
                            labelStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            prefixIcon: Icon(Icons.alternate_email_rounded),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Obx(
                          () => TextField(
                            enabled: isEdit.value,
                            controller: phone,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              filled: isEdit.value,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              labelText: "Số điện thoại",
                              labelStyle: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              prefixIcon: const Icon(Icons.phone_rounded),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () => isEdit.value
                                  ? PrimaryButton(
                                      btnName: "Lưu",
                                      icon: Icons.save,
                                      onTap: () async {
                                        await profileController.updateProfile(
                                            imagePath.value,
                                            name.text,
                                            about.text,
                                            phone.text);
                                        isEdit.value = false;
                                      })
                                  : PrimaryButton(
                                      btnName: "Tùy chỉnh",
                                      icon: Icons.edit,
                                      onTap: () {
                                        isEdit.value = true;
                                      }),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
