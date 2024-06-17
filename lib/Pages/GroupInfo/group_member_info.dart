import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sampark/Controller/group_controller.dart';
import '../../../Config/images.dart';

class GroupMemberInfo extends StatelessWidget {
  const GroupMemberInfo({
    super.key,
    required this.profileImage,
    required this.userName,
    required this.userEmail,
    required this.groupId,
  });

  final String profileImage;
  final String userName;
  final String userEmail;
  final String groupId;

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 150,
                        height: 150,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              imageUrl: profileImage,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            )))
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userName,
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userEmail,
                      style: Theme.of(context).textTheme.labelLarge,
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).colorScheme.background),
                      child: Row(
                        children: [
                          SvgPicture.asset(AssetsImage.profileAudioCall,
                              width: 25),
                          const SizedBox(width: 10),
                          const Text("Call",
                              style: TextStyle(color: Color(0xff039C00)))
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).colorScheme.background),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AssetsImage.profileVideoCall,
                            width: 25,
                            color: const Color(0xffFF9900),
                          ),
                          const SizedBox(width: 10),
                          const Text("Video",
                              style: TextStyle(color: Color(0xffFF9900)))
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        // 1. Show a dialog to enter the user's email
                        final emailController = TextEditingController();
                        await Get.dialog(
                          AlertDialog(
                            backgroundColor: const Color(0xff343748),
                            title: const Text('Thêm thành viên', style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),),
                            content: TextField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                  hintText: 'Nhập email thành viên'),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Get.back(),
                                child: const Text('Hủy'),
                              ),
                              TextButton(
                                onPressed: () {
                                  final email = emailController.text.trim();
                                  if (email.isNotEmpty) {
                                    // 2. Call the controller function
                                    groupController.addMemberToGroup(
                                        groupId, email);
                                  }
                                  Get.back(); // Close the dialog
                                },
                                child: const Text('Thêm'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.background),
                        child: Row(
                          children: [
                            SvgPicture.asset(AssetsImage.groupAddUser,
                                color: Colors.white, width: 25),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "Thêm",
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
