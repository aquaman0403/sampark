import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sampark/Controller/image_picker.dart';


import '../../../Config/images.dart';
import '../../../Controller/chat_controller.dart';
import '../../../Controller/emoji_controller.dart';
import '../../../Model/user_model.dart';
import '../../../Widgets/imagePickerBottomSheet.dart';

class TypeMessage extends StatelessWidget {
  const TypeMessage({
    super.key,
    required this.userModel,
  });

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    EmojiController emojiController = Get.put(EmojiController());
    ImagePickerController imagePickerController =
        Get.put(ImagePickerController());
    RxString message = "".obs;

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () {
          if (emojiController.isEmojiVisible.value) {
            emojiController.isEmojiVisible.value = false;
          } else {
            Navigator.pop(context);
          }
          return Future.value(false);
        },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Theme.of(context).colorScheme.primaryContainer),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    emojiController.isEmojiVisible.value =
                          !emojiController.isEmojiVisible.value;
                    emojiController.focusNode.unfocus();
                    emojiController.focusNode.canRequestFocus = true;
                  },
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: SvgPicture.asset(
                      AssetsImage.chatEmoji,
                      width: 25,
                    ),
                  ),
                ),
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
                    focusNode: emojiController.focusNode,
                    controller: emojiController.textEditingController,
                    decoration: InputDecoration(
                      filled: false,
                      hintText: "Soạn tin nhắn ...",
                      fillColor: Theme.of(context).colorScheme.primaryContainer,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => chatController.selectedImagePath.value == ""
                      ? InkWell(
                          onTap: () {
                            ImagePickerBottomSheet(
                                context,
                                chatController.selectedImagePath,
                                imagePickerController);
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
                        chatController.selectedImagePath.value != ""
                    ? InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          if (emojiController.textEditingController.text.isNotEmpty ||
                              chatController.selectedImagePath.value.isNotEmpty) {
                            chatController.sendMessage(
                                userModel.id!, emojiController.textEditingController.text, userModel);
                            emojiController.textEditingController.clear();
                            message.value = "";
                          }
                        },
                        child: SizedBox(
                            height: 30,
                            width: 30,
                            child: chatController.isLoading.value
                                ? const CircularProgressIndicator()
                                : SvgPicture.asset(
                                    AssetsImage.chatSendSvg,
                                    width: 25,
                                  )),
                      )
                    : InkWell(
                      child: SizedBox(
                          height: 30,
                          width: 30,
                          child: SvgPicture.asset(
                            AssetsImage.chatMicsvg,
                            width: 25,
                          )),
                    )),
              ],
            ),
          ),
          Obx(() => Offstage(
                offstage: !emojiController.isEmojiVisible.value,
                child: SizedBox(
                  height: 300,
                  child: EmojiPicker(
                    onEmojiSelected: (category, emoji) {
                      emojiController.textEditingController.text =
                          emojiController.textEditingController.text + emoji.emoji;
                    },
                    onBackspacePressed: () {},
                    config: const Config(
                      emojiViewConfig: EmojiViewConfig(
                        columns: 8,
                        verticalSpacing: 0,
                        horizontalSpacing: 0,
                        recentsLimit: 28,
                        buttonMode: ButtonMode.MATERIAL,
                      ),
                      swapCategoryAndBottomBar: false,
                      skinToneConfig: SkinToneConfig(),
                      categoryViewConfig: CategoryViewConfig(),
                      bottomActionBarConfig: BottomActionBarConfig(),
                      searchViewConfig: SearchViewConfig(),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
