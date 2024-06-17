import 'package:flutter/material.dart';
import 'package:sampark/Pages/Auth/Widgets/auth_page_body.dart';
import 'package:sampark/Pages/Welcome/Widgets/welcome_heading.dart';

import '../../Config/strings.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                WelcomeHeading(),
                Text(AppString.appName,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFFF9900))),
                SizedBox(height: 60),
                AuthPageBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
