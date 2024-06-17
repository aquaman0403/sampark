import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark/Config/images.dart';
import 'package:sampark/Controller/group_controller.dart';
import 'package:sampark/Pages/GroupChat/group_chat.dart';
import 'package:sampark/Pages/Home/Widgets/chat_title.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
    return Obx(
      () => ListView(
        children: groupController.groupList
            .map((group) => InkWell(
                  onTap: () {
                    Get.to(GroupChatPage(groupModel: group));
                  },
                  child: ChatTitle(
                    name: group.name ?? "Unnamed Group",
                    imageUrl:
                        group.profileUrl != null && group.profileUrl!.isNotEmpty
                            ? group.profileUrl!
                            : AssetsImage.defaultProfileUrl,
                    lastChat: "Group Created",
                    lastTime: "Just now",
                  ),
                ))
            .toList(),
      ),
    );
  }
}
