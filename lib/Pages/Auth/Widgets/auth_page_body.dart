import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark/Pages/Auth/Widgets/login_form.dart';
import 'package:sampark/Pages/Auth/Widgets/sign_up_form.dart';

class AuthPageBody extends StatelessWidget {
  const AuthPageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    RxBool isLogin = true.obs;
    return Container(
      padding: const EdgeInsets.all(20),
      // height: 400,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primaryContainer),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            isLogin.value = true;
                          },
                          child: Container(
                            width: MediaQuery.sizeOf(context).width / 2.5,
                            child: Column(
                              children: [
                                Text(
                                  "Đăng nhập",
                                  style: isLogin.value
                                      ? Theme.of(context).textTheme.bodyLarge
                                      : Theme.of(context).textTheme.labelLarge,
                                ),
                                const SizedBox(height: 5),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: isLogin.value ? 100 : 0,
                                  height: 2,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            isLogin.value = false;
                          },
                          child: Container(
                            width: MediaQuery.sizeOf(context).width / 2.5,
                            child: Column(
                              children: [
                                Text(
                                  "Đăng ký",
                                  style: isLogin.value
                                      ? Theme.of(context).textTheme.labelLarge
                                      : Theme.of(context).textTheme.bodyLarge,
                                ),
                                const SizedBox(height: 5),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: isLogin.value ? 0 : 100,
                                  height: 2,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                Obx(() => isLogin.value ? const LoginForm() : const SignUpForm())
              ],
            ),
          )
        ],
      ),
    );
  }
}
