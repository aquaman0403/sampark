import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark/Controller/chat_controller.dart';
import 'package:sampark/Controller/contact_controller.dart';
import 'package:sampark/Controller/profile_controller.dart';
import 'package:sampark/Pages/Chat/chat_page.dart';
import 'package:sampark/Pages/Contact/Widgets/new_contact_title.dart';
import 'package:sampark/Pages/Groups/NewGroup/new_group.dart';

import '../../Config/images.dart';
import '../Home/Widgets/chat_title.dart';
import 'Widgets/contact_search.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isSearchEnable = false.obs;
    ContactController contactController = Get.put(ContactController());
    ChatController chatController = Get.put(ChatController());
    ProfileController profileController = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chọn liên hệ",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Obx(() => IconButton(
                onPressed: () {
                  isSearchEnable.value = !isSearchEnable.value;
                },
                icon: isSearchEnable.value
                    ? const Icon(Icons.close)
                    : const Icon(Icons.search),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Obx(
              () => isSearchEnable.value
                  ? const ContactSearch()
                  : const SizedBox(),
            ),
            const SizedBox(height: 10),
            NewContactTitle(
              btnName: "Liên hệ mới",
              icon: Icons.person_add,
              onTap: () {},
            ),
            const SizedBox(height: 10),
            NewContactTitle(
              btnName: "Nhóm mới",
              icon: Icons.group_add,
              onTap: () {
                Get.to(const NewGroup());
              },
            ),
            const SizedBox(height: 10),
            const Row(
              children: [Text("Người dùng trong Sampark", style: TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.w500))],
            ),
            const SizedBox(height: 10),
            Obx(() => Column(
                children: contactController.userList
                    .map(
                      (e) => InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          Get.to(ChatPage(userModel: e));
                        },
                        child: ChatTitle(
                          imageUrl:
                              e.profileImage ?? AssetsImage.defaultProfileUrl,
                          name: e.name ?? "Người dùng",
                          lastChat: e.about ?? "Chưa có tin nhắn",
                          lastTime:
                              e.email == chatController.auth.currentUser!.email
                                  ? "Bạn"
                                  : "",
                        ),
                      ),
                    )
                    .toList()))
          ],
        ),
      ),
    );
  }
}
