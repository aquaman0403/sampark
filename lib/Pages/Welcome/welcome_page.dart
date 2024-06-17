import 'package:flutter/material.dart';
import 'package:sampark/Pages/Welcome/Widgets/welcome_body.dart';
import 'package:sampark/Pages/Welcome/Widgets/welcome_footer_button.dart';
import 'package:sampark/Pages/Welcome/Widgets/welcome_heading.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              WelcomeHeading(),
              WelcomeBody(),
              WelcomeFooterButton(),
            ],
          ),
        ),
      ),
    );
  }
}