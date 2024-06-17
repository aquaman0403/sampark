import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sampark/Model/user_model.dart';
import '../../../Config/images.dart';
import '../../../Controller/call_controller.dart';
import '../../../Controller/profile_controller.dart';
import '../../Call/audio_call_page.dart';
import '../../Call/video_call.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    super.key,
    required this.profileImage,
    required this.userName,
    required this.userEmail,
    required this.userModel,
  });

  final String profileImage;
  final String userName;
  final String userEmail;
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    CallController callController = Get.put(CallController());
    ProfileController profileController = Get.put(ProfileController());
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
                    SizedBox(
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
                      child: InkWell(
                        onTap: () {
                          Get.to(AudioCallPage(target: userModel));
                          callController.callAction(
                              userModel, profileController.currentUser.value, "audio");
                        },
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
                    ),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).colorScheme.background),
                      child: InkWell(
                        onTap: () {
                          Get.to(VideoCallPage(target: userModel));
                          callController.callAction(
                              userModel, profileController.currentUser.value, "video");
                        },
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
                    ),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).colorScheme.background),
                      child: Row(
                        children: [
                          SvgPicture.asset(AssetsImage.appIconSVG, width: 25),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text("Chat",
                              style: TextStyle(color: Color(0xff0057FF)))
                        ],
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
