import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sampark/Model/user_model.dart';

class AuthController extends GetxController {
  final auth = FirebaseAuth.instance;
  final database = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAllNamed("/homePage");
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Lỗi khi đăng nhập", "Email hoặc mật khẩu không chính xác.");
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    isLoading.value = false;
  }

  Future<void> createUser(String email, String password, String name) async {
    isLoading.value = true;
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (kDebugMode) {
        print("Account Created!");
      }
      Get.offAllNamed("/homePage");
      await initUser(email, name);
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        Get.snackbar("Weak Password", "The password provided is too weak.");
      } else if (e.code == "email-already-in-use") {
        Get.snackbar("Email Already Exists",
            "The account already exists for that email.");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    isLoading.value = false;
  }

  Future<void> logoutUser() async {
    await auth.signOut();
    Get.offAllNamed("/authPage");
  }

  Future<void> resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> initUser(String email, String name) async {
    var newUser =
        UserModel(email: email, name: name, id: auth.currentUser!.uid);
    try {
      await database
          .collection("users")
          .doc(auth.currentUser!.uid)
          .set(newUser.toJson());
    } catch (ex) {
      if (kDebugMode) {
        print(ex);
      }
    }
  }
}
