import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark/Config/images.dart';
import 'package:sampark/Config/strings.dart';
import 'package:sampark/Pages/Auth/Widgets/forgot_password.dart';
import 'package:sampark/Widgets/primary_button.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(CupertinoIcons.clear),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                /// Image
                const Image(
                    image: AssetImage(AssetsImage.logo),
                    width: 120,
                    height: 120),
                const SizedBox(height: 32),

                /// Title & Subtitle
                const Text("Password Reset Email Sent",
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center),
                const SizedBox(height: 16),
                const Text(AppString.changePasswordSubTitle,
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Poppins",
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center),
                const SizedBox(height: 64),

                /// Buttons
                PrimaryButton(
                    btnName: "Xong",
                    icon: Icons.done_all_rounded,
                    onTap: () => Get.back()),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      Get.to(const ForgotPassword());
                    },
                    child: const Text(
                      'Gửi lại Email',
                      style: TextStyle(
                        color: Colors.grey, 
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
