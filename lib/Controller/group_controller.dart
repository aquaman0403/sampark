import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sampark/Controller/profile_controller.dart';
import 'package:sampark/Model/chat_model.dart';
import 'package:sampark/Model/chat_room_model.dart';
import 'package:sampark/Model/group_model.dart';
import 'package:sampark/Model/user_model.dart';
import 'package:sampark/Pages/Home/home_page.dart';
import 'package:uuid/uuid.dart';

class GroupController extends GetxController {
  RxList<UserModel> groupMembers = <UserModel>[].obs;
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  var uuid = const Uuid();
  RxBool isLoading = false.obs;
  RxString selectedImagePath = "".obs;
  RxList<GroupModel> groupList = <GroupModel>[].obs;
  ProfileController profileController = Get.put(ProfileController());
  RxList<ChatRoomModel> chatRoomList = <ChatRoomModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getGroup();
  }

  void selectMember(UserModel user) {
    if (groupMembers.contains(user)) {
      groupMembers.remove(user);
    } else {
      groupMembers.add(user);
    }
  }

  Future<void> createGroup(String groupName, String imagePath) async {
    isLoading.value = true;
    String groupId = uuid.v6();
    groupMembers.add(UserModel(
        id: auth.currentUser!.uid,
        name: profileController.currentUser.value.name,
        email: profileController.currentUser.value.email,
        profileImage: profileController.currentUser.value.profileImage,
        role: "admin"));
    try {
      String imageUrl = await profileController.uploadFileToFirebase(imagePath);
      await db.collection("groups").doc(groupId).set({
        "id": groupId,
        "name": groupName,
        "profile": imageUrl,
        "members": groupMembers.map((e) => e.toJson()).toList(),
        "createAt": DateTime.now().toString(),
        "createdBy": auth.currentUser!.uid,
        "timestamp": DateTime.now().toString(),
      });
      getGroup();
      Get.snackbar("Nhóm đã được tạo", "Nhóm đã được tạo thành công");
      Get.offAll(const HomePage());
      isLoading.value = false;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getGroup() async {
    isLoading.value = true;
    List<GroupModel> tempGroup = [];
    await db.collection("groups").get().then((value) {
      tempGroup = value.docs.map((e) => GroupModel.fromJson(e.data())).toList();
    });
    groupList.clear();
    groupList.value = tempGroup
        .where(
          (e) =>
              e.members!.any((element) => element.id == auth.currentUser!.uid),
        )
        .toList();
    isLoading.value = false;
  }

  Future<void> sendGroupMessage(
      String message, String groupId, String imagePath) async {
    isLoading.value = true;
    var chatId = uuid.v6();
    String imageUrl =
        await profileController.uploadFileToFirebase(selectedImagePath.value);
    var newChat = ChatModel(
      id: chatId,
      message: message,
      imageUrl: imageUrl,
      senderId: auth.currentUser!.uid,
      senderImageUrl: profileController.currentUser.value.profileImage,
      senderName: profileController.currentUser.value.name,
      timestamp: DateTime.now().toString(),
    );
    await db
        .collection("groups")
        .doc(groupId)
        .collection("messages")
        .doc(chatId)
        .set(newChat.toJson());

    selectedImagePath.value = "";
    isLoading.value = false;
  }

  Stream<List<ChatModel>> getGroupMessages(String groupId) {
    return db
        .collection("groups")
        .doc(groupId)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatModel.fromJson(doc.data()))
            .toList());
  }

  Future<void> addMemberToGroup(String groupId, String userEmail) async {
    isLoading.value = true;
    try {
      final userQuery = await db
          .collection("users")
          .where("email", isEqualTo: userEmail)
          .get();

      if (userQuery.docs.isEmpty) {
        Get.snackbar("Error", "User not found");
        return;
      }
      final user = UserModel.fromJson(userQuery.docs.first.data());
      final groupDoc = await db.collection("groups").doc(groupId).get();
      final groupData = groupDoc.data();
      if (groupData != null) {
        final members = groupData['members'] as List<dynamic>;
        if (members.any((member) => (member['id'] as String) == user.id)) {
          Get.snackbar("User already in group",
              "The user is already a member of this group.");
          return;
        }
      }
      await db.collection("groups").doc(groupId).update({
        "members": FieldValue.arrayUnion([user.toJson()]),
      });
      getGroup();
      Get.snackbar("Success", "User added to group");
    } catch (e) {
      Get.snackbar("Error", "Failed to add user to group");
    } finally {
      isLoading.value = false;
    }
  }
}
