import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark/Controller/auth_controller.dart';
import 'package:sampark/Widgets/primary_button.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController confirmPassword = TextEditingController();

    // State variables
    var isObscure = true.obs;
    var showError = false.obs;

    return Column(
      children: [
        const SizedBox(height: 40),
        TextField(
          controller: name,
          style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.w400
              ),
          decoration: const InputDecoration(
            hintText: "Họ và tên",
            hintStyle: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Color(0xff9E9E9E),
                fontWeight: FontWeight.w400
              ),
            prefixIcon: Icon(Icons.person_rounded),
          ),
        ),
        const SizedBox(height: 30),
        TextField(
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
        ),
        const SizedBox(height: 30),
        Obx(
          () => TextField(
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
                icon: Icon(isObscure.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined),
                onPressed: () => isObscure.value = !isObscure.value,
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        Obx(
          () => TextField(
            controller: confirmPassword,
            style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.w400
              ),
            obscureText: isObscure.value,
            decoration: InputDecoration(
              hintText: "Xác nhận mật khẩu",
              hintStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Color(0xff9E9E9E),
                fontWeight: FontWeight.w400
              ),
              prefixIcon: const Icon(Icons.password_rounded),
              suffixIcon: IconButton(
                icon: Icon(isObscure.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined),
                onPressed: () => isObscure.value = !isObscure.value,
              ),
              errorText: showError.value ? 'Mật khẩu không khớp' : null,
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
                      onTap: () async {
                        if (password.text != confirmPassword.text) {
                          showError.value = true;
                          return;
                        }
                        showError.value = false;
                        authController.createUser(
                            email.text, password.text, name.text);
                      },
                      btnName: 'Đăng ký',
                      icon: Icons.lock_open_rounded,
                    ),
                  ],
                ),
        )
      ],
    );
  }
}
