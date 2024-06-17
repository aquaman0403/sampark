import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark/Config/strings.dart';
import 'package:sampark/Model/group_model.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

import '../../Controller/profile_controller.dart';

class VideoConferencePage extends StatelessWidget {
  final GroupModel target;

  const VideoConferencePage({
    super.key,
    required this.target,
  });

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    return SafeArea(
      child: ZegoUIKitPrebuiltVideoConference(
        appID: ZegoCloudConfigGroup.appId,
        appSign: ZegoCloudConfigGroup.appSign,
        userID: profileController.currentUser.value.id ?? "root",
        userName: profileController.currentUser.value.name ?? "root",
        conferenceID: target.id!,
        config: ZegoUIKitPrebuiltVideoConferenceConfig(),
      ),
    );
  }
}
