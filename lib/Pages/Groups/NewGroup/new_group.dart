import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark/Config/images.dart';
import 'package:sampark/Controller/contact_controller.dart';
import 'package:sampark/Controller/group_controller.dart';
import 'package:sampark/Pages/Groups/NewGroup/group_title.dart';
import 'package:sampark/Pages/Groups/NewGroup/selected_members_list.dart';
import 'package:sampark/Pages/Home/Widgets/chat_title.dart';

class NewGroup extends StatelessWidget {
  const NewGroup({super.key});

  @override
  Widget build(BuildContext context) {
    ContactController contactController = Get.put(ContactController());
    GroupController groupController = Get.put(GroupController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tạo nhóm mới", style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),),
      ),
      floatingActionButton: Obx(
        () => FloatingActionButton(
          backgroundColor: groupController.groupMembers.isEmpty
              ? Colors.grey
              : Theme.of(context).colorScheme.primary,
          onPressed: () {
            if (groupController.groupMembers.isEmpty) {
              Get.snackbar("Lỗi", "Vui lòng chọn thành viên cho nhóm");
            } else {
              Get.to(const GroupTitle());
            }
          },
          child: Icon(
            Icons.arrow_forward,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SelectedMembers(),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Người dùng trong Sampark",
                  style: Theme.of(context).textTheme.labelMedium,
                )
              ],
            ),
            Expanded(
              child: StreamBuilder(
                stream: contactController.getContacts(),
                builder: (contact, snapshot) {
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
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            groupController.selectMember(snapshot.data![index]);
                          },
                          child: ChatTitle(
                              imageUrl: snapshot.data![index].profileImage ??
                                  AssetsImage.defaultProfileUrl,
                              name: snapshot.data![index].name!,
                              lastChat: snapshot.data![index].about ?? "",
                              lastTime: ""),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
