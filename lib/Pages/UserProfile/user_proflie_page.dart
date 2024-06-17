import 'package:flutter/material.dart';
import 'package:sampark/Config/images.dart';
import 'package:sampark/Model/user_model.dart';
import 'package:sampark/Pages/UserProfile/Widgets/user_info.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Hồ sơ người dùng", style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.w500
          ),),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              UserInfo(
                profileImage:
                    userModel.profileImage ?? AssetsImage.defaultProfileUrl,
                userName: userModel.name ?? "User",
                userEmail: userModel.email ?? "",
                userModel: userModel,
              ),
              const Spacer(),
            ],
          ),
        ));
  }
}
