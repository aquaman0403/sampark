import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sampark/Controller/group_controller.dart';
import 'package:sampark/Controller/image_picker.dart';
import 'package:sampark/Model/group_model.dart';

import '../../../Config/images.dart';
import '../../../Widgets/imagePickerBottomSheet.dart';

class GroupTypeMessage extends StatelessWidget {
  const GroupTypeMessage({
    super.key,
    required this.groupModel,
  });

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    ImagePickerController imagePickerController =
        Get.put(ImagePickerController());
    GroupController groupController = Get.put(GroupController());
    RxString message = "".obs;
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Theme.of(context).colorScheme.primaryContainer),
      child: Row(
        children: [
          SizedBox(
              height: 30,
              width: 30,
              child: SvgPicture.asset(
                AssetsImage.chatEmoji,
                width: 25,
              )),
          Expanded(
            child: TextField(
              onChanged: (value) {
                message.value = value;
              },
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
              controller: messageController,
              decoration: InputDecoration(
                  filled: false, hintText: "Soạn tin nhắn ...",
                fillColor: Theme.of(context).colorScheme.primaryContainer,
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Obx(
            () => groupController.selectedImagePath.value == ""
                ? InkWell(
                    onTap: () {
                      ImagePickerBottomSheet(context, groupController.selectedImagePath, imagePickerController);
                    },
                    child: SizedBox(
                        height: 30,
                        width: 30,
                        child: SvgPicture.asset(
                          AssetsImage.chatGalsvg,
                          width: 25,
                        )),
                  )
                : const SizedBox(),
          ),
          const SizedBox(width: 10),
          Obx(() => message.value != "" ||
                  groupController.selectedImagePath.value != ""
              ? InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    groupController.sendGroupMessage(
                      messageController.text,
                      groupModel.id!,
                      "",
                    );
                    messageController.clear();
                    message.value = "";
                    
                  },
                  child: SizedBox(
                      height: 30,
                      width: 30,
                      child: groupController.isLoading.value
                          ? const CircularProgressIndicator()
                          : SvgPicture.asset(
                              AssetsImage.chatSendSvg,
                              width: 25,
                            )),
                )
              : SizedBox(
                  height: 30,
                  width: 30,
                  child: SvgPicture.asset(
                    AssetsImage.chatMicsvg,
                    width: 25,
                  ))),
        ],
      ),
    );
  }
}
