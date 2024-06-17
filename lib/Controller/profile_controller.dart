import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:sampark/Model/user_model.dart';

class ProfileController extends GetxController {
  final auth = FirebaseAuth.instance;
  final database = FirebaseFirestore.instance;
  final isLoading = false.obs;
  final store = FirebaseStorage.instance;

  Rx<UserModel> currentUser = UserModel().obs;

  void onInit() async {
    super.onInit();
    await getUserDetails();
  }

  Future<void> getUserDetails() async {
    await database.collection("users").doc(auth.currentUser!.uid).get().then(
        (value) => {currentUser.value = UserModel.fromJson(value.data()!)});
  }

  Future<void> updateProfile(
      String imageUrl, String name, String about, String number) async {
    isLoading.value = true;
    try {
      final imageLink = await uploadFileToFirebase(imageUrl);
      final updateUser = UserModel(
          id: auth.currentUser!.uid,
          email: auth.currentUser!.email,
          name: name,
          about: about,
          profileImage: imageUrl == "" ? currentUser.value.profileImage : imageLink,
          phoneNumber: number);
      await database
          .collection("users")
          .doc(auth.currentUser!.uid)
          .set(updateUser.toJson());
      await getUserDetails();
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
  }

  Future<String> uploadFileToFirebase(String imagePath) async {
    final path = "files/$imagePath";
    final file = File(imagePath);
    if (imagePath != "") {
      try {
        final ref = store.ref().child(path).putFile(file);
        final uploadTask = await ref.whenComplete(() {});
        final downLoadImageUrl = await uploadTask.ref.getDownloadURL();
        print(downLoadImageUrl);
        return downLoadImageUrl;
      } catch (e) {
        print(e);
        return "";
      }
    }
    return "";
  }
}
