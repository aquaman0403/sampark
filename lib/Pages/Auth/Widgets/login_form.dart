import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark/Controller/auth_controller.dart';
import 'package:sampark/Pages/Auth/Widgets/forgot_password.dart';
import 'package:sampark/Widgets/primary_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();
    final AuthController authController = Get.put(AuthController());
    final RxBool isObscure = true.obs;
    final formKey = GlobalKey<FormState>();

    return Form( 
      key: formKey,
      child: Column(
        children: [
          const SizedBox(height: 40),
          TextFormField(
            controller: email,
            style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.w400
              ),
            decoration: const InputDecoration(
              hintText: "Email",
              hintStyle: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Color(0xff9E9E9E),
                fontWeight: FontWeight.w400
              ),
              prefixIcon: Icon(Icons.alternate_email_rounded),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập email của bạn';
              } 
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Vui lòng nhập email hợp lệ'; 
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          Obx(() => TextFormField(
            controller: password,
            style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.w400
              ),
            obscureText: isObscure.value,
            decoration: InputDecoration(
              hintText: "Mật khẩu",
              hintStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Color(0xff9E9E9E),
                fontWeight: FontWeight.w400
              ),
              prefixIcon: const Icon(Icons.password_rounded),
              suffixIcon: IconButton(
                icon: Icon(isObscure.value ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                onPressed: () => isObscure.value = !isObscure.value,
              ),
            ),
            validator: (value) { 
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập mật khẩu';
              }
              return null;
            },
          )),
          Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () {
                Get.to(const ForgotPassword());
              },
              child: const Text(
                'Quên mật khẩu?',
                style: TextStyle(
                  color: Colors.grey, 
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          const SizedBox(height: 60),
          Obx(
            () => authController.isLoading.value
                ? const CircularProgressIndicator()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PrimaryButton(
                        onTap: () {
                          if (formKey.currentState!.validate()) { 
                            authController.login(email.text, password.text);
                          }
                        },
                        btnName: 'Đăng nhập',
                        icon: Icons.lock_open_rounded,
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
