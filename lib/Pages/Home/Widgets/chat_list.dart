import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark/Config/images.dart';
import 'package:sampark/Controller/contact_controller.dart';
import 'package:sampark/Controller/profile_controller.dart';
import 'package:sampark/Pages/Chat/chat_page.dart';
import 'package:sampark/Pages/Home/Widgets/chat_title.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    ContactController contactController = Get.put(ContactController());
    ProfileController profileController = Get.put(ProfileController());
    return RefreshIndicator(
        child: Obx(() => ListView(
            children: contactController.chatRoomList
                .map(
                  (e) => InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Get.to(ChatPage(
                          userModel: (e.receiver!.id ==
                                  profileController.currentUser.value.id
                              ? e.sender
                              : e.receiver)!));
                    },
                    child: ChatTitle(
                      imageUrl: (e.receiver!.id ==
                                  profileController.currentUser.value.id
                              ? e.sender!.profileImage
                              : e.receiver!.profileImage) ??
                          AssetsImage.defaultProfileUrl,
                      name: (e.receiver!.id ==
                              profileController.currentUser.value.id
                          ? e.sender!.name
                          : e.receiver!.name)!,
                      lastChat: e.lastMessage ?? "Last Message",
                      lastTime: e.lastMessageTimestamp ?? "Last Time",
                    ),
                  ),
                )
                .toList())),
        onRefresh: () {
          return contactController.getChatRoomList();
        });
  }
}
