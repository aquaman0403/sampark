import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplaceController extends GetxController {
  final auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    splaceHandle();
  }

  Future<void> splaceHandle() async {
    await Future.delayed(const Duration(seconds: 1));
    if (auth.currentUser == null) {
      Get.offAllNamed("/welcomePage");
    } else {
      Get.offAllNamed("/homePage");
    }
  }
}
