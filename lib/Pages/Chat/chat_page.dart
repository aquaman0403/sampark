import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sampark/Config/images.dart';
import 'package:sampark/Controller/call_controller.dart';
import 'package:sampark/Controller/chat_controller.dart';
import 'package:sampark/Controller/profile_controller.dart';
import 'package:sampark/Model/user_model.dart';
import 'package:sampark/Pages/Call/audio_call_page.dart';
import 'package:sampark/Pages/Call/video_call.dart';
import 'package:sampark/Pages/Chat/Widgets/chat_bubble.dart';
import 'package:sampark/Pages/UserProfile/user_proflie_page.dart';

import 'Widgets/type_message.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    super.key,
    required this.userModel,
  });

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    ProfileController profileController = Get.put(ProfileController());
    CallController callController = Get.put(CallController());
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Get.to(UserProfilePage(
              userModel: userModel,
            ));
          },
          child: Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageUrl:
                    userModel.profileImage ?? AssetsImage.defaultProfileUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                  ),
                ),
              )),
        ),
        title: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Get.to(UserProfilePage(
              userModel: userModel,
            ));
          },
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userModel.name ?? "User",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  StreamBuilder(
                      stream: chatController.getStatus(userModel.id!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text("........");
                        } else {
                          return Text(
                            snapshot.data!.status ?? "",
                            style: TextStyle(
                              fontSize: 12,
                              color: snapshot.data!.status == "Online"
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                          );
                        }
                      })
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(AudioCallPage(target: userModel));
                callController.callAction(
                    userModel, profileController.currentUser.value, "audio");
              },
              icon: const Icon(Icons.phone_rounded)),
          IconButton(
              onPressed: () {
                Get.to(VideoCallPage(target: userModel));
                callController.callAction(
                    userModel, profileController.currentUser.value, "video");
              },
              icon: const Icon(Icons.video_call_rounded))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Padding(
          padding:
          const EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    StreamBuilder(
                      stream: chatController.getMessages(userModel.id!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                              DateTime timestamp = DateTime.parse(
                                  snapshot.data![index].timestamp!);
                              String fomarttedTime =
                              DateFormat('hh:mm a').format(timestamp);
                              bool isComming = snapshot.data![index].receiverId ==
                                  profileController.currentUser.value.id;
                              return ChatBubble(
                                  message: snapshot.data![index].message!,
                                  isComming: isComming,
                                  time: fomarttedTime,
                                  status: "read",
                                  imageUrl:
                                  snapshot.data![index].imageUrl ?? "",
                                  senderImageUrl: isComming
                                      ? userModel.profileImage ?? AssetsImage.defaultProfileUrl
                                      : profileController.currentUser.value.profileImage ?? AssetsImage.defaultProfileUrl,
                                  senderName: ""
                              );
                            },
                          );
                        }
                      },
                    ),
                    Obx(() => (chatController.selectedImagePath.value != "")
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
                                  image: FileImage(File(chatController
                                      .selectedImagePath.value)),
                                  fit: BoxFit.contain),
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            height: 500,
                          ),
                          Positioned(
                              right: 0,
                              child: IconButton(
                                onPressed: () {
                                  chatController.selectedImagePath.value =
                                  "";
                                },
                                icon: const Icon(Icons.close),
                              )),
                        ],
                      ),
                    )
                        : Container()),
                  ],
                ),
              ),
              TypeMessage(
                userModel: userModel,
              ),
            ],
          )),
    );
  }
}
