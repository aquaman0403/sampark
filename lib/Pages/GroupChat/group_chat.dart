import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sampark/Config/images.dart';
import 'package:sampark/Controller/chat_controller.dart';
import 'package:sampark/Controller/group_controller.dart';
import 'package:sampark/Controller/profile_controller.dart';
import 'package:sampark/Model/group_model.dart';
import 'package:sampark/Pages/Chat/Widgets/chat_bubble.dart';
import 'package:sampark/Pages/GroupChat/Widget/group_type_message.dart';
import 'package:sampark/Pages/GroupInfo/group_info.dart';

import '../Call/VideoConferencePage.dart';

class GroupChatPage extends StatelessWidget {
  const GroupChatPage({
    super.key,
    required this.groupModel,
  });

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    GroupController groupController = Get.put(GroupController());
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Get.to(GroupInfo(groupModel: groupModel));
          },
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  imageUrl: groupModel.profileUrl != null && groupModel.profileUrl!.isNotEmpty
                      ? groupModel.profileUrl!
                      : AssetsImage.defaultProfileUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
        ),
        title: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            // Điều hướng đến trang thông tin người dùng nếu cần
          },
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    groupModel.name ?? "Group Name",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    "Online",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(onPressed: () {
            Get.to(VideoConferencePage(target: groupModel));
          }, icon: const Icon(Icons.phone_rounded)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.video_call_rounded)),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  StreamBuilder(
                    stream: groupController.getGroupMessages(groupModel.id!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("Error: ${snapshot.error}"),
                        );
                      }
                      if (snapshot.data == null) {
                        return const Center(
                          child: Text("No Messages"),
                        );
                      } else {
                        return ListView.builder(
                          reverse: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            DateTime timestamp = DateTime.parse(snapshot.data![index].timestamp!);
                            String formattedTime = DateFormat('hh:mm a').format(timestamp);
                            bool isComing = snapshot.data![index].senderId != profileController.currentUser.value.id;

                            return ChatBubble(
                              message: snapshot.data![index].message!,
                              isComming: isComing,
                              time: formattedTime,
                              status: "read",
                              imageUrl: snapshot.data![index].imageUrl ?? "",
                              senderImageUrl: isComing
                                  ? snapshot.data![index].senderImageUrl ?? AssetsImage.defaultProfileUrl
                                  : profileController.currentUser.value.profileImage ?? AssetsImage.defaultProfileUrl,
                              senderName: isComing
                                  ? snapshot.data![index].senderName ?? "Unknown"
                                  : profileController.currentUser.value.name ?? "Unknown",
                            );
                          },
                        );
                      }
                    },
                  ),
                  Obx(
                        () => (groupController.selectedImagePath.value != "")
                        ? Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: FileImage(File(groupController.selectedImagePath.value)),
                                  fit: BoxFit.contain),
                              color: Theme.of(context).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            height: 500,
                          ),
                          Positioned(
                            right: 0,
                            child: IconButton(
                              onPressed: () {
                                groupController.selectedImagePath.value = "";
                              },
                              icon: const Icon(Icons.close),
                            ),
                          ),
                        ],
                      ),
                    )
                        : Container(),
                  ),
                ],
              ),
            ),
            GroupTypeMessage(
              groupModel: groupModel,
            ),
          ],
        ),
      ),
    );
  }
}
