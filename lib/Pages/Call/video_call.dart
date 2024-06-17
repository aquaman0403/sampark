import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark/Config/strings.dart';
import 'package:sampark/Controller/chat_controller.dart';
import 'package:sampark/Controller/profile_controller.dart';
import 'package:sampark/Model/user_model.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoCallPage extends StatelessWidget {
  const VideoCallPage({super.key, required this.target});
  final UserModel target;
  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    ChatController chatController = Get.put(ChatController());
    var callId = chatController.getRoomId(target.id!);
    return ZegoUIKitPrebuiltCall(
      appID: ZegoCloudConfig.appId,
      appSign: ZegoCloudConfig.appSign,
      userID: profileController.currentUser.value.id ?? "root",
      userName: profileController.currentUser.value.name ?? "root",
      callID: callId,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
