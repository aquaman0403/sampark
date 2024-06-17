import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark/Config/strings.dart';
import 'package:sampark/Controller/auth_controller.dart';
import 'package:sampark/Pages/Auth/Widgets/reset_password.dart';
import 'package:sampark/Widgets/primary_button.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  final AuthController authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.clear),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Quên Mật Khẩu",
                style: TextStyle(
                  fontSize: 28,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                AppString.forgetPasswordSubTitle,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: "Poppins",
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 64),
              TextFormField(
                controller: _emailController,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
                keyboardType: TextInputType.emailAddress, // Set keyboard type
                decoration: const InputDecoration(
                  hintText: 'Nhập email của bạn',
                  prefixIcon: Icon(Icons.alternate_email_rounded),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập email';
                  }
                  if (!value.isEmail) {
                    return 'Vui lòng nhập một địa chỉ email hợp lệ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              Center( // Center the button
                child: PrimaryButton(
                  btnName: "Gửi Yêu Cầu", 
                  icon: Icons.send_rounded,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      authController.resetPassword(_emailController.text);
                      _handleResetPassword(_emailController.text);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleResetPassword(String email) {
    Get.off(() => const ResetPassword()); 
  }
}
