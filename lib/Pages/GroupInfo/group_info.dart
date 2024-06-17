  import 'package:flutter/material.dart';
  import 'package:sampark/Config/images.dart';
  import 'package:sampark/Model/group_model.dart';
  import 'package:sampark/Pages/GroupInfo/group_member_info.dart';
  import 'package:sampark/Pages/Home/Widgets/chat_title.dart';

  class GroupInfo extends StatelessWidget {
    const GroupInfo({super.key, required this.groupModel});
    final GroupModel groupModel;

    @override
    Widget build(BuildContext context) {
      // Provide default values in case of null
      final String groupName = groupModel.name ?? "Unnamed Group";
      final String groupId = groupModel.id ?? ""; 
      final String profileUrl = groupModel.profileUrl == "" 
          ? AssetsImage.defaultProfileUrl 
          : groupModel.profileUrl ?? AssetsImage.defaultProfileUrl; // Double-check for null
      final String description = groupModel.description ?? "No description available";
      
      return Scaffold(
        appBar: AppBar(
          title: Text(groupName, style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w500,
          )),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              GroupMemberInfo(
                groupId: groupId,
                profileImage: profileUrl,
                userName: groupName,
                userEmail: description,
              ),
              const SizedBox(height: 20),
              Text(
                "Thành viên",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 10),
              if (groupModel.members != null)
                Column(
                  children: groupModel.members!.map((member) {
                    final String memberName = member.name ?? "Unknown Member";
                    final String memberImage = member.profileImage ?? AssetsImage.defaultProfileUrl;
                    return ChatTitle(
                      imageUrl: memberImage,
                      name: memberName,
                      lastChat: member.email ?? "", // Handle null email
                      lastTime: member.role == "admin" ? "Admin" : "User",
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      );
    }
  }
